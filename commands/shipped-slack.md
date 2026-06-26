Your team shipped work this week that deserves more than a silent merge notification. Your job is to write a Slack message about it that engineers react to with :ship: and leadership reads without asking for a follow-up meeting. Not a wall of text. A dense, scannable update that tells the story in under 30 seconds of reading.

## Why Slack updates matter

Most Slack channel updates are either too sparse ("shipped 12 PRs this week") or too long (a pasted changelog that everyone scrolls past). Good ones land in the middle: enough context to understand what happened, dense enough to finish reading, and structured so people can scan to the part they care about.

## Calibration

Bad: "12 PRs merged this week."
Good: "The team shipped hybrid retrieval and streaming responses. Answer quality is up 23% and perceived latency dropped from 8s to under 1s."

Bad: "Various bug fixes and improvements."
Good: "4 fixes this week, including the OOM on large context windows that had been causing pod restarts under load."

Bad: "Great sprint! The team shipped a lot of important work."
Good: "Shipped: disaggregated prefill support (3 PRs, 2 weeks). This cuts cold-start latency by 60% for models over 13B params. Also: fixed a race condition in the router that caused 0.1% of requests to 504 under load."

Bad housekeeping line: "3 dependency updates."
Good housekeeping line: "3 dependency updates, including a critical patch for CVE-2024-3156 in the auth library and a Go 1.22 bump that unblocks the generics migration."

## Your approach

Think through this in stages:
1. Gather all merged PRs and releases
2. Find the story: what was the team focused on?
3. Write for Slack's constraints: scannable, dense, emoji-structured, under 2000 characters if possible
4. Make engineers want to add a :ship: react when they see it
5. Give infrastructure and maintenance work the context it deserves

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

## Step 3.5: Handle edge cases before analysis

Before grouping by theme, check for these situations and handle them honestly:

**Zero or near-zero PRs merged:**
If nothing shipped in the period, say so directly. Produce a short Slack message that confirms the timeframe and notes zero PRs merged. Do not pad with open PRs or speculation. One honest line in Slack is better than a padded update that makes the team cringe. If releases were tagged from earlier work, note those.

**All dependency bumps, CI fixes, or bot-generated PRs:**
This is still a Slack-worthy update. The framing shifts: "The team invested in reliability this sprint" with specific callouts for CVEs patched, EOL versions replaced, or flaky tests fixed. Name the people who did the work. Infrastructure sprints deserve the same visibility as feature sprints.

**Lopsided contributions (one person did 90%+ of the work):**
Report it factually. If one engineer carried the sprint, name them and explain what they focused on. Do not flatten contributions to manufacture a team narrative. The Contributors line at the bottom will show the natural distribution. Note review contributions where visible.

**PRs spanning multiple repos:**
If PR bodies reference issues or PRs in other repos, note the cross-repo connection in the relevant theme. Engineers reading Slack want to know when a change in their repo has a counterpart landing somewhere else.

## Step 4: Find the story and group by theme

Do not just dump PRs into Features/Bugs buckets. Find 2-4 themes based on what the team was actually working on, and group PRs accordingly.

Group related PRs:
- Feature + follow-up fix: nest the fix under the feature
- Multi-part work: group as one entry with sub-bullets
- Revert + re-land: show only the final version

When infrastructure or maintenance work has real impact (CI speed improvements, security patches, dependency upgrades that unblock other work), give it its own theme with context. "Invested in reliability" or "Secured the dependency stack" tells a better story than "Housekeeping."

Assign impact sizing:
| Size | Criteria |
|------|----------|
| **Large** | 500+ lines changed OR 10+ files touched OR new user-facing capability or breaking change |
| **Medium** | 100-499 lines changed OR 4-9 files touched OR meaningful fix |
| **Small** | Under 100 lines, 3 or fewer files, minor fix/docs/infra |

## Step 5: Self-critique before outputting

Before producing the Slack message, verify:
- [ ] It is scannable in under 15 seconds
- [ ] The top highlights would make an engineer say "nice, we shipped that"
- [ ] No section uses "various improvements" as a catch-all
- [ ] Infrastructure work gets context, not just a line item
- [ ] If any category has more than 5 items, only the top 5 are shown with a "(+N more)" note
- [ ] Breaking changes are called out clearly
- [ ] The total message is under 2000 characters when possible (Slack truncates long messages)

## Step 6: Format for Slack

Use Slack's mrkdwn formatting. The output must be ready to copy and paste directly into a Slack channel.

IMPORTANT: Use Slack mrkdwn, NOT standard Markdown:
- Bold: `*text*` (single asterisk, not double)
- Links: `<url|display text>` (not `[text](url)`)
- Bullet lists: use dashes
- Code: backticks work the same
- No heading syntax (no `#` or `##`). Use bold and emoji for section headers.

Produce output in this format:

```
:ship: *What Shipped: <repo name>*
:calendar: <timeframe> (<start date> to <end date>)
:bar_chart: <total PRs> PRs merged by <contributor count> contributors | <release count> releases

> <One sentence capturing the overall story of the period. What was the team focused on? Make it specific, not generic.>

:star: *Worth Knowing*

1. *<title>* - <one sentence on why this matters, not just what it does> (<url|#number>) `[L]`
2. *<title>* - <one sentence> (<url|#number>) `[M]`
3. *<title>* - <one sentence> (<url|#number>) `[L]`

:thread: *<Theme 1 name>*
- <title> (<url|#number>) `[L]` @<author>
   - Follow-up: <fix title> (<url|#number>) `[S]`
- <title> (<url|#number>) `[M]` @<author>

:thread: *<Theme 2 name>*
- <title> (<url|#number>) `[M]` @<author>

:broom: *Housekeeping*
- <count> smaller changes: <brief summary of what they covered, with impact context>

:warning: *Breaking Changes*
- <title> (<url|#number>) `[L]` - <what breaks and what to do>

:busts_in_silhouette: *Contributors:* @<username> (<count>), @<username> (<count>), @<username> (<count>)
```

Omit any section that has zero entries. If there are more than 5 items in any theme, show the top 5 and add "(+N more)".

Housekeeping is intentionally compressed: a count and a brief summary, not individual line items. But give it impact context. Not "3 dependency updates" but "3 dependency updates including a security patch for the auth library." If there are only 1-2 housekeeping items, list them normally.

Do not wrap the output in a code block. The output should be the raw Slack message, ready to paste. Keep it dense and scannable. Slack messages that are too long get ignored.

**Cross-tool:** For a longer stakeholder email version, run `/shipped-email <repo> <timeframe>`.
