# ai-bu-shipped-digest

Claude Code commands that scan a repo's merged PRs and releases over a time period and produce a human-readable changelog grouped by theme.

Built for PMs, PMMs, and engineering leads who need to know what shipped without reading every PR.

## What It Does

- **/shipped** - Scans a single repo's merged PRs and releases, classifies them by type (features, bug fixes, performance, docs, infra, breaking changes), highlights the top 3 most impactful changes, and produces a clean digest.
- **/shipped-compare** - Runs the same analysis across multiple repos and produces a side-by-side comparison. Good for cross-team visibility and leadership rollups.
- **/shipped-email** - Same analysis as /shipped, but formatted as a stakeholder email you can send directly to leadership or cross-functional partners.

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

## Example Output

Running `/shipped anthropics/claude-code last month` produces something like:

```
# What Shipped: claude-code
## Last month (May 27 - June 26, 2026)

### Top Highlights
1. **Add MCP server auto-discovery** - Claude Code now automatically finds and connects
   to MCP servers defined in project config. (#1234)
2. **Fix streaming timeout on large repos** - Resolved an issue where responses would
   cut off when scanning repos with 10k+ files. (#1198)
3. **Parallel tool execution** - Tools that do not depend on each other now run
   concurrently, reducing wait times by up to 40%. (#1215)

---

### Features
- Add MCP server auto-discovery (#1234)
- Support for custom slash commands in subdirectories (#1241)

### Bug Fixes
- Fix streaming timeout on large repos (#1198)
- Handle repos with non-UTF8 filenames (#1203)

### Performance
- Parallel tool execution (#1215)
- Cache file tree between tool calls (#1220)

### Infrastructure
- Migrate CI to GitHub Actions reusable workflows (#1189)
- Bump Node.js to v22 (#1195)

---
*14 PRs merged, 2 releases tagged.*
```

## How It Works

The commands use the GitHub CLI (`gh`) to pull merged PRs and releases from the GitHub API. They classify each PR by reading its title, body, and labels, then group them into standard changelog categories. The top 3 highlights are selected based on scope, user impact, and whether the change appeared in a release.

No data leaves your machine beyond the standard GitHub API calls that `gh` already makes.

## License

Apache-2.0
