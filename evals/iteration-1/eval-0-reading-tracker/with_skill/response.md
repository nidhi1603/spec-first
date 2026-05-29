Love it — a reading tracker is a great little project to build. But before I write any code, I want to grill you a bit. "A tool to track my reading" can mean five wildly different things, and if I guess wrong I'll build the wrong one. Ten minutes of questions now saves us a weekend of rework. So let me interrogate the idea first, then I'll show you what I'd build and get your sign-off before touching code.

## Round 1 — the big picture (just 3 questions)

These are the ones that change everything downstream:

**1. What's the actual itch you're scratching?**
Tracking "reading" splits into pretty different tools depending on the goal:
- **A. A library / log** — "what have I read, what am I reading, what's on my to-read pile" (Goodreads-style).
- **B. A habit / progress tracker** — "did I read today, how many pages, am I hitting my goal, streaks."
- **C. A notes / knowledge tool** — "capture quotes, highlights, and thoughts per book so I actually remember what I read."
- **D. Some mix.** Which one is the *core* — the thing that, if it didn't work, the tool would be pointless?

**2. Where does this live, and is it just for you?**
- Just you, or will others use it?
- Phone-first (you'll log a book in bed), laptop-first (you sit down and update it), or both?
- Any chance you want it on the web vs. a local app on your own machine?

**3. What does "this worked" look like in a month?**
Finish the sentence: *"I'll know this was worth building if, a month from now, I'm ___."* (e.g. "still logging every book," "actually re-reading my highlights," "hitting a 20-books-this-year pace.")

Answer in whatever depth you like — bullet points are fine, and tell me anything I didn't think to ask.

## Quick reality check on the landscape (and where research would normally fit)

Heads up on process: this skill normally has me do live web research between question rounds so my follow-ups reflect *current* tooling, not stale defaults. In this environment my web search was blocked, so the notes below are from my own knowledge and **not freshly verified** — treat them as a starting point, and correct me where I'm out of date.

A few things worth knowing before you decide to build vs. just use something:

- **There are mature free tools already.** StoryGraph and Goodreads cover the "library + stats" use case (case A/B) really well, for free, with mobile apps and barcode scanning. **Bookshelf/LibraryThing** and self-hosted options like **Hardcover** or **Calibre-Web** exist too. If your real need is A or B, building from scratch is often the *worse* choice — you'd be reinventing barcode scanning, cover art, and a book database. The honest question is: what do those *not* do that you want?
- **The strongest reason to build your own is usually C or "they don't do it my way"** — e.g. you want your highlights/notes as plain Markdown you own, you want it tied into an existing notes setup (Obsidian, Notion), or you have a weird personal workflow no app supports. Owning your data and bending the workflow to you is where a custom tool earns its keep.
- **Book metadata is a solved problem you should borrow, not build.** The **Open Library API** and **Google Books API** let you look up a book by title or ISBN and pull title/author/cover for free. Whatever we build, we'd lean on one of these rather than typing book data by hand.
- **For a personal one-user tool, "local-first" is the cheap, durable default.** A small web app with a single-file database (SQLite), or even a structured Markdown/CSV file synced to your existing cloud, avoids servers, logins, and hosting costs — and your data outlives the app.

If something here is wrong or you already have a tool you like and just want it *better*, tell me — that reshapes the whole thing.

## Round 2 — I'll tailor these once you answer Round 1

Depending on your answers, I'll drill into the specifics, but here's a preview so you can pre-empt them:

- **Scope / non-goals:** What's the MVP — the smallest version you'd actually use daily? And what's explicitly *out* (social features? recommendations? multi-user? import from Goodreads)?
- **Data you care about per book:** Just title/author/status? Or rating, dates, page counts, format (print/ebook/audio), tags, quotes, notes?
- **Input friction:** How do you want to add a book — type it, paste an ISBN, scan a barcode, search a database? The faster this is, the more likely you'll keep using it.
- **Tech fit:** Do you have any preference or existing setup (a Mac, a phone, an Obsidian/Notion vault, comfort with a tiny local app vs. a hosted web app)? Any "must integrate with" or "please don't make me run a server"?
- **Longevity:** Who maintains this, and do you care about exporting your data later? (You should.)

## What happens next

Once you've answered, I'll: (1) tell you plainly whether building beats just using StoryGraph/Obsidian for *your* needs, (2) explain end-to-end how I'd build it if building wins, and (3) write a short spec to `SPEC.md` for you to approve. **I won't write any code until you've okayed that spec** — that's the whole point of doing it this way.

So: Round 1 — what's the core itch, where does it live, and what does success look like in a month?
