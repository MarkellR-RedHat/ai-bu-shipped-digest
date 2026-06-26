Your team shipped real work this week. Your job is to write an email about it that a VP reads in 60 seconds, understands the value, and forwards to their leadership chain. Not a changelog pasted into an email body. A briefing that makes technical work legible to someone who was not in the code.

Engineering leads need to report upward but hate writing about their own work. It feels like self-promotion. So they send a bullet list of PR titles and hope someone reads it. Nobody does. Your job is to write the email they would send if they had time and enjoyed writing: clear, compelling, honest, and under 500 words.

## Calibration

Bad subject line: "Engineering update: 18 PRs merged"
Good subject line: "lightspeed-service shipped hybrid retrieval | 23% relevance improvement"

Bad opening: "This email summarizes the recent engineering activity in our repository."
Good opening: "The team spent this period making the query pipeline production-ready. The headline result: answer relevance is up 23% and response times dropped from 8 seconds to under 1 second for long answers."

Bad highlight: "Merged PR #892: Add RAG pipeline v2 with hybrid retrieval"
Good highlight: "Hybrid retrieval replaces single-vector lookup with a combined dense and sparse approach, improving answer relevance by 23% on internal benchmarks. This is the largest single improvement to answer quality since launch."

Bad infrastructure framing: "The team also completed several infrastructure improvements."
Good infrastructure framing: "The CI pipeline moved from Jenkins to Tekton, cutting build times from 22 minutes to 8 and eliminating the flaky integration test stage that was blocking 1 in 4 merges. This is invisible to users but directly reduces the time between 'code ready' and 'code shipped.'"

## Your approach

Think through this in stages:
1. First, gather all the data
2. Then, figure out the 3-5 things that actually matter to someone two levels up
3. Write an email that respects their time: lead with impact, follow with evidence
4. Make it something the team would be proud to see forwarded
5. Elevate infrastructure work by explaining its impact in business terms

## Instructions

Parse the user's input from $ARGUMENTS. The input contains:
1. A repo identifier (owner/name format, or just the repo name if in the current org)
2. A timeframe (e.g., "last week", "last month", "since v0.5.0", "Q2 2026")

If either piece is missing, ask the user for it.

## Step 1: Determine the date range

Convert the timeframe into concrete dates or a tag reference:
- "last week" = 7 days ago to today
- "last month" = 30 days ago to today
- "last quarter" or "Q1/Q2/Q3/Q4 YYYY" = the start and end of that quarter
- "since vX.Y.Z" = from that tag's date to today
- Any other natural language date range, interpret it reasonably

## Step 2: Fetch merged PRs

```
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,author,url,additions,deletions,changedFiles,reviewDecision
```

If the timeframe references a tag, first get the tag date:
```
gh api repos/<owner>/<repo>/git/refs/tags/<tag> --jq '.object.sha' | xargs -I {} gh api repos/<owner>/<repo>/git/commits/{} --jq '.committer.date'
```

## Step 3: Fetch releases

```
gh release list --repo <repo> --limit 50
```

Fetch details for relevant releases:
```
gh release view <tag> --repo <repo> --json tagName,name,body,publishedAt
```

## Step 4: Think like an executive reader

Before writing anything, answer these questions:
- **What is the single most important thing that shipped?** The one thing worth mentioning if you only had one sentence.
- **What capability does the team have now that it did not have before this period?**
- **What risk was reduced or eliminated?** Security patches, stability fixes, and dependency upgrades reduce risk. Name the risk that was reduced.
- **What is the velocity story?** More output than last period? Fewer? Same but different focus?
- **Who drove the work?** Leadership wants to know who to recognize.
- **What invisible work kept production running?** CI improvements, dependency upgrades, test coverage. Translate these into business language: "reduced deployment risk" or "cut CI time by 60%, freeing developer time."

## Step 5: Classify and group changes

Group PRs by theme (not just category). Look for:
- Clusters of related PRs that represent coordinated effort
- Feature + follow-up fix pairs (nest the fix under the feature)
- Multi-part work (group as one entry with sub-bullets)
- Revert + re-land (show only the final version)
- Infrastructure work that deserves its own theme when the impact warrants it

Assign impact sizing:
| Size | Criteria |
|------|----------|
| **Large** | 500+ lines changed OR 10+ files touched OR new user-facing feature or breaking change |
| **Medium** | 100-499 lines changed OR 4-9 files touched OR meaningful fix |
| **Small** | Under 100 lines, 3 or fewer files, minor fix/docs/infra |

## Step 6: Self-critique before writing

Before producing the email, verify:
- [ ] The subject line would make someone open the email, not archive it
- [ ] The first paragraph gives the full picture in under 50 words
- [ ] Highlights focus on impact ("users can now...") not mechanics ("merged PR #123")
- [ ] Infrastructure work is framed in terms of risk reduction, velocity improvement, or reliability
- [ ] Breaking changes are flagged clearly with action items
- [ ] Contributors are named so leadership can recognize them
- [ ] The email is under 500 words total (executives will not read more)
- [ ] Nothing is inflated; maintenance work is acknowledged honestly but with impact context

## Step 7: Format as a stakeholder email

Produce output in this format:

```
---
**Subject:** <repo name> shipped <number> changes | <the single most important thing, in 8 words or fewer>
---

Hi team,

<2-3 sentence opening that captures the overall arc of the period. What was the team focused on? What is the headline result? Write this so someone who reads only this paragraph walks away informed.>

### At a Glance
- **<total PRs>** pull requests merged by **<contributor count>** contributors
- **<release count>** releases published
- **Key focus:** <one phrase describing the dominant theme of the work>
- **Biggest win:** <one sentence about the most impactful change>

### What Matters Most

1. **<title>** - <Two sentences: what it does, and why a stakeholder should care. Focus on user or business impact, not implementation details.> [View PR](<url>) `[L]`

2. **<title>** - <Two sentences: impact-focused summary.> [View PR](<url>) `[L]`

3. **<title>** - <Two sentences: impact-focused summary.> [View PR](<url>) `[M]`

### Full Changelog

**<Theme 1 name>**
- <title> ([#<number>](<url>)) `[L]` @<author>
  - Follow-up: <fix title> ([#<number>](<url>)) `[S]`
- <title> ([#<number>](<url>)) `[M]` @<author>

**<Theme 2 name>**
- <title> ([#<number>](<url>)) `[M]` @<author>

**Housekeeping**
- <title> ([#<number>](<url>)) `[S]` @<author>

**Breaking Changes**
- <title> ([#<number>](<url>)) `[L]` @<author>
  Action required: <what users need to do>

### Releases

- **<version>** (<date>) - [Release notes](<url>)

### Contributors

| Contributor | PRs | Key Contributions |
|-------------|-----|-------------------|
| @<username> | <count> | <brief note on what they focused on> |
| @<username> | <count> | <brief note> |

---

Reply to this thread if you want a deeper dive into any of these changes.
```

Omit any section that has zero entries. Keep the total email under 500 words where possible. The tone is professional and direct: an engineer briefing leadership, not a marketing team writing a press release. Every sentence carries information. No filler. No fluff. The team should be proud to see this forwarded.
