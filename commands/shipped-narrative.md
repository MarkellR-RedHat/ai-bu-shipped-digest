This is not a changelog. This is the story of what a team built and why it matters.

Every team's week has a narrative arc. Maybe it started with @Sarah's profiling work on Monday that identified the bottleneck, which led to @James's fix on Wednesday, which @Lee validated with load testing on Thursday. P95 latency dropped from 340ms to 89ms. That is a story worth telling.

Your job is to find that arc in the raw data and write it as prose that a VP could read at an all-hands, a PM could include in a blog post, or a team lead could share with their skip-level. Not a list. Not a changelog. A narrative that connects the dots between individual PRs and shows the bigger picture.

## Why narrative matters

Engineering teams communicate in PRs and commits. Leadership communicates in stories and outcomes. The gap between these two is where good work becomes invisible. A team might ship 30 PRs in a quarter and still struggle to explain what they accomplished, because "we merged 30 PRs" is not a story. "We took response times from unusable to instant, locked down two critical security vulnerabilities, and built the foundation for multi-tenant support" is a story.

Your job is to bridge that gap. Read the PRs. Understand the connections. Tell the story.

## Calibration

Bad: "The team merged 52 PRs by 12 contributors across 6 releases."
Good: "Going into Q2, the lightspeed-service team faced a clear challenge: the query pipeline worked, but it was not production-ready. Answer relevance hovered around acceptable levels, response times were too slow for interactive use, and the system buckled under sustained load. The team set out to fix all three."

Bad: "Several performance improvements were made."
Good: "The centerpiece of the quarter was the new hybrid retrieval pipeline, led by @saldana, which replaced the single-vector lookup with a combined dense and sparse approach. Internal benchmarks showed a 23% improvement in answer relevance."

Bad: "Infrastructure work was also completed."
Good: "@bpatel migrated the entire CI pipeline to Tekton and stood up a load test suite targeting 500 concurrent users, giving the team confidence that what they shipped can handle real-world traffic."

## Your approach

Think through this in stages:
1. Gather all merged PRs and releases for the period
2. Understand the "why" behind the work: what problems were being solved?
3. Identify the narrative arc: setup (the challenge), action (what the team did), result (what changed)
4. Write prose that makes technical work accessible without dumbing it down
5. End with forward momentum: what does this work set up for the future?
6. Weave infrastructure and maintenance work into the story naturally, not as an afterthought

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
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,author,url,additions,deletions,changedFiles
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

## Step 4: Deep analysis for narrative construction

Go beyond surface-level classification. For each PR, understand:

- **The problem it solved:** Read the PR body for context. Why did this work need to happen?
- **The user impact:** Who benefits from this change? How does their experience improve?
- **The technical approach:** At a high level, what was the strategy? (Not implementation details, but the thinking.)
- **The connections:** How does this PR relate to other PRs in the period? Is it part of a larger initiative?
- **The invisible value:** Does this PR prevent future problems? Reduce risk? Improve developer experience? Make the next feature faster to ship?

Group the work into 2-4 major initiatives or themes. For each theme, identify:
- The problem or opportunity that motivated it
- The key changes that addressed it
- The outcome or impact
- The people who drove it

## Step 5: Construct the narrative arc

Structure the narrative as follows:

**Paragraph 1: The Setup**
What was the landscape going into this period? What challenges or opportunities was the team facing? This grounds the reader in context. Draw from PR descriptions and the overall pattern of work.

**Paragraph 2-3: The Action**
What did the team build? Walk through the major themes in order of impact. For each theme, explain:
- What was built or fixed (in plain language)
- Why it matters (the impact on users, operators, or the project's trajectory)
- Who drove the work (name key contributors naturally, not as a list)

Weave the themes together if they connect. If the team shipped a new feature and then immediately hardened it with fixes and perf work, that is one story, not three. If someone did critical infrastructure work, weave it in as part of the story, not as an afterthought section called "Other."

**Paragraph 4: The Numbers (optional, keep brief)**
If the quantitative picture is interesting, include a short paragraph: how many PRs, how many contributors, any notable velocity or scope observations. Skip this if the numbers are not remarkable.

**Paragraph 5: The Forward Look**
What does this work set up? Based on the trajectory of the PRs (what was being built, what patterns are emerging), offer a grounded statement about where the project is heading. Do not speculate wildly; base this on evidence from the work itself.

## Step 6: Self-critique before outputting

Before producing the narrative, verify:
- [ ] A non-technical reader could follow the story without confusion
- [ ] Technical terms are either explained or avoidable
- [ ] The narrative has a clear arc: setup, action, result
- [ ] Key contributors are named (people want to be recognized)
- [ ] Infrastructure and maintenance work is woven into the story, not buried at the end
- [ ] Impact is described in terms of user or business value, not just code changes
- [ ] The prose is direct and confident, not hedging or vague
- [ ] The narrative is 3-5 paragraphs, roughly 300-500 words
- [ ] Nothing is inflated; the story is grounded in what actually shipped
- [ ] No em dashes are used anywhere

## Step 7: Produce the narrative

Format the output like this:

```
# <repo name>: What We Shipped
## <timeframe> (<start date> to <end date>)

<Paragraph 1: The Setup>

<Paragraph 2: The Action, part 1>

<Paragraph 3: The Action, part 2 (if needed)>

<Paragraph 4: The Numbers (optional)>

<Paragraph 5: The Forward Look>

---

*Key contributors: @<username>, @<username>, @<username>, and <N> others.*
*Based on <total PR count> merged pull requests and <release count> releases.*

**Detailed changelog:** Run `/shipped <repo> <timeframe>` for the full breakdown.
```

Write in active voice. Use short sentences when making important points. Use longer sentences to connect ideas. Vary the rhythm.

Do not use bullet points in the narrative body. This is prose, not a list. The only structured elements are the title, the contributor line at the end, and the cross-reference to the detailed changelog.

The voice is confident, direct, and technical without being exclusionary. Write like a senior engineer explaining to their VP what the team accomplished and why it matters. No marketing language. No buzzwords. Just the story of good engineering work, told in a way that makes both the team and their leadership proud of what shipped.
