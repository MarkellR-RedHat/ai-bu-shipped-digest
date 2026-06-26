# ai-bu-shipped-digest

Claude Code slash commands that turn a repo's merged PRs into digests worth reading. Not just changelogs. Stories of what your team shipped, told well enough that leadership forwards them and engineers feel proud.

Built for engineering leads, PMs, and PMMs who need to know what shipped without reading every PR.

## What Makes This Different

Most changelog tools dump PRs into buckets: features, bugs, docs. That is useful but boring. These commands find the narrative thread in your team's work, group related PRs into themes, assess impact honestly, and produce output tailored to the audience.

Every command includes:
- **Theme-based grouping** that tells a coherent story, not just a category list
- **Intelligent PR clustering** that recognizes feature + follow-up fix pairs, multi-part work, and revert/re-land sequences
- **Honest impact sizing** tagged as `[L]`, `[M]`, or `[S]` based on lines, files, and user-facing scope
- **Self-critique** that verifies related PRs are grouped, impact is not inflated, and maintenance work is acknowledged without being dressed up
- **Contributor attribution** that tracks who drove the work

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

Produces a narrative digest with themes like "Making the scheduler production-ready" and "Hardening CI/CD reliability" instead of flat category lists. Each theme shows its impact and attributes contributors.

### Stakeholder email

```
/shipped-email openshift/lightspeed-service last week
```

Produces an email with a subject line worth opening, a 50-word opening paragraph that tells the full story, and a "What Matters Most" section focused on user and business impact. Under 500 words.

### Slack message

```
/shipped-slack my-org/my-repo last month
```

Produces a Slack-native message with mrkdwn formatting, emoji section headers, and a compressed housekeeping section. Optimized for scannability.

### Narrative for all-hands

```
/shipped-narrative openshift/lightspeed-service Q2 2026
```

Produces 3-5 paragraphs of prose that tell the story of what the team built and why it matters. Written so a non-technical stakeholder can follow along. Includes a setup (the challenges), action (what shipped), and forward look (what this enables next).

### Team celebration

```
/shipped-celebration kubernetes/kubernetes last sprint
```

Produces a Slack-ready highlight reel with specific shoutouts: biggest impact PR, most prolific contributor, fastest merge turnaround, most reviewed PR, first-time contributors, and long-standing issues finally fixed. Every shoutout names the person, links the PR, and explains why it stands out.

### Trend analysis

```
/shipped-delta my-org/my-repo last 2 weeks
```

Compares the current period against the immediately prior period of equal length. Shows volume, velocity, contributor, and focus deltas with up/down/stable indicators. Key observations call out meaningful shifts and distinguish signal from noise.

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

## Example Output

Running `/shipped openshift/lightspeed-service last month` produces something like:

```
# What Shipped: lightspeed-service
## Last month (May 27 to June 26, 2026)

> **The story:** The team spent this period making the query pipeline production-ready
> and expanding the API surface for integrations. The biggest wins were hybrid
> retrieval (a 23% relevance improvement) and streaming responses (perceived
> latency dropped from 8s to under 1s). Infrastructure work focused on migrating
> CI to Tekton and adding load testing at scale.

### Worth Knowing

1. **Add RAG pipeline v2 with hybrid retrieval** - Replaces single-vector lookup
   with dense+sparse retrieval, improving answer relevance by 23% on internal
   benchmarks. (#892) `[L]`
2. **Streaming response support for /v1/query** - Cuts perceived latency for long
   answers from 8s to under 1s by streaming tokens as generated. (#878) `[L]`
3. **Fix OOM on large context windows** - Resolved a memory leak when processing
   documents over 32k tokens that caused pods to get OOMKilled under sustained
   load. (#901) `[M]`

---

### Making the Query Pipeline Production-Ready (High Impact)
The team shipped hybrid retrieval and streaming responses while fixing the OOM
issue that was blocking sustained production load.

- Add RAG pipeline v2 with hybrid retrieval (#892) `[L]` @saldana
  - Follow-up: Fix sparse index path resolution on S3 (#907) `[S]` @saldana
- Streaming response support for /v1/query (#878) `[L]` @jchen
- Fix OOM on large context windows (#901) `[M]` @tkurian
- Cache embedding results for repeated document chunks (#903) `[M]` @jchen

### Expanding the API Surface (Medium Impact)
New endpoints for feedback collection and per-namespace prompt customization.

- Add /v1/feedback endpoint for answer rating (#885) `[M]` @mrawls
- Support custom system prompts per namespace (#871) `[M]` @mrawls

### CI/CD and Infrastructure (Medium Impact)
Migrated the build pipeline to Tekton and added load testing at 500 concurrent users.

- Migrate CI to Tekton pipelines (#880) `[M]` @bpatel
- Add load test suite targeting 500 concurrent users (#887) `[L]` @bpatel

### Housekeeping
Dependency updates and minor fixes that keep things running.

- Bump Python to 3.12, update all pinned deps (#876) `[S]` @saldana
- Handle empty embedding responses from provider (#894) `[S]` @jchen
- Correct token counting for multi-turn conversations (#889) `[S]` @mrawls

### Breaking Changes

> **Action required:** Clients using the deprecated /v1/ask endpoint must migrate
> to /v1/query. See the migration guide in the PR description.

- Remove deprecated /v1/ask endpoint (#899) `[L]` @saldana

---

### Contributors

| Contributor | PRs | Themes |
|-------------|-----|--------|
| @saldana    | 5   | Query Pipeline, Housekeeping, Breaking Changes |
| @jchen      | 4   | Query Pipeline, Housekeeping |
| @mrawls     | 3   | API Surface, Housekeeping |
| @tkurian    | 2   | Query Pipeline |
| @bpatel     | 2   | CI/CD and Infrastructure |

---
*18 PRs merged by 7 contributors, 2 releases tagged.*
```

