---
description: Review and address PR feedback for the current branch
---

# Address PR Feedback

Review PR feedback, make requested changes, commit, push, and reply to reviewers.

## Usage

- `/pr-feedback` — Auto-detect the PR from the current branch
- `/pr-feedback 123` — Address feedback on PR #123

## Instructions

### Step 1: Identify the PR

If `$ARGUMENTS` is provided and non-empty, use it as the PR number. Otherwise, detect it:

```bash
gh pr list --head "$(git branch --show-current)" --json number --jq '.[0].number'
```

If no PR is found, tell the user and stop.

### Step 2: Get current user and repo

```bash
gh api user --jq '.login'
gh repo view --json nameWithOwner --jq '.nameWithOwner'
```

Split `nameWithOwner` into `{owner}` and `{repo}`.

### Step 3: Fetch all feedback

Fetch all three comment types in parallel:

**Inline review comments** (comments on specific code lines):
```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments --paginate
```
Relevant fields: `id`, `path`, `line` (or `original_line`), `body`, `user.login`, `in_reply_to_id`

**Top-level conversation comments** (general PR discussion):
```bash
gh api repos/{owner}/{repo}/issues/{number}/comments --paginate
```

**Review summaries** (approve/request-changes body text):
```bash
gh pr view {number} --json reviews --jq '.reviews[] | {author: .author.login, state: .state, body: .body}'
```

### Step 4: Filter and group

- **Exclude** comments from the current user (own comments)
- **Exclude** comments from bot accounts (login ending in `[bot]` or `app/` prefix)
- **Group** inline review comment threads using `in_reply_to_id` — show only the latest unaddressed message per thread
- **Exclude** review summaries with empty bodies (approvals with no text)

### Step 5: Categorise feedback

For each comment/thread, categorise as:

| Category | Criteria |
|----------|----------|
| **Actionable** | Requests a code change, fix, rename, refactor, or addition |
| **Question** | Asks for clarification or explanation (may need a reply, not a code change) |
| **Informational** | FYI, praise, acknowledgement, or already-resolved feedback |

### Step 6: Present summary and ask user

Display a summary table of all feedback grouped by category:

```
## PR #123 Feedback Summary

### Actionable (3)
1. [inline] `src/foo.rb:42` — @reviewer: "Rename this variable for clarity" (comment #111)
2. [inline] `src/bar.rb:10` — @reviewer: "Add nil check here" (comment #222)
3. [review] @reviewer (CHANGES_REQUESTED): "Please add tests for the new endpoint"

### Questions (1)
4. [top-level] @reviewer: "Why did you choose this approach?" (comment #333)

### Informational (1)
5. [inline] `src/baz.rb:5` — @reviewer: "Nice refactor!" (comment #444)
```

Ask the user: **"Which items would you like to address? (e.g., 1,2,3 or 'all actionable')"**

Do NOT make any code changes until the user confirms.

### Step 7: Address selected items

For each selected item:
- Read the relevant file and surrounding context
- Make the requested code change
- For questions, draft a reply (confirm with user if the answer isn't obvious)

### Step 8: Commit and push

After all changes are made:

1. Stage changed files (specific files, not `git add -A`)
2. Create a single commit with a message summarising the addressed feedback, e.g.:
   ```
   fix: address PR review feedback

   - Rename variable for clarity (src/foo.rb)
   - Add nil check (src/bar.rb)
   - Add tests for new endpoint
   ```
3. Push to the remote branch:
   ```bash
   git push
   ```
   If push fails because the branch has no upstream, retry with:
   ```bash
   git push -u origin $(git branch --show-current)
   ```
4. Capture the commit SHA:
   ```bash
   git rev-parse HEAD
   ```

### Step 9: Reply to reviewers

For each addressed item, post a reply referencing the commit SHA.

**Inline review comments** — reply in the existing thread:
```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies -f body="Addressed in {sha}"
```

**Top-level conversation comments** — post a new issue comment:
```bash
gh api repos/{owner}/{repo}/issues/{number}/comments -f body="@{author} Addressed in {sha} — {brief description}"
```

**Review summaries** — post a new issue comment:
```bash
gh api repos/{owner}/{repo}/issues/{number}/comments -f body="@{author} Addressed your review feedback in {sha}"
```

If a reply fails, log the failure but continue with remaining replies.

### Step 10: Final report

Print a summary:

```
## PR Feedback — Done

**Commit**: {sha}
**Pushed to**: {branch}

### Addressed
- [x] #1 — Renamed variable (src/foo.rb) — replied to comment #111
- [x] #2 — Added nil check (src/bar.rb) — replied to comment #222
- [x] #3 — Added tests — replied to review

### Skipped
- #4 — Question (user chose not to address)
- #5 — Informational

### Reply Failures
- (none)
```

## Edge Cases

- **No PR found**: Tell the user and stop
- **No comments on PR**: Tell the user "No feedback to address" and stop
- **No actionable feedback**: Show the summary but note nothing requires code changes; offer to reply to questions
- **Push failure**: Retry with `-u` flag; if still failing, show the error and let the user resolve
- **Reply failure**: Log and continue — don't block on GitHub API errors
