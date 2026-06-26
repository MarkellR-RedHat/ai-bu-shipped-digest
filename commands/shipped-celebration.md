People remember being recognized. Not the generic "great job team" at the end of a standup, but the specific, earned kind: "You found the memory leak that had been causing OOMKills for three months. That fix is why we slept through the weekend."

Your job is to find those moments in a repo's recent activity and turn them into shoutouts that land. Call out specific people for specific things. "Fastest turnaround" and "most reviewed PR" matter because they signal that the team values speed and quality. "First-time contributor" matters because it signals that the team is welcoming. "Finally fixed" matters because it signals that hard problems do not get forgotten.

This is for Slack channels, team meetings, and morale. It should feel like a teammate wrote it, not a corporate communications department.

## Why this matters

Engineering teams are bad at celebrating their own work. The people who keep production running rarely get the same attention as the people who ship features. The person who reviews 15 PRs a week, the person who finally tracks down a race condition that has been open for 8 months, the person who writes the migration guide that saves everyone else a day of work. These contributions are real and they deserve to be named.

## Calibration

Bad: "Great work this sprint, team!"
Good: "@sarah landed the pod topology spread constraints that unlock zone-aware scheduling. This was the most requested feature in the past year, and she got it done in a single sprint."

Bad: "Thanks to everyone who contributed."
Good: "@dims merged the kubelet config fix in 47 minutes. From open to merged in less time than most meetings. That is velocity."

Bad: "Several team members fixed important bugs."
Good: "@wojtek-t finally closed the node lifecycle race condition (#94102). That issue had been open for 14 months. The long wait is over."

Bad closing: "Amazing work this sprint, everyone! Keep it up!"
Good closing: "22 PRs, a 14-month-old bug finally killed, and a first-time contributor who shipped a real fix on day one. That is the kind of sprint you remember."

## Your approach

Think through this in stages:
1. Gather all merged PRs with enough metadata to identify standout moments
2. Analyze for superlatives: biggest impact, fastest turnaround, most prolific contributor, etc.
3. Look for human stories: first-time contributors, long-standing issues finally fixed, impressive review efforts
4. Craft shoutouts that are specific and earned, not generic praise
5. Pay special attention to infrastructure, testing, and review work that often goes unrecognized

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

## Step 2: Fetch merged PRs with full metadata

```
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,createdAt,author,url,additions,deletions,changedFiles,reviews
```

## Step 3: Fetch additional context

Get release information:
```
gh release list --repo <repo> --limit 20
```

To check for first-time contributors, for each unique author, check if they had PRs merged before the period:
```
gh pr list --repo <repo> --state merged --author <username> --search "merged:<YYYY-MM-DD" --limit 1 --json number
```

To find long-standing issues that were closed by merged PRs, look for issue references in PR bodies (e.g., "Fixes #123", "Closes #456") and check when those issues were created:
```
gh issue view <number> --repo <repo> --json createdAt,title
```

## Step 4: Identify the highlight categories

Analyze the data to find standout moments in these categories:

### Biggest Impact PR
Not just the most lines changed. Look for the PR that:
- Introduced a new user-facing capability
- Fixed a significant pain point
- Had the most files touched in a meaningful way (not just a rename)
- Was referenced in a release

Explain why this was the most impactful change, not just what it did.

### Most Prolific Contributor
The person who merged the most PRs in the period. Note what they worked on. If they were doing unglamorous work (reviews, tests, dependency updates), say that and explain why it matters.

### Speed Demon
The PR with the fastest turnaround from creation to merge. Calculate (mergedAt minus createdAt) for all PRs and find the minimum. This signals that the team values velocity and can move fast when the change is clear.

### Most Reviewed PR
The PR that received the most reviews (from the reviews field). This often indicates complex or important work that got thorough scrutiny. The author and the reviewers both deserve recognition here.

### First-Time Contributor(s)
Anyone whose first-ever merged PR to this repo fell within the period. These people deserve a warm, specific welcome. Do not just say "welcome." Say what they contributed and why it matters.

