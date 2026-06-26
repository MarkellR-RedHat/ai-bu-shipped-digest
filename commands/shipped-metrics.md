Numbers tell a story if you know which ones to look at. Your job is to scan a GitHub repo's merged PRs and releases over a given time period and produce a quantitative metrics report that surfaces the patterns in the data.

This report is for engineering leads who want to understand team velocity and health, and for retrospectives where the team wants to see their own output objectively. The numbers should be precise and the presentation should make patterns visible without editorializing.

## Calibration

The Health Indicators section is where this report earns its keep. A 70% small-PR rate tells a story about disciplined, frequent merges. A 15% small-PR rate tells a different story. Let the numbers speak, but choose the right numbers to present.

## Your approach

Think through this in stages:
1. Gather all PR metadata for the period
2. Compute every metric with precision
3. Present the numbers in a way that surfaces patterns, not just raw data
4. Let the data tell its own story without editorializing

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
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,labels,mergedAt,createdAt,author,additions,deletions,changedFiles
```

If the timeframe references a tag, first get the tag date:
```
gh api repos/<owner>/<repo>/git/refs/tags/<tag> --jq '.object.sha' | xargs -I {} gh api repos/<owner>/<repo>/git/commits/{} --jq '.committer.date'
```

## Step 3: Fetch releases

```
gh release list --repo <repo> --limit 50
```

## Step 4: Compute metrics

Calculate ALL of the following metrics from the fetched data:

### Volume metrics
- Total PRs merged
- Total releases tagged
- Total lines added (sum of all PR additions)
- Total lines removed (sum of all PR deletions)
- Net lines changed (additions minus deletions)
- Total files changed (sum of changedFiles across all PRs, noting that files may overlap)

### Size distribution
- Large PRs: count of PRs with 500+ lines changed or 10+ files
- Medium PRs: count of PRs with 100-499 lines changed or 4-9 files
- Small PRs: count of PRs under 100 lines changed and 3 or fewer files

### Velocity metrics
- Time-to-merge average: for each PR, calculate (mergedAt minus createdAt). Report the average in hours or days.
- Time-to-merge median: same calculation, median value
- Fastest merge: the PR that was merged most quickly (title, number, and duration)
- Slowest merge: the PR that took the longest (title, number, and duration)

### Contributor metrics
- Total unique contributors
- Top 5 contributors by PR count (username and count)
- Top contributor by lines changed (username and total lines)
- Single-PR contributors count (contributors with exactly 1 PR in the period)

### Category breakdown
- Features count
- Bug Fixes count
- Performance count
- Documentation count
- Infrastructure count
- Breaking Changes count

Use labels as primary signal, then fall back to title analysis for categorization.

### Temporal metrics
- Busiest day of the week (which weekday had the most merges)
- Busiest date (which specific date had the most merges)
- PRs per week average (total PRs divided by weeks in the period)

### Health indicators
- Percentage of PRs that are Small (high percentage = good hygiene, frequent small merges)
- Ratio of features to bug fixes (context on where effort is going)
- Single-PR contributor percentage (high percentage may indicate drive-by contributions or onboarding activity)

## Step 5: Produce the metrics report

Format the output like this:

```
# Shipped Metrics: <repo name>
## <timeframe> (<start date> to <end date>)

### Volume
| Metric | Value |
|--------|-------|
| PRs merged | <count> |
| Releases tagged | <count> |
| Lines added | +<count> |
| Lines removed | -<count> |
| Net change | <+/- count> |
| Files changed | <count> |

### PR Size Distribution
| Size | Count | % |
|------|-------|---|
| Large (500+ lines or 10+ files) | <count> | <percent> |
| Medium (100-499 lines or 4-9 files) | <count> | <percent> |
| Small (<100 lines, <=3 files) | <count> | <percent> |

### Merge Velocity
| Metric | Value |
|--------|-------|
| Average time-to-merge | <duration> |
| Median time-to-merge | <duration> |
| Fastest merge | <title> (#<number>) in <duration> |
| Slowest merge | <title> (#<number>) in <duration> |

### Contributors
| Metric | Value |
|--------|-------|
| Unique contributors | <count> |
| Single-PR contributors | <count> (<percent>) |

**Top contributors by PRs:**

| Contributor | PRs | Lines changed |
|-------------|-----|---------------|
| @<username> | <count> | +<add>/-<del> |
| @<username> | <count> | +<add>/-<del> |
| @<username> | <count> | +<add>/-<del> |
| @<username> | <count> | +<add>/-<del> |
| @<username> | <count> | +<add>/-<del> |

### Category Breakdown
| Category | Count | % |
|----------|-------|---|
| Features | <count> | <percent> |
| Bug Fixes | <count> | <percent> |
| Performance | <count> | <percent> |
| Documentation | <count> | <percent> |
| Infrastructure | <count> | <percent> |
| Breaking Changes | <count> | <percent> |

### Activity Pattern
| Metric | Value |
|--------|-------|
| Busiest day of week | <day> (<count> merges) |
| Busiest date | <date> (<count> merges) |
| PRs per week (avg) | <count> |

### Health Indicators
| Metric | Value | Signal |
|--------|-------|--------|
| Small PR percentage | <percent> | <"Healthy" if >50%, "Monitor" if 30-50%, "Review process" if <30%> |
| Feature-to-fix ratio | <ratio> | <"Building" if >2:1, "Balanced" if 1:1 to 2:1, "Stabilizing" if <1:1> |
| Single-PR contributor % | <percent> | <context note> |

---
*Metrics computed from <total PRs> merged PRs across <duration of period>.*
```

Stick to the numbers. The Health Indicators section provides simple signal labels, but do not add commentary, opinions, or recommendations beyond those labels. Let the data speak.
