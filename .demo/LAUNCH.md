# Launch posts

Copy-paste ready. Post the GIF first wherever the platform allows it — the
before/after is the hook.

---

## Show HN

**Title:**
```
Show HN: spec-first – Claude Code skills that interrogate you before writing code
```

**Body:**
```
I got tired of one thing about coding with AI: you say "build me a tool to
track my reading" and it immediately writes 200 lines of a CLI app — silently
picking the language, the platform, and the storage you never asked for. Maybe
you wanted a phone app. Now you're reading code you'll throw away.

spec-first is four Claude Code skills that flip that default:

- project-interrogator (the flagship) — interrogates a vague request, broad to
  specific, does a live web search *between question rounds* so the questions
  reflect current practice, then writes a one-screen spec you have to approve
  before any code is written.
- spec-reviewer — adversarially pressure-tests a spec/PRD for gaps and hidden
  assumptions.
- scope-guard — catches scope drift mid-build (the "while I'm here" features)
  and makes you decide, not the model.
- ship-check — a pre-merge gate that runs the tests and walks the edge cases
  instead of just asserting "should work."

There's a committed benchmark in the repo: same vague prompt, with the skill vs
stock Claude. Stock Claude wrote a full CLI app before asking anything; the
skill's first move was "terminal, web, or phone?" Both transcripts are in evals/.

Skills are plain Markdown, MIT licensed, install with one script. Works with
Claude Code and any surface that supports Agent Skills.

Repo: https://github.com/nidhi1603/spec-first

Curious whether others have found the "AI builds the wrong thing confidently"
problem as annoying as I have, and how you've dealt with it.
```

**When to post:** weekday, ~8–10am ET tends to do well on HN. Reply to early
comments fast — engagement in the first hour matters most.

---

## r/ClaudeAI (and r/ClaudeCode)

**Title:**
```
I built 4 Claude skills that make it interrogate you before writing code (instead of guessing)
```

**Body:**
```
The thing that bugs me most about building with Claude: vague prompt in,
confident wrong build out. "Make me a reading tracker" → 200 lines of a CLI app,
language and platform chosen for you, before a single question.

So I made spec-first — four skills, one per stage of a build:

🔍 project-interrogator — grills you (broad → specific), researches current
   best practices mid-interview, writes a spec you approve before any code.
🧪 spec-reviewer — pokes holes in a spec/plan before you build it.
🚧 scope-guard — flags scope creep mid-build so *you* decide what's in.
✅ ship-check — verifies it actually works before you call it done (runs tests,
   walks edge cases, security pass) instead of saying "should work."

Repo has a real before/after benchmark committed — same prompt with vs without
the flagship skill. The contrast is pretty stark.

Plain Markdown, MIT, one-line install: https://github.com/nidhi1603/spec-first

Would love feedback on the questioning flow — what would make the interrogation
sharper?
```

**Note:** Reddit hates anything that smells like an ad. Lead with the problem,
be a person, ask a genuine question at the end, and reply to comments.

---

## X / Twitter thread

```
1/ Coding with AI has one deeply annoying default:

you say "build me a reading tracker"
it writes 200 lines of a CLI app — language, platform, storage all chosen for you

maybe you wanted a phone app. enjoy your throwaway code.

so I built spec-first 🧵

2/ It's 4 Claude Code skills, one per build stage:

🔍 interrogate before coding
🧪 pressure-test the spec
🚧 catch scope creep mid-build
✅ verify it works before "done"

3/ The flagship, project-interrogator, does the thing nobody else does:

it web-searches the problem space *between* question rounds.

so you get 2026 questions, not generic 2023 ones. like:
"your help desk probably already ships these analytics — what can't it do?"

4/ Receipts > claims. The repo has a committed benchmark:

same vague prompt, with the skill vs stock Claude.

stock Claude: wrote a full app before asking anything.
with the skill: "terminal, web, or phone?" first. no code until you approve a spec.

5/ Plain Markdown. MIT. one-line install. works with Claude Code + any Agent
Skills surface.

⭐ https://github.com/nidhi1603/spec-first

what's the worst "AI confidently built the wrong thing" moment you've had?
```

---

## LinkedIn (optional, good for the agency/eng-lead audience)

```
AI will happily build the wrong thing in seconds.

Most software failures aren't bad code — they're the wrong thing, built
confidently. Vague brief, unstated assumptions, scope that quietly doubles, a
"done" nobody verified. AI makes all four faster.

I open-sourced spec-first: four Claude skills that put a guardrail on each stage.
Interrogate before coding → approve a spec → hold the build to it → verify before
shipping.

For agencies it's scope protection (an approved spec = "but I wanted X" becomes a
change request, not a fight). For eng teams it kills vague tickets at the source.

MIT, plain Markdown, benchmark included:
https://github.com/nidhi1603/spec-first
```
