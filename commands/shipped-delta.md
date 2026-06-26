Every team has rhythms. Some sprints are all features. Some are all stabilization. Some are a mix. Your job is to compare back-to-back periods and surface what changed, so the team can see their own patterns and have better conversations about where their effort is going.

This is not about judging velocity as good or bad. A sprint where the team shipped fewer PRs but closed three long-standing bugs is a win, not a slowdown. A sprint with twice as many PRs but all of them small might signal the team is avoiding the hard problems. Context matters. Your job is to provide the context.

## Calibration

Bad observation: "PR volume decreased by 15%."
Good observation: "PR volume dropped from 20 to 17, but the focus shifted from small fixes to large features. The team shipped 3 Large PRs this period versus 1 last period, suggesting a deliberate shift from breadth to depth."

Bad observation: "Two new contributors joined."
Good observation: "Two new contributors shipped their first PRs this period: @chen (test infrastructure) and @patel (API docs). Both worked in areas where the team has had gaps."

## Your approach

Think through this in stages:
1. Determine the current period and its mirror period (same duration, immediately prior)
2. Gather PR data for both periods
3. Compute the same metrics for each period
4. Calculate deltas and identify meaningful shifts
5. Present the comparison in a way that surfaces patterns, not just numbers
6. Distinguish signal from noise: not every fluctuation is a trend

## Instructions

Parse the user's input from $ARGUMENTS. The input contains:
1. A repo identifier (owner/name format, or just the repo name if in the current org)
2. A timeframe for the current period (e.g., "last week", "last 2 weeks", "last month", "last sprint")

If either piece is missing, ask the user for it.

## Step 1: Determine both periods

Calculate the current period's date range, then mirror it backwards for the comparison period:

- "last week" = current: 7 days ago to today; previous: 14 days ago to 7 days ago
- "last 2 weeks" = current: 14 days ago to today; previous: 28 days ago to 14 days ago
- "last month" = current: 30 days ago to today; previous: 60 days ago to 30 days ago
- "last sprint" = treat as 2 weeks (current: 14 days ago to today; previous: 28 to 14 days ago)
- "last quarter" = current: start to end of that quarter; previous: the quarter before it
- Any other timeframe: calculate the duration and mirror it backwards

## Step 2: Fetch merged PRs for both periods

Run for the current period:
```
gh pr list --repo <repo> --state merged --search "merged:YYYY-MM-DD..YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,createdAt,author,url,additions,deletions,changedFiles
```

Run for the previous period:
```
gh pr list --repo <repo> --state merged --search "merged:YYYY-MM-DD..YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,createdAt,author,url,additions,deletions,changedFiles
```

Also fetch releases for both periods:
```
gh release list --repo <repo> --limit 50
```

## Step 3: Compute metrics for both periods

For each period, calculate:

### Volume
- Total PRs merged
- Total releases
- Total lines added
- Total lines removed
- Net lines changed

### Velocity
- Average time-to-merge (mergedAt minus createdAt)
- Median time-to-merge

### Contributors
- Unique contributors
- Top 3 contributors by PR count
- New contributors (present in current period but not in previous)
- Departing contributors (present in previous period but not in current)

### Category breakdown
- Features, Bug Fixes, Performance, Documentation, Infrastructure, Breaking Changes
- Use labels as primary signal, then title analysis

### Size distribution
- Large, Medium, Small PR counts

## Step 4: Calculate deltas

For each metric, compute the change:
- Absolute change (e.g., +5 PRs, -2 contributors)
- Percentage change where meaningful
- Direction indicator: up, down, or stable (within 10% = stable)

## Step 5: Identify the story in the deltas

Go beyond raw numbers. Look for:
- **Focus shifts:** Did the ratio of features to fixes change significantly? Is the team building or stabilizing?
- **Velocity changes:** Is the team speeding up or slowing down? Did PR size distribution shift?
- **Team changes:** New faces or missing regulars? Growth or contraction?
- **Priority signals:** Which categories grew? Which shrank? What does that suggest about priorities?
- **Infrastructure investment:** Did infrastructure or maintenance work increase? That is often a sign the team is investing in sustainability.

Synthesize 3-5 key observations from the deltas. Be specific and grounded in data. When a shift is within normal variation, say so. Not every change is a trend.

## Step 6: Self-critique before outputting

Before producing the report, verify:
- [ ] Both periods use the same duration for a fair comparison
- [ ] Percentage changes are calculated correctly
- [ ] Direction indicators match the data (up means increase, down means decrease)
- [ ] Key observations are grounded in specific numbers, not vague impressions
- [ ] New and departing contributors are accurately identified
- [ ] The report acknowledges when changes are within normal variation
- [ ] Infrastructure and maintenance trends are called out when meaningful

## Step 7: Produce the delta report

Format the output like this:

```
# Shipped Delta: <repo name>
## Current: <current period dates> vs. Previous: <previous period dates>

> **The trend:** <2-3 sentence summary of the most important shifts. What changed and what does it signal? If the team shifted from features to infrastructure, explain why that matters.>

### Volume Delta
| Metric | Previous | Current | Change |
|--------|----------|---------|--------|
| PRs merged | <count> | <count> | <+/- count> <up/down/stable indicator> |
| Releases | <count> | <count> | <+/- count> <indicator> |
| Lines added | +<count> | +<count> | <indicator> |
| Lines removed | -<count> | -<count> | <indicator> |
| Net change | <count> | <count> | <indicator> |

### Velocity Delta
| Metric | Previous | Current | Change |
|--------|----------|---------|--------|
| Avg time-to-merge | <duration> | <duration> | <indicator> |
| Median time-to-merge | <duration> | <duration> | <indicator> |

### Contributor Delta
| Metric | Previous | Current | Change |
|--------|----------|---------|--------|
| Unique contributors | <count> | <count> | <+/- count> <indicator> |
| Top contributor | @<name> (<count>) | @<name> (<count>) | |

**New this period:** @<username>, @<username>
**Not seen this period:** @<username>, @<username>

### Focus Shift
| Category | Previous | Current | Change |
|----------|----------|---------|--------|
| Features | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Bug Fixes | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Performance | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Documentation | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Infrastructure | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Breaking Changes | <count> (<percent>) | <count> (<percent>) | <indicator> |

### Size Distribution Shift
| Size | Previous | Current | Change |
|------|----------|---------|--------|
| Large | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Medium | <count> (<percent>) | <count> (<percent>) | <indicator> |
| Small | <count> (<percent>) | <count> (<percent>) | <indicator> |

---

### Key Observations

1. **<Observation title>** - <Specific, data-backed observation about what shifted and what it might mean. Reference actual numbers. If it is within normal variation, say so.>
2. **<Observation title>** - <Observation>
3. **<Observation title>** - <Observation>
4. **<Observation title>** - <Observation (if warranted)>
5. **<Observation title>** - <Observation (if warranted)>

---
*Compared <current PR count> PRs (current) against <previous PR count> PRs (previous) across equal <duration> periods.*
```

### Direction Indicators

Use these Unicode indicators in the Change column:
- Up (increase > 10%): the word "up" followed by an up arrow
- Down (decrease > 10%): the word "down" followed by a down arrow
- Stable (within 10%): the word "stable" followed by a level indicator

For volume and velocity, use the up/down/stable labels. Do not editorialize about whether up or down is good or bad in the table itself. Save interpretation for the Key Observations section, where you can provide the context that makes the numbers meaningful.
