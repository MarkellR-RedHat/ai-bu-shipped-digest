# shipped-digest

**Your team shipped 23 PRs this week. Nobody can explain what that means.**

Someone opens GitHub, scrolls through titles like `fix: update retry logic` and `refactor: extract helper`, and tries to piece together the story. It takes an hour. Or they skip it, and the work stays invisible.

The person who spent three days upgrading dependencies and patching a critical CVE gets the same acknowledgment as the person who fixed a typo: none.

shipped-digest turns merged PRs into digests worth reading. It scans a repo's GitHub history, finds the narrative thread, and produces output shaped for the audience: themed digests for sprint reviews, stakeholder emails for leadership, Slack posts for the team channel, release notes for downstream users.

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

Nine commands, globally available, no config files.

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

### Typical Workflow

1. **Run `/shipped`** after a sprint to get the themed digest.
2. **Run `/shipped-email`** to produce a VP-ready briefing from the same data.
3. **Post `/shipped-slack`** in your team channel so the work is visible.
4. **Use `/shipped-celebration`** in your Slack channel to give specific credit.
5. **Check `/shipped-delta`** before retro to see how the sprint compared to the previous one.

For cross-repo portfolio views, run `/shipped-compare` with multiple repos to surface coordinated work that no single-repo view would reveal.

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

Subject line worth opening, 50-word opening paragraph, "What Matters Most" section focused on business impact. The kind of email an engineering lead would send if they had time and enjoyed writing.

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

## Workflow Tip

One team runs `/shipped-email` every Friday at 4 PM and sends it to their skip-level. It takes about 90 seconds. Before shipped-digest, that email took 45 minutes to write and usually did not get sent at all. The work was invisible for six months until someone asked "what has your team been doing?" Now leadership forwards the email before they are asked.

If you write a weekly status report, try piping `/shipped` output into `/status-report` from the [status-report](https://github.com/MarkellR-RedHat/ai-bu-status-report) tool. The digest becomes the "accomplishments" section with zero rewriting.

## Suite Integration

shipped-digest works well alongside other tools in the [AI BU suite](https://github.com/MarkellR-RedHat/ai-bu-hub):

- **[status-report](https://github.com/MarkellR-RedHat/ai-bu-status-report)**: Feed `/shipped` output into `/status-report` for a complete weekly report.
- **[meeting-notes](https://github.com/MarkellR-RedHat/ai-bu-meeting-notes)**: Use `/shipped` output as input for sprint review `/meeting-notes`.
- **[message-polisher](https://github.com/MarkellR-RedHat/ai-bu-message-polisher)**: Polish `/shipped-email` output before sending to leadership.
- **[style-checker](https://github.com/MarkellR-RedHat/ai-bu-style-checker)**: Run `/shipped-narrative` output through `/style-check` for brand voice consistency.
- **[cfp-generator](https://github.com/MarkellR-RedHat/ai-bu-cfp-generator)**: Turn a strong `/shipped-narrative` into a conference talk abstract with `/cfp`.

## Reference Materials

The `formats/` directory contains output templates (Markdown, Slack mrkdwn, email). The `reference/` directory has audience-specific formatting guidance for engineering, product, executive, and community audiences.

## License

Apache-2.0
