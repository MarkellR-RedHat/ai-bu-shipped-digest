# Digest Templates by Audience

This reference provides formatting guidance for adapting shipped digests to different audiences. Each audience has different needs, different attention spans, and different definitions of "what matters."

Use these templates as a starting point when customizing digest output for specific stakeholders.

---

## Engineering Team (Detailed, Technical)

**Who reads this:** Engineers on the team, tech leads, SREs, and architects.

**What they care about:** Technical details, breaking changes, migration paths, performance numbers, architectural decisions, and who to talk to about specific changes.

**Tone:** Direct and technical. Assume the reader can parse a diff. Do not explain what a PR is.

**Length:** No limit. Engineers will scan headers and drill into what they care about.

### Template

```
# What Shipped: <repo name>
## <timeframe> (<start date> to <end date>)

### Breaking Changes (read this first)

> **Migration required:** <what changed and exactly what to do>

- <title> ([#<number>](<url>)) `[L]` @<author>
  - What changed: <technical description>
  - Migration path: <step-by-step instructions>
  - Rollback: <how to revert if needed>

### Architecture and Design Changes
<Changes that affect system design, data flow, or component boundaries.>

- <title> ([#<number>](<url>)) `[L]` @<author>
  - Design context: <why this approach was chosen>
  - Affected components: <list>

### Features
- <title> ([#<number>](<url>)) `[L]` @<author>
  - Implementation: <brief technical approach>
  - Follow-up: <known limitations or planned improvements>
  - Related: <fix title> ([#<number>](<url>)) `[S]`
- <title> ([#<number>](<url>)) `[M]` @<author>

### Bug Fixes
- <title> ([#<number>](<url>)) `[M]` @<author>
  - Root cause: <what was actually wrong>
  - Fix: <what was changed>

### Performance
- <title> ([#<number>](<url>)) `[M]` @<author>
  - Before: <metric>
  - After: <metric>
  - Method: <how it was measured>

### Infrastructure and Tooling
- <title> ([#<number>](<url>)) `[S]` @<author>

### Dependencies
- <list of dependency updates with version ranges>

### Full contributor list
| Contributor | PRs | Focus Areas |
|-------------|-----|-------------|
| @<username> | <count> | <what they worked on> |

---
*<total> PRs merged by <count> contributors. <release count> releases tagged.*
```

### Key rules for engineering audiences
- Breaking changes go at the very top, not buried in a list
- Include root cause analysis for significant bug fixes
- Show before/after numbers for performance work
- List dependency updates separately (engineers need to know what changed under them)
- Design context matters: explain "why" not just "what"

---

## Product Management (Feature-Focused, Roadmap-Aligned)

**Who reads this:** Product managers, product owners, program managers.

**What they care about:** Features that map to roadmap items, user-facing changes, customer impact, competitive positioning, and what to communicate to customers.

**Tone:** Clear and outcome-oriented. Technical enough to be precise, accessible enough for non-engineers.

**Length:** Under 400 words. PMs are scanning for what to put in their own updates.

### Template

```
# Product Update: <repo name>
## <timeframe> (<start date> to <end date>)

### Roadmap Progress

| Roadmap Item | Status | Key PRs |
|-------------|--------|---------|
| <feature/initiative name> | Shipped / In Progress / Blocked | [#<number>](<url>), [#<number>](<url>) |

### What Users Can Do Now (That They Could Not Before)

1. **<capability>** - <one sentence on what the user can now do and why it matters to them.> ([#<number>](<url>))

2. **<capability>** - <one sentence.> ([#<number>](<url>))

3. **<capability>** - <one sentence.> ([#<number>](<url>))

### What Changed for Existing Users

- <behavior change or deprecation, described from the user's perspective> ([#<number>](<url>))

### Quality and Reliability

- <count> bug fixes shipped, including: <most user-visible fix in plain language>
- <count> performance improvements, notably: <most impactful improvement in plain language>

### Customer-Facing Notes

<Any changes that should be mentioned in customer communications, release announcements, or support documentation. If none, omit this section.>

### Velocity Snapshot
- <total PRs> changes merged by <contributor count> contributors
- <feature count> features, <fix count> fixes, <perf count> performance improvements

---
*Full technical details: run `/shipped <repo> <timeframe>`*
```

### Key rules for product audiences
- Frame everything in terms of user capabilities and outcomes, not code changes
- Map work to roadmap items where possible
- Separate "new capabilities" from "changes to existing behavior"
- Quality work (bugs, perf) gets a dedicated section but is summarized, not listed item by item
- Include a velocity snapshot so PMs can report on team output
- Always link back to the detailed technical digest

---

