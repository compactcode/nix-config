---
description: Rebase a stacked PR branch after its parent was squash-merged into the default branch
---

# Rebase Stacked PR

Rebase the current branch onto the default branch after one or more parent branches were squash-merged, avoiding duplicate-commit conflicts.

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

### Step 2: Identify commits owned by this PR

Use the GitHub PR API to determine which commits belong to the current PR. This is the source of truth — it works regardless of how the stack was constructed (linear, cherry-picked, or parallel branches).

```bash
gh pr view --json commits --jq '[.commits[].oid]'
```

Save as `{pr_commits}`.

If no PR exists for the current branch, fall back to Step 3 (legacy detection).

### Step 3: Find the rebase boundary

The goal is to find `{old_A_tip}` — the commit on the current branch just before the first PR-owned commit.

#### Method A: PR commit scope (preferred)

Using `{pr_commits}` from Step 2, find the earliest PR commit in the local history:

```bash
git log --oneline origin/{default_branch}..HEAD
```

Walk this list and identify the earliest commit whose SHA appears in `{pr_commits}`. The commit immediately before it is `{old_A_tip}`.

If the PR commits don't appear in the local log by SHA (e.g. after a previous rebase changed SHAs), match by commit message instead:

```bash
gh pr view --json commits --jq '[.commits[].messageHeadline]'
```

Compare against local commit messages to find the boundary.

#### Method B: Explicit parent branch (fallback)

If `$ARGUMENTS` is provided and non-empty, use it as `{branch_A}`.

Otherwise, auto-detect `{branch_A}`:

1. Check B's open PR base branch:
   ```bash
   gh pr view --json baseRefName --jq '.baseRefName'
   ```
2. If the base is not `{default_branch}`, use it as `{branch_A}`.
3. If the base is `{default_branch}`, check if the current branch itself was already squash-merged:
   ```bash
   gh pr list --state merged --head "{branch_B}" --json number --jq '.[0].number'
   ```
   If this returns a result, the current branch was already merged — tell the user and stop.
4. If auto-detection fails, ask the user: **"What is the parent branch that was squash-merged?"**

Once `{branch_A}` is identified, verify it was actually merged:

```bash
gh pr list --state merged --head "{branch_A}" --json number,headRefOid --jq '.[0]'
```

If no merged PR is found, warn the user and ask whether to proceed anyway.

**Find old tip of A** — try each method in order:

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

If not, fetch it:

```bash
git fetch origin {old_A_tip}
```

#### Validate ancestry before proceeding

**Always** validate that `{old_A_tip}` is an ancestor of HEAD before attempting the rebase:

```bash
git merge-base --is-ancestor {old_A_tip} HEAD && echo "is ancestor" || echo "not ancestor"
```

If `{old_A_tip}` is NOT an ancestor, the stack was built with parallel branches (separate branches sharing cherry-picked commits, not linear ancestry). In this case:

1. Check if multiple parent PRs in the stack were squash-merged by searching for related merged PRs:
   ```bash
   gh pr list --state merged --search "<keywords from PR title>" --json number,title,headRefName --jq '.[] | "\(.number) \(.headRefName) \(.title)"'
   ```

2. For each merged parent PR, its commits are already on `{default_branch}`. Walk the local commit log from oldest to newest and identify which commits are unique to the current PR by matching commit messages between local history and `{pr_commits}` from Step 2.

3. The boundary is the last local commit whose message does NOT appear in `{pr_commits}`.

**Do NOT attempt the rebase if ancestry validation fails** — resolve the correct `{old_A_tip}` first.

### Step 4: Preview and confirm

Show the commits that will be replayed vs dropped:

```bash
git log --oneline {old_A_tip}..HEAD
```

```bash
git rev-list --count {old_A_tip}..HEAD
```

Present a clear breakdown to the user:

```
Commits already on main (will be dropped):
  <list commits between merge_base and old_A_tip>

Commits to replay ({count}):
  <list commits between old_A_tip and HEAD>
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

Check if B has a PR that targets something other than `{default_branch}`:

```bash
gh pr view --json baseRefName --jq '.baseRefName'
```

If the base is not `{default_branch}`, update it:

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

Collect all local branches from merged parent PRs (there may be multiple in a multi-level stack). For each one that still exists locally, ask the user: **"Delete local branches from merged parents? {list}"**

If confirmed:

```bash
git branch -d {branch_name}
```

### Step 10: Final report

Print a summary:

```
## PR Rebase — Done

**Branch**: {branch_B}
**Rebased onto**: origin/{default_branch}
**Rebase boundary**: {old_A_tip}
**Commits replayed**: {count}
**Merged parents detected**: {list of merged parent PRs}

### Actions taken
- [x] Rebased {branch_B} onto origin/{default_branch}
- [x] Updated PR base branch to {default_branch} (if applicable)
- [x] Force pushed to origin/{branch_B} (if applicable)
- [x] Deleted local branches {list} (if applicable)
```

## Edge Cases

- **Dirty working tree**: Tell the user to commit or stash changes, then stop
- **No PR found for current branch**: Skip Step 2, use Step 3 Method B only
- **Parent branch not merged**: Warn the user — they may be rebasing prematurely
- **Old tip not found by any method**: Ask the user for the SHA directly
- **Old tip is not an ancestor of HEAD (parallel branches)**: Do not attempt rebase — use PR commit scope or commit message matching to find the correct boundary. Never blindly rebase when ancestry validation fails
- **Multi-level stack (multiple parents merged)**: Walk the full parent chain to find the most recent merged parent's last commit on the current branch
- **Rebase conflicts**: Report conflicting files and stop — do not auto-resolve
- **Force push failure**: Show the error and let the user resolve
- **Branch A already deleted locally**: Skip the cleanup step

