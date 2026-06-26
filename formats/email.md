# Email Format Template

Use this template when formatting shipped digests as a stakeholder email. The output should be ready to paste into an email client and send to leadership or cross-functional partners.

## Structure

```
---
**Subject:** What Shipped in <repo name> | <timeframe>
---

Hi team,

Here is a summary of what shipped in **<repo name>** during **<timeframe>** (<start date> to <end date>).

### At a Glance
- **<total PRs>** pull requests merged by **<contributor count>** contributors
- **<release count>** releases published
- **<feature count>** new features, **<fix count>** bug fixes
- **Impact breakdown:** <large count> large, <medium count> medium, <small count> small changes

### Highlights

1. **<title>** - <two-sentence summary of what it does and why it matters.> [View PR](<url>) `[L]`

2. **<title>** - <two-sentence summary.> [View PR](<url>) `[M]`

3. **<title>** - <two-sentence summary.> [View PR](<url>) `[L]`

### Full Changelog

**Features**
- <title> ([#<number>](<url>)) `[L]`
  - Follow-up: <fix title> ([#<number>](<url>)) `[S]`

**Bug Fixes**
- <title> ([#<number>](<url>)) `[S]`

**Performance**
- <title> ([#<number>](<url>)) `[M]`

**Infrastructure**
- <title> ([#<number>](<url>)) `[S]`

**Breaking Changes**
- <title> ([#<number>](<url>)) `[L]` - <brief note on what breaks and what to do>

### Releases

- **<version>** (<date>) - [Release notes](<url>)

### Top Contributors

| Contributor | PRs |
|-------------|-----|
| @<username> | <count> |
| @<username> | <count> |

---

Let me know if you have questions or want a deeper dive into any of these changes.
```

## Rules

- Start with a subject line in the `---` delimiters so it is easy to copy.
- Open with "Hi team," and a single-sentence intro.
- "At a Glance" section gives the executive summary in 4 bullet points or fewer.
- Highlights get two-sentence summaries (more detail than Slack or Markdown formats).
- Breaking Changes always include a note on what breaks and recommended action.
- Tone: professional but direct. Write like an engineer briefing leadership, not a marketing team writing a press release.
- Close with a call to action ("Let me know if you have questions...").
- Omit sections with zero entries.
- Include contributor table so leadership sees who is driving the work.
- Every sentence should carry information. No filler.
