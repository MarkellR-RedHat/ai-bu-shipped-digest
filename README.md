# ai-bu-shipped-digest

Your team shipped 23 PRs this week. Can you explain what that means to someone who wasn't in the code?

Most engineering leads can't. Not because the work wasn't valuable, but because translating PRs into a story takes time they'd rather spend writing code. So the work stays invisible. Leadership doesn't know what shipped. Team members don't get recognized. The person who spent three days upgrading dependencies and patching a critical CVE gets the same acknowledgment as the person who fixed a typo: none.

These are Claude Code slash commands that turn a repo's merged PRs into digests worth reading. Not changelogs. Stories. The kind that leadership forwards, engineers feel proud of, and the person who did the invisible infrastructure work finally sees their contribution named and explained.

## What Makes This Different

Most changelog tools dump PRs into buckets: features, bugs, docs. That is useful but boring. These commands find the narrative thread in your team's work, group related PRs into themes, assess impact honestly, and produce output tailored to the audience.

A dependency upgrade becomes: "Upgraded 14 dependencies including a critical security patch for CVE-2024-XXXX. The kind of invisible work that keeps production running."

A set of performance PRs becomes: "What started as a P95 latency investigation turned into a 4-PR refactor that cut response times by 74%."

Infrastructure work gets the same narrative treatment as features, because both are worth celebrating.

Every command includes:
- **Theme-based grouping** that tells a coherent story, not just a category list
- **Intelligent PR clustering** that recognizes feature + follow-up fix pairs, multi-part work, and revert/re-land sequences
- **Honest impact sizing** tagged as `[L]`, `[M]`, or `[S]` based on lines, files, and user-facing scope
- **Infrastructure elevation** that explains why maintenance work matters instead of burying it under "Housekeeping"
- **Self-critique** that verifies related PRs are grouped, impact is not inflated, and maintenance work is acknowledged with proper context
- **Contributor attribution** that tracks who drove the work, including the unglamorous work

## Commands

### Core Digests

| Command | What It Produces | Best For |
|---------|-----------------|----------|
| `/shipped` | Story-driven digest grouped by themes with impact sizing | Sprint reviews, team syncs, engineering updates |
| `/shipped-email` | Stakeholder email a VP would read and forward | Leadership updates, cross-functional briefings |
| `/shipped-slack` | Slack message with mrkdwn and emoji, ready to paste | Channel updates, async standups |
| `/shipped-release-notes` | GitHub Release-style notes with contributor attribution | Release pages, CHANGELOG files |
| `/shipped-compare` | Cross-repo comparison with unified analysis | Portfolio reviews, org-wide rollups |
| `/shipped-metrics` | Pure quantitative metrics with health indicators | Velocity tracking, retrospectives |

### Narrative and Celebration

