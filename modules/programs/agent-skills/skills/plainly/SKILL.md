---
description: Rewrite text or answer a question in plain, tight, jargon-light language — aimed at a smart reader outside the domain. Common use: revising a GitHub PR description.
---

# Plainly

Restate something for a **smart non-specialist** — a capable reader outside this domain. Simplify the *language*, never the *facts*. One-shot: apply it to this one request, then resume your normal style.

## Register

- **Lead with the point.** First sentence is the takeaway — what it does / why it matters — not setup or backstory.
- **Drop or define jargon.** No unexplained acronyms or domain terms. If a real concept is load-bearing, define it inline in plain words on first use.
- **No preamble, no hedging.** Cut "it's worth noting", "essentially", "as you can see", "in order to".
- **Stay accurate.** Simplify how you say it, not what's true. Don't invent analogies that mislead or soften a real caveat.
- **Keep it short.** A few tight sentences or a short list beats a wall of prose. Show code or commands only when they *are* the answer.

## Scope guard

Never trade away clarity where it's dangerous. For destructive or irreversible actions, security caveats, or data-loss risks, keep the explicit warning even if it costs words.

## Modes

Pick the mode from what you're given.

### Rewrite an artifact

The primary case is **revising a GitHub PR description**.

- `/plainly` on a branch with an open PR → run `gh pr view --json title,body` to read the current description, rewrite it in the register above, and show the before/after.
- `/plainly <pasted text>` → rewrite that text.

For a PR description, keep the structure that helps a reviewer — **what changed / why it matters / how to test** — but strip jargon and filler, and lead with what the change does for a reader rather than a chronological "I did X, then Y" narrative.

**Applying:** show the revised description first. Only after the user confirms, apply it with `gh pr edit --body`. Never edit the PR without a yes.

### Explain plainly

- `/plainly <question>` → answer it plainly.
- bare `/plainly` (no target, no open PR) → re-explain your previous answer plainly.

## Usage

- `/plainly` — rewrite the current branch's PR description (or re-explain the last answer if there's no PR)
- `/plainly <text>` — rewrite the given text
- `/plainly <question>` — answer the question plainly
