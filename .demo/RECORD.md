# Recording the demo GIF

The goal: a ~20–30s clip showing `project-interrogator` flipping Claude from
"build first" to "interrogate first." Short, punchy, autoplay-friendly on GitHub.

## Option A — asciinema (recommended: crisp text, tiny file)

1. Install once:
   ```bash
   brew install asciinema agg     # agg converts the cast → gif
   ```
2. Record. Keep it tight — start the recording, run Claude Code, paste the
   prompt, let it ask Round 1, then stop. Don't record the whole interrogation;
   the *flip* is the story.
   ```bash
   asciinema rec .demo/spec-first.cast --cols 100 --rows 30
   ```
   Inside the recording:
   - Start Claude Code in a throwaway dir.
   - Paste exactly: `hey i want to build something to track my reading. a little tool. can you make it?`
   - Let it produce Round 1 (the "terminal, web, or phone?" questions).
   - Press `Ctrl-D` to stop recording.
3. Convert to GIF:
   ```bash
   agg --cols 100 --rows 30 --font-size 18 .demo/spec-first.cast .demo/demo.gif
   ```

## Option B — screen recorder (easiest)

Use macOS screen recording (Cmd-Shift-5) or [Kap](https://getkap.co).
Record the same flow, export as GIF, drop it at `.demo/demo.gif`.
Keep width ~900px, trim dead air, aim for <5 MB so GitHub autoplays it.

## Tips that make the GIF land

- **Trim to the flip.** Viewers need to see: vague prompt in → sharp questions
  out. Cut everything after Round 1.
- **Make the prompt visible long enough to read** (1–2s) before answers appear.
- **No spec-walls.** The GIF sells the *behavior change*, not the full spec.
- Optionally do a 2-shot: a quick "without" clip (Claude dumps code) cut against
  the "with" clip. The contrast is the whole pitch — but one good "with" clip is
  enough to start.

## After recording

```bash
git add .demo/demo.gif
git commit -m "Add demo GIF"
git push
```

The README already references `.demo/demo.gif` at the top — once you push the
file, it renders automatically. No README edit needed.
