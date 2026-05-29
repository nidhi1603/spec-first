---
name: spec-reviewer
description: Pressure-test a spec, plan, PRD, design doc, or technical proposal for gaps, hidden assumptions, risks, and missing edge cases BEFORE any code is written. Use this skill whenever the user hands you a spec/plan/PRD/RFC and asks you to "review", "critique", "poke holes in", "pressure-test", "sanity-check", "red-team", or "find problems with" it — or whenever you're about to implement against a document and want to catch design flaws while they're still cheap to fix. Do NOT rubber-stamp the document or start implementing; produce a structured critique that surfaces what's missing, what's risky, and what's underspecified, then end with a clear verdict (ready / needs work / not ready).
---

# Spec Reviewer

A spec's job is to be wrong on paper instead of wrong in production. Your job is to find where it's wrong while fixing it still costs minutes, not weeks.

The failure mode you're fighting is the **agreeable review** — skimming a document, saying "looks good, a few small notes," and moving on. That's worthless. A good spec review is adversarial in service of the author: you're trying to break the plan now so reality doesn't break it later. Be direct. A flaw you spot and name is a gift; a flaw you politely skip past is a future incident.

## When to run this skill

Run it when:
- The user gives you a spec, plan, PRD, RFC, design doc, or technical proposal and asks for any kind of critical read.
- You're about to implement against a document and a flawed design would be expensive to unwind.
- A `SPEC.md` produced by `project-interrogator` is about to be approved and you want a second, adversarial pass.

Do NOT run it for:
- Code review (that's a different concern — review the implementation, not the plan).
- Documents the user wants copyedited or summarized, not critiqued.

## How to review

Read the whole document first. Then attack it along these axes. Don't mechanically fill every section — spend your effort where the document is weakest.

### 1. Completeness — what's missing?
The most dangerous problems are things the spec doesn't mention at all. Check for absent: users/stakeholders, success criteria, error/failure handling, data model, auth/permissions, scale assumptions, migration/rollback, observability, ownership/maintenance. For each gap, say *why it matters*, not just that it's missing.

### 2. Hidden assumptions — what's being taken for granted?
Specs smuggle in assumptions: "users will obviously…", an implied data volume, an assumed integration that exists, a dependency that's available. Surface them and ask whether they hold. Many specs collapse on a single unstated assumption.

### 3. Risks & failure modes — what breaks this?
Walk the unhappy paths. What happens at 100x scale? On the network failing mid-operation? With malicious or malformed input? With concurrent writes? When the third-party API is down or rate-limited? Name the specific scenario and whether the spec addresses it.

### 4. Scope coherence — does it hang together?
Is the scope internally consistent? Does the stated goal match what's actually being built? Are there non-goals creeping back in through the details? Is the MVP actually minimal, or is it the full vision wearing an MVP costume?

### 5. Underspecified decisions — what's hand-waved?
Phrases like "we'll handle X later", "some kind of caching", "a simple queue" hide the hard parts. Flag the places where a real decision is being deferred or glossed, and note which ones are load-bearing enough to resolve before building.

### Research when it sharpens the critique
If the spec leans on a library, pattern, or service you're unsure is current, use `WebSearch`/`WebFetch` to check whether the proposed approach is still the recommended one in 2026, or whether something has deprecated it or made it riskier. Ground the critique in current practice rather than guesses — but don't pad the review with research it doesn't need.

## Output format

ALWAYS use this structure. Order findings by severity — the thing most likely to sink the project goes first.

```markdown
# Spec Review: [document name]

## Verdict
**[Ready to build / Needs work / Not ready]** — one-sentence justification.

## Blocking issues
Things that must be resolved before building. For each:
- **[Issue]** — why it matters, and what to decide/add to resolve it.

## Should-fix
Significant but non-blocking. Same format.

## Minor / nits
Quick list. Don't over-invest here.

## What's good
Briefly — what the spec gets right and shouldn't be lost in a revision. (This isn't flattery; it protects the strong parts from being edited away.)
```

## Calibration

- If a spec genuinely is ready, say so plainly — don't manufacture blocking issues to look thorough. A clean "Ready to build, here's why" is a valid and valuable result.
- Severity matters more than count. Three real blocking issues beat twenty nits.
- Tie every finding to a consequence. "This is underspecified" is weak; "This is underspecified, so two engineers will implement incompatible versions of it" is actionable.
- Don't redesign the project in the review. Point at the problem and the decision that needs making; let the author own the solution unless they ask you to propose one.
