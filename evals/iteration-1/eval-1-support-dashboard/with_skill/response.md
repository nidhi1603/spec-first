Before I build anything, I want to interrogate this brief a bit. "An internal support dashboard, build it" can mean five very different things, and the wrong guess here is expensive — I'd rather spend ten minutes now than have you discover in two weeks that I built a real-time wall display when you needed a weekly exec PDF. So let me grill you.

I'll go broad first, then drill in. Answer what you can; free-form is welcome where my options miss the mark.

---

## Round 1 — the shape of the thing (3 questions)

**1. Where do the tickets actually live today?**
This is the single biggest fork in the road, because it decides whether this is a "connect to an API and chart it" project or a "build a data pipeline" project.
- Zendesk
- Freshdesk
- Intercom
- Jira Service Management
- Salesforce Service Cloud
- HubSpot
- Something homegrown / a database we own
- Other (tell me)

**2. Who stares at this dashboard, and how often?**
The audience changes everything about refresh rate, depth, and polish.
- **Support agents / IC** — "how's my queue right now," glances all day
- **Team lead / manager** — "is my team keeping up," checks a few times a day
- **Director / exec** — "are we healthy this month," weekly or monthly
- A mix (tell me the priority order)

**3. What's the one decision this dashboard should help someone make?**
"See ticket volume and response times" is the *what*, but I want the *so what*. For example: "decide whether to pull someone onto support today," or "catch SLA breaches before the customer complains," or "justify a new headcount in the QBR." The sharper this is, the better the dashboard.

---

## What I'd otherwise have to assume (and the 2026 landscape)

I tried to pull live 2026 sources for this and web search is blocked in my current environment, so treat the specifics below as my working knowledge rather than freshly-verified facts — correct me where I'm stale. Here's the lay of the land as I understand it, and why your Round 1 answers matter:

- **The build-vs-buy default has shifted.** For an internal ops dashboard in 2026, hand-rolling a React + charting-library app is usually the *wrong* first move unless you have hard custom requirements. Most teams reach for **Metabase** (open-source, self-hostable, connects straight to a database or warehouse, near-zero frontend code) or **Retool / internal-tool builders** when they need interactivity and write-back. A bespoke web app is the right call mainly when the dashboard needs custom UX, must embed in an existing internal portal, or the data shape is genuinely weird.
- **Most help-desk platforms already ship native analytics.** Zendesk Explore, Freshdesk Analytics, Intercom Reports, etc. So a real question is: *what can't the built-in reporting already do for you?* If the answer is "nothing, it's just gated behind a license tier or it's clunky," that changes the cheapest path dramatically.
- **"Response time" is a trap term.** It splits into first-response time, full-resolution time, and SLA-breach rate — and they tell different stories. Averages also lie here; the 2026 norm is to report **medians and p90/p95**, because a handful of nightmare tickets blow up the mean and hide that most customers are fine. I'll want to pin down which metric you actually mean.
- **Real-time vs. periodic is a real cost line.** A live-refreshing "current queue" view (websockets/polling, careful caching) is meaningfully more work than a dashboard that refreshes every 15–60 minutes off a scheduled sync. Agents tend to want the former; execs are happy with the latter.

---

## Round 2 — drill-downs (answer the ones that apply)

**Scope & metrics**
- Beyond volume and response time, which of these matter for v1: SLA-breach rate, resolution time, backlog/open-ticket count, CSAT, per-agent breakdown, per-channel (email/chat/phone) breakdown, tickets-by-category? Pick the must-haves; everything else is v2.
- Do you need **per-agent** numbers, or is team-level enough? (Per-agent gets political and changes the data model — worth being deliberate.)
- Real-time-ish (queue you watch live) or periodic (refreshes every N minutes, you check it)?

**Tech & hosting**
- Do you already run anything I should slot into — an existing BI tool (Metabase/Looker/Tableau/Power BI), a data warehouse (Snowflake/BigQuery/Redshift), or an internal app platform (Retool/internal portal)? If so, I'd build *there* rather than stand up something new.
- Any constraints I must respect: must self-host (data can't leave your infra), SSO/auth requirements, a language/stack the team maintains, or a "must avoid X" (cost, vendor)?
- Who maintains this after I hand it off? That decides how much I optimize for low-code vs. clean code.

**Success & edges**
- Hard deadline or event driving this (a QBR, a new SLA commitment, an incident that prompted it)?
- Roughly what volume — hundreds of tickets/month or hundreds of thousands? (Affects whether I can hit the API live or need a synced store.)
- Who's allowed to see it, and does it contain customer PII that limits where it can be hosted?

---

## How I'd probably build it (explain-back — confirm or correct)

Based on the most common version of this request, here's my default plan, stated so you can shoot holes in it:

> Your tickets live in a SaaS help desk (say Zendesk-class). I'd run a **scheduled sync** (every 15–30 min) pulling tickets via its API into a small datastore — a Postgres table or your warehouse if you have one — rather than hammering the API on every page load. On top of that I'd stand up **Metabase**, connected to that store, with one dashboard: top-line cards (open tickets, tickets created today/this week, **median + p90 first-response time**, SLA-breach count), a volume-over-time line chart, response-time trend, and a breakdown by channel and/or agent. Auth via your existing SSO. Self-hosted if data residency matters.
>
> Key tradeoff: **Metabase (fast, low-maintenance, less custom)** vs. **a bespoke React app (full control, more build + ongoing upkeep)**. I'd start with Metabase and only go bespoke if a hard requirement forces it. Second tradeoff: **live queue (more infra)** vs. **periodic refresh (simpler)** — I'd default to periodic unless agents need a live view.

If that picture matches your intent, great. If any piece is off — wrong tool, wrong audience, you actually want it embedded in your own app, the data's in a place I didn't guess — tell me and I'll adjust.

---

## Next step

Once you answer Round 1 (and as much of Round 2 as you can), I'll fold in your answers, write a tight **SPEC.md** — problem, goal, users, in/out scope, how it works, tech approach, success criteria, risks — and show it to you. **I won't write a line of implementation code until you've read that spec and explicitly approved it.** That approval gate is the whole point: it's cheap insurance against building the wrong thing.

What've you got?