## Executive Leadership (Impact-Focused, Metric-Driven)

**Who reads this:** VPs, directors, C-suite, and their chiefs of staff.

**What they care about:** Business impact, team velocity trends, risk indicators, headcount efficiency, and strategic alignment. They will spend 30 seconds on this.

**Tone:** Crisp and confident. Lead with impact. No jargon.

**Length:** Under 200 words. If it does not fit on one screen, it will not get read.

### Template

```
## <repo name> | <timeframe>

**Bottom line:** <One sentence: the single most important thing that shipped and why it matters to the business.>

### Key Outcomes
- <Outcome 1: described in business terms, not technical terms>
- <Outcome 2>
- <Outcome 3 (if warranted)>

### By the Numbers
| Metric | Value |
|--------|-------|
| Changes shipped | <count> |
| Team members active | <count> |
| Releases published | <count> |
| Time from code to merge (median) | <duration> |

### Risk and Attention Items
- <Any breaking changes, regressions, or blockers that leadership should know about. If none, write "No risk items this period.">

### Trend
<One sentence: is velocity up, down, or stable vs. last period? Is focus shifting?>

---
*Details: `/shipped <repo> <timeframe>` | Metrics: `/shipped-metrics <repo> <timeframe>`*
```

### Key rules for executive audiences
- The "bottom line" sentence is the most important line in the entire digest. Spend time on it.
- Translate technical work into business language: "reduced infrastructure costs by 30%" not "optimized container resource requests"
- Never more than 3 key outcomes. Executives process in threes.
- Risk items are mandatory even if the answer is "none." Executives want to know you checked.
- Include trend direction so they can pattern-match across reports over time
- Keep the whole thing under 200 words. Ruthlessly cut.

---

## External Community (Contributor-Friendly, Appreciative)

**Who reads this:** Open source contributors, community members, downstream users, potential contributors.

**What they care about:** What is new that they can use, how to contribute, recognition of community contributions, the project's health and momentum.

**Tone:** Welcoming and transparent. Grateful for contributions. Encouraging of new contributors.

**Length:** 300-500 words. Long enough to be informative, short enough to be read.

### Template

```
# <repo name> Community Update
## <timeframe> (<start date> to <end date>)

Hey folks,

Here is what landed in <repo name> over the past <period>. Thanks to everyone who contributed.

### Highlights

- **<title>** - <what it does and why users will care.> ([#<number>](<url>)) - thanks @<author>!
- **<title>** - <user-facing summary.> ([#<number>](<url>)) - thanks @<author>!

### Welcome, New Contributors!

A warm welcome to the following people who landed their first contribution this period:

- @<username> contributed <brief description> in [#<number>](<url>)
- @<username> contributed <brief description> in [#<number>](<url>)

### What's Changed

**New Features**
- <title> by @<author> in [#<number>](<url>)

**Bug Fixes**
- <title> by @<author> in [#<number>](<url>)

**Documentation**
- <title> by @<author> in [#<number>](<url>)

**Other Improvements**
- <title> by @<author> in [#<number>](<url>)

### How to Get Involved

- Check out our [good first issues](<link>) if you are looking for a place to start
- Join the discussion in [<community channel>](<link>)
- Review open PRs: fresh eyes always help

### By the Numbers

This period saw **<count> contributions** from **<count> community members**, with **<new count> first-time contributors**. The project is growing and we appreciate every contribution, from typo fixes to major features.

---
*Full changelog: [compare view](<compare url>)*
```

### Key rules for community audiences
- Thank contributors by name. Every. Single. One.
- Welcome new contributors explicitly and warmly
- Frame changes in terms of what users can do, not what the code does
- Include a "How to Get Involved" section. Always be recruiting.
- Share the numbers to show project health and momentum
- Use an approachable, human tone. This is not a corporate memo.
- Link to the compare view so anyone can see the full diff

---

## Choosing the Right Template

| Audience | Use When | Key Command |
|----------|----------|-------------|
| Engineering Team | Sprint retros, team syncs, architecture reviews | `/shipped` |
| Product Management | Roadmap reviews, stakeholder updates, customer briefings | `/shipped-email` |
| Executive Leadership | Leadership syncs, board prep, program reviews | `/shipped-email` (with editing) |
| External Community | Release announcements, community updates, blog posts | `/shipped-release-notes` or `/shipped-narrative` |
| Team Morale | Sprint celebrations, Slack shoutouts, team meetings | `/shipped-celebration` |
| Trend Analysis | Retrospectives, velocity discussions, planning | `/shipped-delta` |

Each command produces output optimized for its primary audience. Use these templates as a reference when you need to further customize the output for a specific context.
