# shipped-digest

**Turn merged PRs into digests worth reading.**

## The Problem

Your team shipped 23 PRs this week. Someone asks what that means for the product. You open GitHub, scroll through titles like `fix: update retry logic` and `refactor: extract helper`, and try to explain the story. It takes an hour. Or you skip it, and the work stays invisible.

The person who spent three days upgrading dependencies and patching a critical CVE gets the same acknowledgment as the person who fixed a typo: none.

## Before and After

**Before** (what leadership sees):

```
- fix: update retry logic in scheduler (#4521)
- refactor: extract pod helper (#4519)
- chore: bump go to 1.22 (#4517)
- fix: race condition in node controller (#4515)
- feat: add topology spread constraints (#4512)
  ... 18 more
```

**After** (what `/shipped` produces):

```
## Making the Scheduler Production-Ready [L]
The centerpiece this sprint was topology spread constraints (#4512, @liggitt),
one of the most requested features in the past year. A follow-up retry fix
(#4521, @dims) landed two days later to handle edge cases in multi-zone clusters.

## Keeping Production Running [M]
@wojtek-t closed a 14-month-old race condition in the node lifecycle controller
(#4515, closing #94102). The Go 1.22 upgrade (#4517, @dims) included a critical
security patch for CVE-2024-XXXX.
```

Same PRs. One version is a list. The other is a story your VP forwards.

## Quick Start

```bash
# 1. Install (copies slash commands into ~/.claude/commands/)
git clone https://github.com/MarkellR-RedHat/ai-bu-shipped-digest.git
cd ai-bu-shipped-digest
bash install.sh

# 2. Open Claude Code in any repo and run:
/shipped kubernetes/kubernetes last week
```

That's it. Nine commands, globally available, no config files.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- [GitHub CLI](https://cli.github.com/) (`gh`) installed and authenticated
- Access to the repos you want to scan

## Commands

### Core Digests

| Command | Output | When to Use |
|---------|--------|-------------|
| `/shipped` | Theme-grouped digest with impact sizing (`[L]`/`[M]`/`[S]`) | Sprint reviews, team syncs |
| `/shipped-email` | Stakeholder email under 500 words | Leadership updates, cross-functional briefings |
| `/shipped-slack` | Slack message with mrkdwn and emoji | Channel updates, async standups |
| `/shipped-release-notes` | GitHub Release notes with contributor attribution | Release pages, CHANGELOG files |
| `/shipped-compare` | Cross-repo unified analysis | Portfolio reviews, org-wide rollups |
| `/shipped-metrics` | Quantitative metrics with health indicators | Velocity tracking, retrospectives |

### Narrative and Celebration

| Command | Output | When to Use |
|---------|--------|-------------|
| `/shipped-narrative` | 3-5 paragraph prose for non-technical readers | All-hands, blog posts, customer updates |
| `/shipped-celebration` | Highlight reel with specific shoutouts | Slack celebrations, team meetings |
| `/shipped-delta` | Period-over-period trend analysis | Sprint retros, velocity discussions |

## Usage Examples

### Story-driven digest

```
/shipped kubernetes/kubernetes last month
```

Groups PRs into themes like "Making the scheduler production-ready" instead of flat category buckets. Infrastructure work gets elevated with impact context.

### Stakeholder email

```
/shipped-email openshift/lightspeed-service last week
```

Subject line worth opening, 50-word opening paragraph, "What Matters Most" section focused on business impact. The kind of email an engineering lead would send if they enjoyed writing.

### Narrative for all-hands

```
/shipped-narrative openshift/lightspeed-service Q2 2026
```

Turns raw PR data into prose a VP would read:

> Going into Q2, the lightspeed-service team faced a clear challenge: the query pipeline worked, but it was not production-ready. The team set out to fix response times, answer relevance, and load handling in a single quarter.

### Team celebration

```
/shipped-celebration kubernetes/kubernetes last sprint
```

Specific shoutouts, not "great job, team":

> :rocket: **Biggest Impact** - Add pod topology spread constraints by @liggitt (#118234)
> This unlocks zone-aware scheduling for multi-region clusters.

### Cross-repo comparison

```
/shipped-compare kubernetes/kubernetes, openshift/lightspeed-service last month
```

Unified view with cross-cutting observations and coordinated work detection.

### Trend analysis

```
/shipped-delta my-org/my-repo last 2 weeks
```

Compares current period against the prior period of equal length. Shows volume, velocity, and contributor deltas with direction indicators.

## What Makes This Different

Most changelog tools dump PRs into buckets: features, bugs, docs. These commands find the narrative thread.

- **Theme-based grouping** that tells a coherent story, not just a category list
- **Intelligent PR clustering** that recognizes feature + follow-up fix pairs, multi-part work, and revert/re-land sequences
- **Honest impact sizing** tagged as `[L]`, `[M]`, or `[S]` based on lines, files, and user-facing scope
- **Infrastructure elevation** that explains why maintenance work matters instead of burying it
- **Contributor attribution** that tracks who drove the work, including the unglamorous work
- **Self-critique** that verifies related PRs are grouped, impact is not inflated, and maintenance work gets proper context

## How It Works

The commands use `gh` to pull merged PRs from the GitHub API. Each PR is analyzed by title, body, and labels. Related PRs are clustered into themes based on shared goals. Each PR is sized by lines changed and files touched. Output is tailored to the target audience and format.

The key difference from traditional changelog generators: a feature PR, its follow-up fix, and the related performance improvement become one story, not three disconnected line items.

No data leaves your machine beyond the standard GitHub API calls that `gh` already makes.

## Reference Materials

The `formats/` directory contains output templates (Markdown, Slack mrkdwn, email). The `reference/` directory has audience-specific formatting guidance for engineering, product, executive, and community audiences.

## License

Apache-2.0
