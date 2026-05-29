# ClaimReply Demo — Spec

> Example artifact produced by `project-interrogator` during a live test run.
> Persona: senior Google PM with a vague client brief. See `.demo/TEST-RUN.md`.

## Problem
A mid-size US auto-insurer's support team is drowning in repetitive customer emails (claims status, billing, policy changes). Their exec ask is "AI to handle customer emails," but compliance won't allow anything auto-sent to a customer. We need to win a renewal by showing their CTO, in 6 weeks, that AI can cut handle time without touching the compliance third rail — on synthetic data, since their real data is behind a 3-month security review.

## Goal
In a 6-week demo, make the client's CTO believe AI agent-assist will measurably cut support handle time while keeping a human in control of every customer-facing message.

## Users
- **Demo audience:** the client's CTO + compliance stakeholders (the buyers).
- **Simulated end user in the demo:** an insurance support rep who reviews and approves AI-drafted replies.

## Scope
### In
- One hero flow, done deeply: customer emails "what's my claim status / why so slow" → AI reads it → pulls the (synthetic) claim record → drafts an empathetic, *accurate* reply citing real claim status → rep approves with one click → "sent."
- A mock inbox UI that visually reads as Outlook/M365.
- ~50 PO-supplied realistic synthetic claim emails + a generated set to fill out the corpus.
- A visible "handle time saved" / before-after metric in the demo.

### Out
- Real Outlook add-in (faithful mock instead — ~1/3 the effort, demos identically).
- Auto-send / full autonomy (compliance blocker; pitched as phase 2 roadmap).
- Billing and policy-change flows (breadth deferred; depth wins this CTO).
- Integration with the client's real systems or production data.
- Production hardening, auth, multi-tenant — it's a demo.
- Any real customer PII; even synthetic data uses obviously-fake names.

## How it works
A web app styled like an Outlook inbox. Selecting an incoming customer email triggers: classify intent → retrieve the matching synthetic claim record → LLM drafts a grounded reply that cites the actual claim status/fields → draft appears in a review pane with the source claim data shown alongside (so the rep can verify accuracy) → rep edits if needed and clicks Approve → email moves to "Sent." A small dashboard shows drafts handled and estimated handle-time saved.

## Tech approach
- **Mock Outlook-style web UI** (standalone, no M365 integration).
- **Azure OpenAI** for drafting (client is M365/Azure; approved for the demo).
- Synthetic claim records + email corpus as the grounding data; retrieval keyed on claim ID / customer.
- Grounding-first prompting: the draft must cite retrieved claim fields, never invent status — accuracy is the credibility bar.
- Maintained by our team through the demo; transfers to a joint team on renewal.

## Success criteria
- The hero flow runs end-to-end live, without a fallback, on the PO's synthetic emails.
- Every drafted reply is accurate to the underlying synthetic claim record (no hallucinated status).
- Human-approval step is mandatory and visible — nothing "sends" without a click.
- UI is convincing enough that the CTO doesn't dismiss it as a toy.
- The demo surfaces a handle-time-saved figure, presented as a clearly-labeled *assumption* (no real baseline exists yet), not a measured result.

## Risks & edge cases
- **Fake-feeling synthetic data** — the top risk; mitigate with the PO's 50 real-shaped samples driving the generated set.
- **Hallucinated claim status** — would torpedo credibility with a compliance audience; mitigate with strict grounding + showing source data next to the draft.
- **Scope creep into breadth** (billing/policy) eating the 6 weeks — deferred explicitly above; `scope-guard` watches this.
- **CTO nitpicks the mock** not being "real Outlook" — set expectation up front that it's a faithful prototype, not a shipped add-in.

## Open questions
- Exact handle-time baseline to compare against — does the PO have a current avg, or do we state an assumption?
- How many distinct claim scenarios in the corpus to feel "real" without overbuilding (10? 25?).
