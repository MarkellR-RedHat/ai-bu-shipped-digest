# ai-bu-shipped-digest

Claude Code commands that scan a repo's merged PRs and releases over a time period and produce a human-readable changelog grouped by theme.

Built for PMs, PMMs, and engineering leads who need to know what shipped without reading every PR.

## What It Does

- **/shipped** - Scans a single repo's merged PRs and releases, classifies them by type (features, bug fixes, performance, docs, infra, breaking changes), groups related PRs together, sizes each by impact, highlights the top 3 most impactful changes, attributes contributors, and produces a clean digest.
- **/shipped-compare** - Runs the same analysis across multiple repos and produces a side-by-side comparison with cross-repo contributor tracking. Good for cross-team visibility and leadership rollups.
- **/shipped-email** - Same analysis as /shipped, but formatted as a stakeholder email you can send directly to leadership or cross-functional partners.
- **/shipped-slack** - Formats the digest as a Slack message with emoji and mrkdwn formatting. Ready to paste into a channel.
- **/shipped-release-notes** - Formats as proper release notes suitable for a GitHub Release page or CHANGELOG file, with contributor attribution in the standard `by @username in #123` format.
- **/shipped-metrics** - Pure quantitative metrics: PRs merged, contributors, lines added/removed, time-to-merge averages, size distribution, busiest days. The numbers-only view.

### Smart features across all commands

- **Intelligent grouping** - Recognizes related PRs (e.g., a feature and its follow-up fix, multi-part work, reverts and re-lands) and groups them together instead of listing them separately.
- **Impact sizing** - Tags every PR as `[L]` (large), `[M]` (medium), or `[S]` (small) based on lines changed and files touched.
- **Contributor attribution** - Tracks who shipped what and surfaces top contributors.

## Format Templates

The `formats/` directory contains reference templates for each output format:

- `formats/markdown.md` - Standard Markdown (GitHub issues, wikis, READMEs)
- `formats/slack.md` - Slack mrkdwn with emoji (copy-paste into channels)
- `formats/email.md` - Stakeholder email (send to leadership)

These templates document the exact formatting rules each command follows. Useful as a reference when you want to understand or customize the output format.

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

### Single repo digest

```
/shipped kubernetes/kubernetes last month
```

```
/shipped openshift/lightspeed-service since v0.12.0
```

```
/shipped my-org/my-repo Q2 2026
```

### Cross-repo comparison

```
/shipped-compare kubernetes/kubernetes, openshift/lightspeed-service last month
```

### Stakeholder email

```
/shipped-email openshift/lightspeed-service last week
```

### Slack message

```
/shipped-slack my-org/my-repo last month
```

### Release notes

```
/shipped-release-notes my-org/my-repo since v1.2.0
```

### Metrics report

```
/shipped-metrics kubernetes/kubernetes Q2 2026
```

## Example Output

Running `/shipped openshift/lightspeed-service last month` produces something like:

```
# What Shipped: lightspeed-service
## Last month (May 27 - June 26, 2026)

### Top Highlights
1. **Add RAG pipeline v2 with hybrid retrieval** - Replaces the single-vector
   lookup with a hybrid dense+sparse retrieval pipeline, improving answer
   relevance by 23% on internal benchmarks. (#892) `[L]`
2. **Streaming response support for /v1/query** - The query endpoint now
   streams tokens as they are generated, cutting perceived latency for
   long answers from 8s to under 1s. (#878) `[L]`
3. **Fix OOM on large context windows** - Resolved a memory leak when
   processing documents over 32k tokens that caused pods to get
   OOMKilled under sustained load. (#901) `[M]`

---

### Features
- Add RAG pipeline v2 with hybrid retrieval (#892) `[L]`
  - Follow-up: Fix sparse index path resolution on S3 (#907) `[S]`
- Streaming response support for /v1/query (#878) `[L]`
- Add /v1/feedback endpoint for answer rating (#885) `[M]`
- Support custom system prompts per namespace (#871) `[M]`

### Bug Fixes
- Fix OOM on large context windows (#901) `[M]`
- Handle empty embedding responses from provider (#894) `[S]`
- Correct token counting for multi-turn conversations (#889) `[S]`

### Performance
- Cache embedding results for repeated document chunks (#903) `[M]`
- Batch inference requests to reduce GPU idle time (#896) `[M]`

### Infrastructure
- Migrate CI to Tekton pipelines (#880) `[M]`
- Add load test suite targeting 500 concurrent users (#887) `[L]`
- Bump Python to 3.12, update all pinned deps (#876) `[S]`

### Breaking Changes
- Remove deprecated /v1/ask endpoint (#899) `[L]`

---

### Contributors

| Contributor | PRs |
|-------------|-----|
| @saldana    | 5   |
| @jchen      | 4   |
| @mrawls     | 3   |
| @tkurian    | 2   |
| @bpatel     | 2   |

---
*18 PRs merged by 7 contributors, 2 releases tagged.*
```

Running `/shipped-metrics openshift/lightspeed-service last month` produces:

```
# Shipped Metrics: lightspeed-service
## Last month (May 27 - June 26, 2026)

### Volume
| Metric | Value |
|--------|-------|
| PRs merged | 18 |
| Releases tagged | 2 |
| Lines added | +4,312 |
| Lines removed | -1,087 |
| Net change | +3,225 |
| Files changed | 94 |

### PR Size Distribution
| Size | Count | % |
|------|-------|---|
| Large (500+ lines or 10+ files) | 3 | 17% |
| Medium (100-499 lines or 4-9 files) | 8 | 44% |
| Small (<100 lines, <=3 files) | 7 | 39% |

### Merge Velocity
| Metric | Value |
|--------|-------|
| Average time-to-merge | 2.4 days |
| Median time-to-merge | 1.8 days |
| Fastest merge | Correct token counting (#889) - 3 hours |
| Slowest merge | Add RAG pipeline v2 (#892) - 11 days |

### Contributors
| Metric | Value |
|--------|-------|
| Unique contributors | 7 |
| Single-PR contributors | 2 |

**Top contributors by PRs:**

| Contributor | PRs | Lines changed |
|-------------|-----|---------------|
| @saldana | 5 | +1,820/-340 |
| @jchen | 4 | +980/-290 |
| @mrawls | 3 | +645/-180 |
| @tkurian | 2 | +510/-150 |
| @bpatel | 2 | +357/-127 |

### Category Breakdown
| Category | Count | % |
|----------|-------|---|
| Features | 4 | 22% |
| Bug Fixes | 3 | 17% |
| Performance | 2 | 11% |
| Infrastructure | 3 | 17% |
| Breaking Changes | 1 | 6% |

### Activity Pattern
| Metric | Value |
|--------|-------|
| Busiest day of week | Wednesday (6 merges) |
| Busiest date | June 12, 2026 (4 merges) |
| PRs per week (avg) | 4.5 |

---
*Metrics generated from 18 merged PRs across 4 weeks.*
```

## How It Works

The commands use the GitHub CLI (`gh`) to pull merged PRs and releases from the GitHub API. They classify each PR by reading its title, body, and labels, then group them into standard changelog categories. Related PRs (feature + follow-up fix, multi-part work) are grouped together. Each PR is sized by lines changed and files touched. The top 3 highlights are selected based on impact size, user-facing scope, and whether the change appeared in a release.

No data leaves your machine beyond the standard GitHub API calls that `gh` already makes.

## License

Apache-2.0