Running `/shipped-celebration kubernetes/kubernetes last sprint` produces:

```
:trophy: Ship It Awards: kubernetes

:tada: The team merged 42 PRs from 18 contributors this sprint. Here are the
standout moments:

:rocket: Biggest Impact
Add pod topology spread constraints for scheduler by @liggitt (#118234)
This unlocks zone-aware scheduling for multi-region clusters, one of the most
requested features in the past year.

:medal: Most Prolific
@aojea shipped 7 PRs this sprint, driving network policy improvements and
e2e test coverage.

:zap: Speed Demon
Fix typo in kubelet config docs by @dims (#118301)
Merged in 47 minutes from open to merge.

:wave: Welcome, New Contributor!
@sarah-chen landed their first PR: Add validation for custom resource field
selectors (#118289). Welcome to the team!

:calendar: Finally Fixed
Fix race condition in node lifecycle controller by @wojtek-t (#118245)
This closed #94102, which had been open for 14 months. The long wait is over.

:clap: Great work, team. Keep shipping.
```

Running `/shipped-narrative openshift/lightspeed-service Q2 2026` produces:

```
# lightspeed-service: What We Shipped
## Q2 2026 (April 1 to June 30, 2026)

Going into Q2, the lightspeed-service team faced a clear challenge: the query
pipeline worked, but it was not production-ready. Answer relevance hovered around
acceptable levels, response times were too slow for interactive use, and the
system buckled under sustained load. The team set out to fix all three.

The centerpiece of the quarter was the new hybrid retrieval pipeline, led by
@saldana, which replaced the single-vector lookup with a combined dense and
sparse approach. Internal benchmarks showed a 23% improvement in answer
relevance. @jchen followed up with streaming response support, cutting perceived
latency from 8 seconds to under 1 second for long answers. Together, these two
changes transformed the query experience from "wait and see" to "watch it think."
On the reliability front, @tkurian tracked down a memory leak in large-context
processing that had been causing OOMKills under load, closing one of the team's
longest-standing production issues.

Beyond the core pipeline, the team expanded the API to support new integration
patterns. @mrawls shipped a feedback endpoint for answer rating and per-namespace
custom system prompts, giving downstream teams the hooks they need to build on
top of the service. Meanwhile, @bpatel migrated the entire CI pipeline to Tekton
and stood up a load test suite targeting 500 concurrent users, giving the team
confidence that what they shipped can handle real-world traffic.

The numbers tell a healthy story: 52 PRs merged by 12 contributors across 6
releases. The team maintained a median time-to-merge of 1.8 days, with 60% of
PRs classified as small, suggesting a disciplined approach of frequent, focused
merges rather than large, risky changesets.

With the query pipeline now production-hardened and the API surface expanding,
the groundwork is set for Q3's focus on multi-tenant support and external
integrations. The feedback endpoint and per-namespace prompts are the foundation
that work will build on.

---

*Key contributors: @saldana, @jchen, @mrawls, @tkurian, @bpatel, and 7 others.*
*Based on 52 merged pull requests and 6 releases.*

**Detailed changelog:** Run `/shipped openshift/lightspeed-service Q2 2026` for
the full breakdown.
```

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

The key difference from traditional changelog generators: these commands find the narrative in the work, not just the list. A feature PR, its follow-up fix, and the related performance improvement become one story, not three disconnected line items.

No data leaves your machine beyond the standard GitHub API calls that `gh` already makes.

## License

Apache-2.0
