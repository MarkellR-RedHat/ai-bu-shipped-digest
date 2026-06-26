Release notes are the public record of what a team shipped. They are read by downstream users deciding whether to upgrade, contributors checking if their work landed, and operators figuring out what changed under them. Your job is to write notes that are clear, well-organized, and ready to publish on a GitHub Release page or in a CHANGELOG file.

Good release notes respect the reader's time. Breaking changes go at the top because people need to know before they upgrade. Highlights explain why a change matters, not just what it does. New contributors get a welcome because open source runs on people, and recognizing them is how you keep them.

## Calibration

Bad highlight: "Add hybrid retrieval to RAG pipeline (#892)"
Good highlight: "Hybrid retrieval replaces single-vector lookup with dense and sparse search, improving answer relevance by 23% on internal benchmarks."

Bad breaking change: "Remove /v1/ask endpoint (#899)"
Good breaking change: "The deprecated /v1/ask endpoint has been removed. Clients must migrate to /v1/query. See the migration guide in the PR description for step-by-step instructions."

Bad infrastructure entry: "Update CI configuration (#901)"
Good infrastructure entry: "Migrate CI to Tekton with parallel test stages, reducing pipeline duration from 22 minutes to 8 by @chen in #901"

Bad new contributor welcome: "Welcome new contributors!"
Good new contributor welcome: "@mpark made their first contribution in #914, adding retry logic to the webhook delivery path. This fixes silent failures that affected 3% of event deliveries."

## Your approach

Think through this in stages:
1. Gather all merged PRs and releases for the period
2. Identify the headline: what is the single most important thing in this release?
3. Group related work so readers see coherent changes, not a flat list
4. Write notes that help users understand what changed and what they need to do

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

## Step 2: Fetch merged PRs

```
gh pr list --repo <repo> --state merged --search "merged:>=YYYY-MM-DD" --limit 200 --json number,title,body,labels,mergedAt,author,url,additions,deletions,changedFiles
```

If the timeframe references a tag, first get the tag date:
```
gh api repos/<owner>/<repo>/git/refs/tags/<tag> --jq '.object.sha' | xargs -I {} gh api repos/<owner>/<repo>/git/commits/{} --jq '.committer.date'
```

## Step 3: Fetch releases

```
gh release list --repo <repo> --limit 50
```

Fetch details for relevant releases:
```
gh release view <tag> --repo <repo> --json tagName,name,body,publishedAt
```

## Step 3.5: Handle edge cases before analysis

Before classifying changes, check for these situations and handle them honestly:

**Zero or near-zero PRs merged:**
If nothing shipped in the period, say so directly. Produce a minimal release notes stub that confirms the timeframe and notes zero changes. Do not pad with open PRs or draft work. If releases were tagged from earlier work, include those release details. Suggest the user check a wider date range or confirm the repo.

**All dependency bumps, CI fixes, or bot-generated PRs:**
Release notes for a maintenance-only period are still valuable. Group the work under "Other Changes" per GitHub conventions, but include impact context: CVEs patched, EOL versions replaced, CI reliability improvements. Users reading release notes want to know if they need to act on anything, and a security patch buried in a dependency bump is actionable information.

**Lopsided contributions (one person did 90%+ of the work):**
Report contributor attribution factually. The Contributors section will naturally reflect the distribution. If one person did the bulk of the work, the New Contributors section and contributor list will show the pattern without editorializing.

**PRs spanning multiple repos:**
If PR bodies reference issues or PRs in other repos, note those cross-repo connections in the relevant section. A feature that requires coordinated upgrades across repos is critical information for users reading release notes to decide whether to upgrade.

## Step 4: Classify and group changes

Group PRs into standard release note categories, but apply intelligent grouping:

- Feature + follow-up fix: nest the fix under the feature as a sub-bullet
- Multi-part work: group PRs that share a common prefix or reference the same issue
- Revert + re-land: show only the final landed version with a note
- Infrastructure PRs become "Other Changes" to match GitHub conventions
- Dependency updates with security implications should call out the CVE or risk

## Step 5: Identify highlights

Pick the 3-5 most significant changes. These go at the top of the release notes and get expanded descriptions. Prioritize:
- New user-facing capabilities
- Breaking changes that require action
- Significant performance improvements with before/after numbers
- Long-standing issues finally resolved
- Infrastructure improvements with measurable impact

## Step 6: Detect new contributors

If possible, identify first-time contributors during this period by checking if they have earlier merged PRs in the repo:

```
gh pr list --repo <repo> --state merged --author <username> --search "merged:<YYYY-MM-DD" --limit 1 --json number
```

If the result is empty, they are a new contributor for this period.

## Step 7: Self-critique before outputting

Before producing the release notes, verify:
- [ ] Breaking changes are front and center with clear migration guidance
- [ ] Related PRs are grouped, not listed individually
- [ ] Every PR has author attribution
- [ ] Highlights actually highlight the most important changes, not just the largest PRs
- [ ] Infrastructure and dependency work includes impact context where available
- [ ] New contributors are welcomed (if detected)
- [ ] The notes are ready to paste into a GitHub Release with no editing needed

## Step 8: Format as release notes

Use the standard GitHub release notes format:

```
## What's New

### Highlights

- **<title>** - <one-sentence summary of what it does and why it matters.> ([#<number>](<url>)) @<author>
- **<title>** - <one-sentence summary.> ([#<number>](<url>)) @<author>
- **<title>** - <one-sentence summary.> ([#<number>](<url>)) @<author>

### Breaking Changes

> **Note:** The following changes may require action when upgrading.

- **<title>** - <description of what changed and what users need to do.> ([#<number>](<url>)) @<author>

### Features

- <title> by @<author> in [#<number>](<url>)
  - <follow-up fix title> by @<author> in [#<number>](<url>)
- <title> by @<author> in [#<number>](<url>)

### Bug Fixes

- <title> by @<author> in [#<number>](<url>)

### Performance

- <title> by @<author> in [#<number>](<url>)

### Documentation

- <title> by @<author> in [#<number>](<url>)

### Other Changes

- <title> by @<author> in [#<number>](<url>)

## Contributors

Thanks to the <contributor count> contributors who made this release possible:

<contributor list as @mentions, comma-separated>

### New Contributors

- @<username> made their first contribution in [#<number>](<url>)

**Full Changelog**: <compare URL or note about the date range>
```

### Rules for release notes

- Breaking Changes always comes right after Highlights. If there are none, omit the section entirely.
- Every PR gets author attribution using `by @<username>`.
- "Infrastructure" is renamed to "Other Changes" to match GitHub conventions.
- Group related PRs (feature + follow-up) as sub-bullets under the primary PR.
- Omit any section with zero entries.
- Keep descriptions to one sentence per item.
- Do not editorialize. Stick to what actually shipped.
- If you cannot reliably determine new contributors, omit the New Contributors section rather than guessing.

**Cross-tool:** For a narrative summary to accompany these notes, run `/shipped-narrative <repo> <timeframe>`.