| Command | What It Produces | Best For |
|---------|-----------------|----------|
| `/shipped-narrative` | 3-5 paragraph prose narrative for non-technical readers | All-hands presentations, blog posts, customer updates |
| `/shipped-celebration` | Team highlight reel with specific shoutouts | Slack celebrations, team meetings, morale |
| `/shipped-delta` | Period-over-period trend analysis with direction indicators | Sprint retros, velocity discussions, planning |

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- [GitHub CLI](https://cli.github.com/) (`gh`) installed and authenticated
- Access to the repos you want to scan

## Installation

```bash
git clone https://github.com/MarkellR-RedHat/ai-bu-shipped-digest.git
cd ai-bu-shipped-digest
bash install.sh
```

This copies the command files into `~/.claude/commands/` so they are available globally in Claude Code.

Alternatively, clone this repo into your project's `.claude/commands/` directory to make the commands available only in that project.

## Usage

### Story-driven digest

```
/shipped kubernetes/kubernetes last month
```

Produces a narrative digest with themes like "Making the scheduler production-ready" and "Hardening CI/CD reliability" instead of flat category lists. Infrastructure work gets elevated with impact context, not buried in a housekeeping section.

### Stakeholder email

```
/shipped-email openshift/lightspeed-service last week
```

Produces an email with a subject line worth opening, a 50-word opening paragraph that tells the full story, and a "What Matters Most" section focused on user and business impact. Under 500 words. The kind of email an engineering lead would send if they enjoyed writing.

### Narrative for all-hands

```
/shipped-narrative openshift/lightspeed-service Q2 2026
```

This is where raw PR data becomes a story a VP would read. Instead of "52 PRs merged by 12 contributors," you get:

> Going into Q2, the lightspeed-service team faced a clear challenge: the query pipeline worked, but it was not production-ready. Answer relevance hovered around acceptable levels, response times were too slow for interactive use, and the system buckled under sustained load. The team set out to fix all three.
>
> The centerpiece of the quarter was the new hybrid retrieval pipeline, led by @saldana, which replaced the single-vector lookup with a combined dense and sparse approach. Internal benchmarks showed a 23% improvement in answer relevance. @jchen followed up with streaming response support, cutting perceived latency from 8 seconds to under 1 second for long answers.

The narrative weaves infrastructure work into the story naturally. @bpatel's CI migration and load testing are part of the story of getting production-ready, not an afterthought section.

### Team celebration

```
/shipped-celebration kubernetes/kubernetes last sprint
```

Produces a Slack-ready highlight reel with specific shoutouts. Not "great job, team" but:

> :rocket: *Biggest Impact*
> Add pod topology spread constraints for scheduler by @liggitt (#118234)
> This unlocks zone-aware scheduling for multi-region clusters, one of the most requested features in the past year.
>
> :zap: *Speed Demon*
> Fix typo in kubelet config docs by @dims (#118301)
> Merged in 47 minutes from open to merge.
>
> :calendar: *Finally Fixed*
> Fix race condition in node lifecycle controller by @wojtek-t (#118245)
> This closed #94102, which had been open for 14 months.

Every shoutout names the person, links the PR, and explains why it matters.

### Slack message

```
/shipped-slack my-org/my-repo last month
```

Produces a Slack-native message with mrkdwn formatting, emoji section headers, and a compressed housekeeping section with impact context. Optimized for scannability.

### Trend analysis

```
/shipped-delta my-org/my-repo last 2 weeks
```

Compares the current period against the immediately prior period of equal length. Shows volume, velocity, contributor, and focus deltas with up/down/stable indicators. Key observations distinguish meaningful shifts from normal variation.

### Cross-repo comparison

```
/shipped-compare kubernetes/kubernetes, openshift/lightspeed-service last month
```

Runs theme-based analysis across multiple repos and produces a unified view with cross-cutting observations, coordinated work detection, and cross-repo contributor tracking.

### Release notes

```
/shipped-release-notes my-org/my-repo since v1.2.0
```

Produces GitHub Release-style notes ready to paste into a release page or CHANGELOG, with new contributor detection and `by @username in #123` attribution.

### Metrics report

```
/shipped-metrics kubernetes/kubernetes Q2 2026
```

Pure numbers: volume, size distribution, merge velocity, contributor breakdown, category mix, temporal patterns, and health indicators (small PR percentage, feature-to-fix ratio, contributor diversity).

## Reference Materials

### Format Templates

The `formats/` directory contains reference templates for each output format:

- `formats/markdown.md` - Standard Markdown (GitHub issues, wikis)
- `formats/slack.md` - Slack mrkdwn with emoji
- `formats/email.md` - Stakeholder email

### Audience Templates

The `reference/digest-templates.md` file provides formatting guidance for adapting digests to specific audiences:

- **Engineering team** - Detailed, technical, includes root cause analysis and architecture context
- **Product management** - Feature-focused, roadmap-aligned, outcome-oriented
- **Executive leadership** - Impact-focused, under 200 words, metric-driven
- **External community** - Contributor-friendly, welcoming, includes "how to get involved"

## How It Works

The commands use the GitHub CLI (`gh`) to pull merged PRs and releases from the GitHub API. They analyze each PR by reading its title, body, and labels to understand context and purpose. Related PRs are clustered into themes based on shared goals, not just surface-level categories. Each PR is sized by lines changed and files touched. The output is tailored to the target audience and format.

The key difference from traditional changelog generators: these commands find the narrative in the work, not just the list. A feature PR, its follow-up fix, and the related performance improvement become one story, not three disconnected line items. Infrastructure work gets the same storytelling treatment as features, because the person who kept production running deserves to have that work explained, not just listed.

No data leaves your machine beyond the standard GitHub API calls that `gh` already makes.

## License

Apache-2.0
