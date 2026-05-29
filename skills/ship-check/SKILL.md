---
name: ship-check
description: Run a pre-ship verification gate before code is merged, deployed, or called "done" — proving the build actually works and meets its spec, rather than asserting it does. Use this skill whenever the user is about to merge, push, deploy, open a PR, or says "is this ready to ship", "are we done", "final check", "ready to merge", "pre-flight", or "ship it" — and whenever you're tempted to declare a task complete. Do NOT just claim success; actually verify against the spec, run the tests, walk the edge cases, check for security and obvious regressions, and produce a go / no-go report with evidence.
---

# Ship Check

The most expensive two words in software are "should work." This skill replaces them with evidence.

The failure mode it targets: declaring a task done because the code was written and looks right — not because anyone confirmed it behaves correctly. "Should work" is a hypothesis. Shipping is for verified facts. Your job here is to do the verification the author is tempted to skip because they're confident, tired, or out of time — exactly when bugs slip through.

## When to run this skill

Run it when:
- The user is about to merge, push, deploy, open a PR, or release.
- The user asks "is this ready?", "are we done?", "final check", "ship it".
- You're about to tell the user a task is complete. Run the gate first, then report.

This skill closes the spec-first loop: `project-interrogator` defined the spec, `scope-guard` kept the build on it, and `ship-check` proves the build met it.

Do NOT run a heavy gate for a trivial, already-verified one-liner — match the rigor to the blast radius. A typo fix in a comment doesn't need a security review; a change to auth or payments does.

## The gate

Work through these. **Verify by doing, not by assuming.** "The tests should pass" is not a checked box — *run them*. "It handles empty input" is not checked until you've traced or tested the empty-input path.

### 1. Meets the spec
If there's a spec/ticket/`SPEC.md`, go through its success criteria one by one and confirm each is actually satisfied. List any that aren't. A build that's well-made but doesn't meet its goal is not shippable.

### 2. Tests
- Run the existing test suite. Report real results — pass/fail counts, not "they should pass."
- Does the change have test coverage? New behavior without a test is a regression waiting to happen. Note what's untested.
- If you can't run the tests, say so explicitly rather than implying they passed.

### 3. Behavior — actually exercise it
For anything user-facing or with observable behavior, run it and watch what happens — golden path *and* the edge cases (empty, huge, malformed, concurrent, offline, unauthorized). For UI, open it in a browser and use the feature; type checks and unit tests verify code, not whether the feature works. If you genuinely can't exercise it, state that as a gap — don't paper over it.

### 4. Edge cases & failure modes
Walk the unhappy paths relevant to this change: bad input, missing data, network/dependency failure, permission denied, race conditions. Confirm each is handled or consciously deferred — not silently broken.

### 5. Security
Scan the diff for the usual: injection (SQL/command/XSS), secrets or keys committed, missing authz checks, unsafe deserialization, unvalidated input crossing a trust boundary, dependency with known issues. Match depth to the surface — auth/payment/PII changes get a hard look.

### 6. Regressions & hygiene
- Did this break anything adjacent? Check callers of changed functions.
- Leftover debug logs, commented-out code, TODOs that block shipping, stray files.
- Docs/README/config updated if the change requires it.

## Output format

ALWAYS end with an explicit verdict. The user should never have to guess whether you think it's safe to ship.

```markdown
# Ship Check: [what's being shipped]

## Verdict: GO / NO-GO / GO WITH CAVEATS
One sentence.

## Spec criteria
- [x] [Criterion] — verified by [how]
- [ ] [Criterion] — NOT met: [what's missing]

## Tests
[Actual results. e.g., "Ran `pytest`: 142 passed, 1 failed — test_auth_expiry (details below)." Or: "Could not run — no test runner configured."]

## Behavior verified
- [What you actually exercised and what you observed.]

## Edge cases
- [Case] — handled / NOT handled / deferred

## Security
- [Findings, or "No issues found in diff" with what you checked.]

## Blockers (if NO-GO)
- [What must be fixed before shipping.]

## Caveats (if GO WITH CAVEATS)
- [Known gaps the user is accepting by shipping now.]
```

## Calibration

- **Honesty over green checkmarks.** A truthful NO-GO is worth far more than a GO that ignores a failing test. Never report a check as passed when you didn't actually run it — if you couldn't verify something, the correct output is "unverified," not "passed."
- **Match rigor to risk.** Don't make a docs typo run the full gauntlet; don't wave through an auth change.
- **GO WITH CAVEATS is a real answer.** Often the honest state is "works, ship it, but know that X is untested." Naming the caveat lets the user make the call with open eyes.
