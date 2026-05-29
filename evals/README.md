# Benchmark: does `project-interrogator` actually change behavior?

We ran two realistic vague build requests through Claude (Opus 4.8) **with** the `project-interrogator` skill and **without** it (baseline = stock Claude), capturing the complete first response each time. Raw outputs are in `iteration-1/`.

This is a behavioral benchmark, not a code-quality one — the whole question is *what Claude does when handed an under-specified "build me X."*

## Test prompts

| # | Prompt |
|---|--------|
| 0 | "hey i want to build something that helps me keep track of my reading. like a little tool. can you make it?" |
| 1 | "I need an internal dashboard for our support team to see ticket volume and response times. Build it." |

## What we measured

| Behavior | Without skill | With skill |
|---|---|---|
| Wrote code before clarifying anything | **Yes** (eval 0: ~200 lines of CLI Python) | No |
| Imposed a stack/workflow unprompted | Yes — picked Python + CLI + JSON / "say go and I'll build" | No — surfaced it as a *tradeoff to confirm* |
| Surfaced build-vs-buy reframe | No | Yes (eval 1: "native help-desk analytics may already solve this"; Metabase vs bespoke) |
| Asked for the *"so what"* (the decision the thing enables) | No | Yes |
| Produced an explicit approval gate before coding | No | Yes ("no implementation until you approve the spec") |
| Researched current (2026) practice | No | Attempted; see caveat below |

## Headline result

The clearest single data point is **eval 0**: without the skill, Claude dumped ~200 lines of a command-line Python app — silently choosing the platform, language, and storage the user never mentioned. The user said "a little tool"; they may have wanted a phone app. With the skill, Claude's first move was *"terminal, web, or phone?"* — and no code until a spec was approved.

Eval 1 shows the higher-value behavior: the skill surfaced that the support team's existing help desk **probably already ships the analytics they're asking us to build**, and reframed the whole thing as build-vs-buy. That's the kind of question that saves a project, and the baseline never asked it.

## Cost

| | With skill | Without skill |
|---|---|---|
| Avg tokens / response | ~22.6k | ~16.7k |
| Avg wall time | ~54s | ~31s |

The skill costs more tokens and time up front — that's the point. It front-loads the cheap clarification that prevents the expensive rebuild. For a vague brief that would otherwise produce the wrong artifact, the trade is heavily favorable.

## Honest caveat

Web search was permission-blocked in the benchmark sandbox, so the live-research step degraded to Claude's own knowledge — and the skill *flagged this to the user explicitly* rather than pretending the info was fresh. In a normal session with web access, the research step fires for real. We're noting this rather than hiding it; the "research" column above is "attempted + gracefully degraded," not "fully exercised."

## Reproduce

Outputs are committed under `iteration-1/<eval>/<with_skill|without_skill>/response.md`. Re-run by giving the same prompts to Claude with and without `skills/project-interrogator/SKILL.md` loaded.
