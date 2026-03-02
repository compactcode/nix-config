---
description: Rebase a stacked PR branch after its parent was squash-merged into the default branch
---

# Rebase Stacked PR

Rebase the current branch onto the default branch after a parent branch was squash-merged, avoiding duplicate-commit conflicts.

## Usage

- `/pr-rebase` — Auto-detect the parent branch
- `/pr-rebase feature-a` — Explicit parent branch name

## Instructions

### Step 1: Pre-flight checks

Ensure a clean working tree and fetch the latest refs:

```bash
git status --porcelain
```

If there are uncommitted changes, tell the user and stop.

```bash
git fetch origin
```

Detect the default branch:

```bash
gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
```

Save as `{default_branch}`. Save the current branch:

```bash
git branch --show-current
```

Save as `{branch_B}`.

### Step 2: Identify parent branch A

If `$ARGUMENTS` is provided and non-empty, use it as `{branch_A}`.

Otherwise, auto-detect:

1. Check B's open PR base branch:
   ```bash
   gh pr view --json baseRefName --jq '.baseRefName'
   ```
2. If the base is not `{default_branch}`, use it as `{branch_A}`.
3. If the base is `{default_branch}`, verify the branch was already squash-merged by checking for a merged PR:
   ```bash
   gh pr list --state merged --head "{branch_B}" --json number --jq '.[0].number'
   ```
   If this returns a result, the current branch was already merged — tell the user and stop.
4. If auto-detection fails, ask the user: **"What is the parent branch that was squash-merged?"**

Once `{branch_A}` is identified, verify it was actually merged:

```bash
gh pr list --state merged --head "{branch_A}" --json number,headRefOid --jq '.[0]'
```

If no merged PR is found for `{branch_A}`, warn the user and ask whether to proceed anyway.

### Step 3: Find old tip of A

Try each method in order until one succeeds:

1. Local ref:
   ```bash
   git rev-parse --verify refs/heads/{branch_A}
   ```

2. Remote ref:
   ```bash
   git rev-parse --verify refs/remotes/origin/{branch_A}
   ```

3. GitHub PR merge metadata:
   ```bash
   gh pr list --state merged --head "{branch_A}" --json headRefOid --jq '.[0].headRefOid'
   ```

4. If none work, ask the user: **"What is the commit SHA of the old tip of `{branch_A}`?"**

Verify the commit exists locally:

```bash
git cat-file -t {old_A_tip}
```

If it doesn't exist (e.g. the ref was fetched from GitHub API), try:

```bash
git fetch origin {old_A_tip}
```

Save as `{old_A_tip}`.

### Step 4: Preview and confirm

Show the commits that will be replayed:

```bash
git log --oneline {old_A_tip}..HEAD
```

Show the count:

```bash
git rev-list --count {old_A_tip}..HEAD
```

Ask the user: **"These {count} commits will be rebased onto `origin/{default_branch}`. Proceed?"**

Do NOT proceed until the user confirms.

### Step 5: Rebase

Run the rebase:

```bash
git rebase --onto origin/{default_branch} {old_A_tip} {branch_B}
```

If the rebase hits conflicts:
- Report which files have conflicts
- Tell the user to resolve them manually, then run `git rebase --continue`
- Stop execution — do not attempt to auto-resolve

### Step 6: Post-rebase verification

Show the new commit history:

```bash
git log --oneline origin/{default_branch}..HEAD
```

Show a diffstat against the default branch:

```bash
git diff --stat origin/{default_branch}..HEAD
```

### Step 7: Update PR base

Check if B has a PR that targets `{branch_A}`:

```bash
gh pr view --json baseRefName --jq '.baseRefName'
```

If the base is `{branch_A}` (not `{default_branch}`), update it:

```bash
gh pr edit --base {default_branch}
```

### Step 8: Force push

Ask the user: **"Push the rebased branch with `--force-with-lease`?"**

If confirmed:

```bash
git push --force-with-lease
```

### Step 9: Clean up

If `{branch_A}` still exists as a local branch, ask the user: **"Delete local branch `{branch_A}`?"**

If confirmed:

```bash
git branch -d {branch_A}
```

### Step 10: Final report

Print a summary:

```
## PR Rebase — Done

**Branch**: {branch_B}
**Rebased onto**: origin/{default_branch}
**Old parent tip**: {old_A_tip}
**Commits replayed**: {count}

### Actions taken
- [x] Rebased {branch_B} onto origin/{default_branch}
- [x] Updated PR base branch to {default_branch} (if applicable)
- [x] Force pushed to origin/{branch_B} (if applicable)
- [x] Deleted local branch {branch_A} (if applicable)
```

## Edge Cases

- **Dirty working tree**: Tell the user to commit or stash changes, then stop
- **No PR found for current branch**: Continue — the rebase doesn't require a PR to exist
- **Parent branch not merged**: Warn the user — they may be rebasing prematurely
- **Old tip not found by any method**: Ask the user for the SHA directly
- **Rebase conflicts**: Report conflicting files and stop — do not auto-resolve
- **Force push failure**: Show the error and let the user resolve
- **Branch A already deleted locally**: Skip the cleanup step
