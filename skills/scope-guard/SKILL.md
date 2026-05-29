---
name: scope-guard
description: Watch an in-progress build for scope drift — work that wanders beyond what the approved spec actually called for — and flag it before it gets committed. Use this skill whenever there is an approved spec, plan, ticket, or SPEC.md and you are actively implementing against it, especially when you notice yourself about to add a feature, abstraction, dependency, refactor, or "while I'm here" change that the spec did not ask for. Also use it when the user says "stay on scope", "don't gold-plate this", "keep it minimal", "are we still on track", or "scope check". Do NOT silently expand the work; pause, name the drift, and let the user decide whether it's in or out.
---

# Scope Guard

Scope drift is how a one-day task becomes a one-week task. It rarely happens in one big jump — it's the accumulation of small, individually-reasonable "while I'm here" additions: an extra config option, a premature abstraction, a dependency that seemed handy, a refactor of code you happened to touch. Each feels harmless. Together they blow the estimate, expand the test surface, and ship things nobody asked for.

This skill is a check against your own helpfulness. You are wired to be thorough and anticipate needs — usually good, but during a scoped build it manufactures work the user didn't approve and didn't budget for. The discipline here: **build what the spec says, flag everything else, decide nothing unilaterally.**

## When to run this skill

Run it when:
- There's an approved spec / plan / ticket / `SPEC.md` and you're implementing against it.
- You're about to add something the spec doesn't mention — a feature, option, abstraction, dependency, or refactor.
- The user asks for a scope check, says "keep it minimal", or wonders if you're still on track.

This skill pairs with `project-interrogator`: that skill produces the approved `SPEC.md`; this one holds the build to it.

Do NOT let it become paralysis. Obvious, in-spirit implementation details (a sensible variable name, a necessary import, an error message) are not drift — just build them. Drift is about *added surface area and scope*, not every micro-decision.

## How to guard scope

### The drift test
Before adding anything not explicitly in the spec, ask: **"Does the approved spec require this to meet its stated goal and success criteria?"**

- **Yes / clearly implied** → build it, no interruption.
- **No, but it's tempting** → that's drift. Don't build it silently. Flag it (below).
- **Genuinely unsure** → treat as drift and ask. Cheap to ask, expensive to unwind.

### Common drift patterns to catch
- **Gold-plating** — handling cases the spec marked out of scope or never mentioned.
- **Premature abstraction** — a framework/base-class/plugin-system for one current use. Three similar lines beat a premature abstraction.
- **Speculative generality** — config flags, hooks, "extensibility" for hypothetical futures.
- **Dependency creep** — pulling in a library for something small or doable with the stack already chosen in the spec.
- **Drive-by refactors** — restructuring code you only touched incidentally.
- **Spec substitution** — quietly building a "better" version of what was asked instead of what was asked.

### When you catch drift — flag, don't decide
Pause and put the decision to the user, concisely:

```
Scope check: I'm about to [X], but the spec only calls for [Y].
- In scope per spec: [Y]
- What I'd be adding: [X], because [reason it's tempting]
- Recommendation: [defer / include + why]
Want this in, or should I note it and move on?
```

Then respect the answer. If deferred, capture it (a `## Deferred / out of scope` note in the spec or an "Out of scope" list) so it isn't lost — momentum-killing isn't the goal, *unbudgeted silent expansion* is.

## Output when asked for a standalone scope check

If the user asks "are we still on scope?" mid-build, audit what's been done against the spec and report:

```markdown
# Scope Check

## On track
- [Spec items being built as specified.]

## Drift detected
- **[Addition]** — not in spec; [in scope because… / recommend deferring because…]

## Spec items not yet started
- [Remaining approved work.]

## Recommendation
[One or two sentences: trim, proceed, or get a decision on the flagged items.]
```

## Calibration

- The goal is *the user decides*, not *you minimize*. Surface drift; don't refuse to ever build anything beyond the literal text. If the user says "yes add it," add it cheerfully.
- Don't flag the same kind of micro-decision repeatedly — once a pattern is approved ("yes, always add input validation here"), treat it as in-scope going forward.
- A spec change is fine — what's not fine is a spec change that nobody noticed happening.