### Long-Standing Fix
Look for PRs that reference issues (via "Fixes #N" or "Closes #N" in the body). Check when those issues were created. If any issue was open for more than 30 days before being fixed, that is a "finally fixed" moment. Name how long the issue was open.

### Bonus Categories (include if the data supports them)
- **Biggest Cleanup:** The PR that removed the most lines (net negative diff), making the codebase leaner. This is the kind of work that rarely gets celebrated but makes everyone's life better.
- **Documentation Hero:** The contributor who shipped the most docs changes. Documentation is how teams scale their knowledge.
- **Multi-Tool Player:** A contributor who worked across multiple categories (features, fixes, docs, infra). Versatility matters.
- **Review Champion:** If review data is available, the person who reviewed the most PRs. Code review is invisible, essential work.

## Step 5: Self-critique before outputting

Before producing the celebration post, verify:
- [ ] Every shoutout is specific: names the person, names the PR, explains why it matters
- [ ] The tone is genuine, not corporate. No "synergy" or "leveraging" language.
- [ ] First-time contributors get a real welcome, not a boilerplate line
- [ ] Infrastructure and maintenance contributors are recognized, not just feature builders
- [ ] The post is scannable and fun to read
- [ ] Nothing is forced; if a category has no interesting data, skip it
- [ ] Numbers are accurate (especially turnaround times)

## Step 6: Format as a Slack celebration post

Use Slack mrkdwn formatting. The output must be ready to paste into Slack.

IMPORTANT: Use Slack mrkdwn, NOT standard Markdown:
- Bold: `*text*` (single asterisk, not double)
- Links: `<url|display text>` (not `[text](url)`)
- No heading syntax. Use bold and emoji.

Produce output in this format:

```
:trophy: *Ship It Awards: <repo name>*
:calendar: <timeframe> (<start date> to <end date>)

:tada: The team merged *<total PRs> PRs* from *<contributor count> contributors* this period. Here are the standout moments:

---

:rocket: *Biggest Impact*
<title> by @<author> (<url|#number>)
<Why this was the most impactful change of the period. Be specific about the user or team impact, not just the technical change.>

:medal: *Most Prolific*
@<author> shipped *<count> PRs* this period, working on <brief description of what they focused on>. <If they did infrastructure or maintenance work, explain why that matters.>

:zap: *Speed Demon*
<title> by @<author> (<url|#number>)
Merged in *<duration>* from open to merge. <Brief note on why fast turnaround matters for this kind of change.>

:mag: *Most Reviewed*
<title> by @<author> (<url|#number>)
Received *<count> reviews*. Complex work that got the scrutiny it deserved. <Shout out reviewers if data is available.>

:wave: *Welcome, New Contributor(s)!*
@<username> landed their first PR: <title> (<url|#number>). <One sentence about what they contributed and why it matters.> Welcome to the team!

:calendar: *Finally Fixed*
<title> by @<author> (<url|#number>)
This closed <issue url|#issue_number>, which had been open for *<duration>*. <One sentence about why this fix matters and why it was hard.>

:broom: *Biggest Cleanup*
<title> by @<author> (<url|#number>)
Removed *<count> lines*, making the codebase leaner and more maintainable. <One sentence about what they cleaned up.>

---

:clap: <Closing line that feels earned. Reference something specific about this period. Not a generic sign-off.>
```

### Rules

- Omit any category that does not have interesting data. Do not force categories.
- Every shoutout names the person (@username), names the PR (linked), and explains in one sentence why it stands out.
- Keep the tone warm but genuine. Celebrate real accomplishments, not participation.
- Do not wrap the output in a code block. The output is the raw Slack message, ready to paste.
- If multiple people tie for a category (e.g., two people each shipped 5 PRs), mention both.
- First-time contributor detection is best-effort. If you cannot determine this reliably, omit the section.
- The closing line should reference something specific about this sprint or period. "Great work, team" is not specific enough. Try something like "42 PRs, 3 long-standing bugs closed, and a first-time contributor. That is a sprint to remember."
