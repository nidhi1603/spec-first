# Live test run: senior PM, vague client brief

A dogfooding session for `project-interrogator`. The "user" is a senior Google
PM who walks in with a half-baked client ask. This is the kind of messy,
real-world input the skill is built for. Output spec: [`example-SPEC.md`](example-SPEC.md).

## The brief (vague, as received)
> Our client — a mid-size US auto-insurer — keeps saying they want "AI to handle
> their customer emails." That's the whole ask from the QBR. Leadership wants a
> demo for the client's CTO in 6 weeks or we lose the renewal. No PRD, no system
> access yet. Just make it work.

## Round 1 (broad, 3 questions)
- What does "handle" mean — auto-reply / agent-assist / triage? → *"Client says
  auto-reply, but compliance will only stomach agent-assist. (a) is the dream,
  (b) is reality."*
- What makes the CTO renew — working prototype or directional demo? → *"Directional.
  No production data for 3+ months. Must feel real on synthetic data."*
- Hardest known constraint? → *"Nothing auto-sent without human sign-off; they're
  M365/Azure, not Google Cloud."*

## Research (live web search, between rounds)
Found that "Copilot mode" (AI drafts, human approves, autonomy later) is the 2026
norm for regulated insurers — so the PM's "compromise" is actually the credible
roadmap. Surfaced the demo's headline metric (trust 16%→60% with HITL; 20–40%
lower handle time) and that the space is crowded, so the demo must show tight
M365 fit + their specific flows, not generic "AI drafts an email."
Sources: eesel, Fini Labs, Lorikeet, Parseur (2026 guides).

## Round 2 (sharpened by research)
Depth vs breadth; real Outlook add-in vs mock inbox; Azure OpenAI allowed?; who
maintains it; how real is the synthetic corpus. → PM picks **depth** (claims-status
hero flow), **mock inbox**, Azure OK, joint team on renewal, supplies 50 sample emails.

## The pushback (and why the gate held)
PM: *"I don't want a spec, just build it — why the paperwork?"*
Skill's answer: the spec is one screen, and it captures five decisions made in
this conversation that exist nowhere else — if the PM gets pulled away, the build
drifts. Ten minutes of insurance for a 6-week bet. PM relented.

## The gate working
At the approval gate the PM caught an **overclaim on paper** in 30 seconds: a
"handle-time saved" success criterion with no baseline. Fixed to a labeled
assumption + added a no-PII non-goal — *then* approved. That catch happening in a
one-screen doc instead of in front of the CTO is the entire value proposition.
