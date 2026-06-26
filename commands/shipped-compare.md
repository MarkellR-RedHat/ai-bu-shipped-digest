When leadership asks "what did we ship across all our repos?" they do not want to read three separate changelogs. They want one view that shows how work flowed across the organization: where teams coordinated, where priorities aligned, where effort concentrated, and who contributed across boundaries.

Your job is to compare what shipped across multiple repos in the same timeframe and produce a unified picture. Not parallel changelogs pasted together, but a cross-cutting analysis that surfaces patterns no single-repo view would reveal.

## Calibration

Bad cross-cutting observation: "Both repos had active development this period."
Good cross-cutting observation: "@saldana shipped work in both lightspeed-service (hybrid retrieval) and lightspeed-operator (deployment automation for the new retrieval backend). These are two halves of the same initiative."

Bad summary: "Repo A merged 18 PRs and Repo B merged 24 PRs."
Good summary: "Both teams invested heavily in production readiness this period. lightspeed-service focused on query reliability while lightspeed-operator focused on deployment automation. The shared theme is getting ready for GA."

## Your approach

Think through this in stages:
1. Gather merged PRs and releases from each repo
2. For each repo, find the narrative: what was that team focused on?
3. Look across repos for patterns: coordinated work, shared themes, velocity differences
4. Produce a comparison that helps leadership understand the full picture in one read

## Instructions

Parse the user's input from $ARGUMENTS. The input contains:
1. Two or more repo identifiers (owner/name format, or just repo names), separated by commas or spaces
2. A timeframe (e.g., "last week", "last month", "since 2026-06-01", "Q2 2026")

If the repos or timeframe are missing, ask the user.

## Step 1: Determine the date range

Convert the timeframe into concrete start and end dates:
- "last week" = 7 days ago to today
- "last month" = 30 days ago to today
- "last quarter" or "Q1/Q2/Q3/Q4 YYYY" = the start and end of that quarter
- Any other natural language date range, interpret it reasonably

## Step 2: For each repo, fetch merged PRs

Run the following for every repo:

```
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,author,url,additions,deletions,changedFiles
```

Also check for releases:
```
gh release list --repo <repo> --limit 20
```

## Step 3: For each repo, find the story and group by theme

For each repo independently:
- Identify 2-4 themes based on the work's purpose, not rigid categories
- Group related PRs (feature + follow-up fix, multi-part work, revert + re-land)
- Assign impact sizing: Large (500+ lines or 10+ files or user-facing), Medium (100-499 lines or 4-9 files), Small (under 100 lines, 3 or fewer files)
- Note infrastructure and maintenance work with impact context

## Step 4: Cross-repo analysis

This is what makes a comparison digest valuable. Look for:
- **Coordinated work:** Did multiple repos ship pieces of the same feature or initiative? Name the initiative and show how the pieces fit together.
- **Shared themes:** Are multiple repos doing the same type of work (all doing perf, all doing stabilization)? That suggests an organizational priority.
- **Velocity patterns:** Which repos were busiest? Which were quiet? Is that expected or surprising?
- **Cross-cutting contributors:** Anyone who shipped work in multiple repos? These people are connecting the dots across teams.
- **Infrastructure investment:** Did multiple repos invest in infrastructure or reliability? That is worth surfacing as a shared priority.
- **Divergent priorities:** Are repos pulling in different directions, or aligned? Both are fine, but leadership wants to see the pattern.

## Step 5: Self-critique before outputting

Before producing the digest, verify:
- [ ] Each repo's summary tells a story, not just lists PRs
- [ ] Cross-cutting themes are identified (not just per-repo summaries side by side)
- [ ] Impact sizing is honest and consistent across repos
- [ ] Infrastructure and maintenance work gets context, not dismissal
- [ ] The summary table gives the full picture at a glance
- [ ] Contributors who work across repos are highlighted

## Step 6: Produce the comparison digest

Format the output like this:

```
# Cross-Repo Shipped Digest
## <timeframe> (<start date> to <end date>)

> **The big picture:** <2-3 sentences describing the overall story across all repos. What were the teams collectively focused on? Any coordinated efforts? Any notable patterns?>

### Summary Table

| Repo | PRs Merged | Releases | Contributors | Top Theme | Biggest Change |
|------|-----------|----------|--------------|-----------|----------------|
| <repo1> | <count> | <count> | <count> | <theme name> | <one-liner> |
| <repo2> | <count> | <count> | <count> | <theme name> | <one-liner> |

---

### <repo1 name>

> <One sentence: what was this repo's team focused on this period?>

**<Theme 1>** (High Impact)
- <title> ([#<number>](<url>)) `[L]` @<author>
  - Follow-up: <fix title> ([#<number>](<url>)) `[S]`
- <title> ([#<number>](<url>)) `[M]` @<author>

**<Theme 2>** (Medium Impact)
- <title> ([#<number>](<url>)) `[S]` @<author>

**Housekeeping:** <count> smaller changes covering <brief summary with impact context>

### <repo2 name>

(same format)

---

### Cross-Cutting Observations

<3-5 bullet points about patterns across repos. Be specific and factual:>
- <observation about coordinated work, shared themes, velocity differences, or contributor patterns>
- <observation>
- <observation>

### Cross-Repo Contributors

Contributors who merged PRs in more than one repo during this period:

| Contributor | Repos | Total PRs |
|-------------|-------|-----------|
| @<username> | <repo1>, <repo2> | <count> |

---
*Generated from <total PRs> merged PRs across <repo count> repos by <total contributors> contributors.*
```

Keep it factual. Write for an audience that wants cross-team visibility without reading every repo's changelog individually. The value is in the cross-cutting analysis, not just putting two changelogs next to each other.
