# spec-first

**Four Claude skills that stop AI from building the wrong thing.**

<!-- Record this with .demo/RECORD.md, then push .demo/demo.gif — it renders here automatically. -->
<p align="center">
  <img src=".demo/demo.gif" alt="project-interrogator flips Claude from build-first to interrogate-first" width="800">
</p>

You say *"build me a tool to track my reading."* Stock Claude writes 200 lines of a command-line app — silently choosing the platform, the language, and the storage you never asked for. Maybe you wanted a phone app. Now you're reading code you have to throw away.

`spec-first` flips that default. It makes Claude **interrogate before it implements**, hold the build to an approved spec, and prove the result actually works before calling it done. Idea → spec → build → ship, with a human approval gate where it matters.

> "should work" is the most expensive phrase in software. spec-first replaces it with evidence.

---

## The before / after

Same prompt: *"hey i want to build something that helps me keep track of my reading. like a little tool. can you make it?"*

<table>
<tr><th>❌ Without spec-first</th><th>✅ With spec-first</th></tr>
<tr valign="top"><td>

> Love this idea! …I'll give you a solid working version right now.
>
> ```python
> #!/usr/bin/env python3
> """readtrack — a tiny command-line reading tracker."""
> import argparse, json, os
> ...200 lines...
> ```
>
> Save this as `readtrack.py`…

**Guessed**: CLI (never stated), Python, local JSON. Built first, asked questions after. If you wanted a phone app, all of it is wasted.

</td><td>

> Before I build anything, I want to interrogate this brief.
>
> **Round 1 — the shape of the thing**
> 1. Terminal, web page, or phone?
> 2. What do you track per book — and what's the *one* thing you'll do with it weekly?
> 3. What does "this worked" look like in 3 months?
>
> *(researches current 2026 reading-tracker tools, then drills into specifics)*
>
> …then writes a one-screen `SPEC.md`. **No code until you approve it.**

**Asked first.** Zero wasted code. The spec is a contract the rest of the build runs against.

</td></tr>
</table>

Full transcripts and a behavioral benchmark (with-skill vs stock Claude across two real prompts) live in [`evals/`](evals/README.md).

---

## The four skills

A lifecycle. Each one closes a gap where AI-assisted builds go sideways.

| Skill | Stage | What it does | Triggers on |
|---|---|---|---|
| **[project-interrogator](skills/project-interrogator/SKILL.md)** 🌟 | **Define** | Interrogates a vague request (broad → specific), researches current best practice *between question rounds*, then writes a spec you must approve before any code. | "build me…", "grill me", "spec this out", any vague new-project ask |
| **[spec-reviewer](skills/spec-reviewer/SKILL.md)** | **Plan** | Adversarially pressure-tests a spec/PRD/plan for gaps, hidden assumptions, and risks. Ends with a ready / needs-work / not-ready verdict. | "review this spec", "poke holes in this", "pressure-test", before implementing a design doc |
| **[scope-guard](skills/scope-guard/SKILL.md)** | **Build** | Catches scope drift mid-build — the "while I'm here" features, premature abstractions, and dependency creep that blow estimates — and makes *you* decide, not Claude. | "stay on scope", "keep it minimal", an approved spec exists and Claude is about to add something it didn't call for |
| **[ship-check](skills/ship-check/SKILL.md)** | **Ship** | A pre-merge gate that *verifies* instead of asserting: runs the tests, walks the edge cases, scans for security issues, checks the spec criteria. Outputs GO / NO-GO with evidence. | "is this ready to ship?", "are we done?", before merge/deploy/PR |

The flagship is `project-interrogator` — the other three keep the rest of the lifecycle honest. Use them together or à la carte.

---

## What makes the flagship different

"Ask clarifying questions before coding" is the oldest tip in the book. `project-interrogator` does one thing the others don't: it **researches the problem space mid-interview**.

After your first answers, it runs a live web search for current libraries, patterns, and freshly-deprecated approaches — *then* asks its next round of questions. So instead of generic 2023 questions, you get 2026 ones: *"your help desk probably already ships these analytics — what can't the built-in reporting do?"* That single reframe can save an entire project. (Stock Claude didn't ask it. The skill did — see [`evals/`](evals/README.md).)

---

## Install

**One skill, or all four**, into your user-level Claude skills directory (available in every project):

```bash
git clone https://github.com/nidhi1603/spec-first.git
cd spec-first
./install.sh                       # all four
./install.sh project-interrogator  # or just the flagship
```

Or copy a skill folder yourself — a skill is just a `SKILL.md`:

```bash
cp -R skills/project-interrogator ~/.claude/skills/
```

Restart Claude Code (or start a new session). Then say *"I want to build something"* — the interrogator kicks in automatically.

> Works with [Claude Code](https://claude.com/claude-code) and any Claude surface that supports [Agent Skills](https://docs.claude.com/en/docs/claude-code/skills). Requires no dependencies — they're plain Markdown.

---

## Why this exists

Most software failures aren't bad code — they're the **wrong thing, built confidently**. Vague briefs, unstated assumptions, scope that quietly doubles, and a "done" that was never actually verified. AI makes all four *faster*: it'll happily build the wrong thing in seconds.

`spec-first` is the guardrail. It's opinionated on purpose:

- **Agencies & freelancers** — an approved `SPEC.md` is scope protection. "But I wanted X" becomes a change request, not a fight.
- **Eng teams** — kills vague tickets at the source; surfaces non-goals and edge cases before the wrong thing ships.
- **Solo builders** — a 5-question discovery interview that stops you sinking a weekend into something nobody needed.

---

## Contributing

Skills are Markdown — PRs to improve triggering, sharpen the questioning, or add lifecycle skills are welcome. If you add a skill, include a before/after in `evals/` so the value is provable, not just claimed.

## License

[MIT](LICENSE).
