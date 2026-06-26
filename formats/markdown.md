# Markdown Format Template

Use this template when producing standard Markdown output for shipped digests. This format works well in GitHub issues, README files, wikis, and any Markdown-rendered context.

## Structure

```markdown
# What Shipped: <repo name>
## <timeframe> (<start date> to <end date>)

### Top Highlights
1. **<title>** - <one-sentence summary> ([#<number>](<url>)) `[L]`
2. **<title>** - <one-sentence summary> ([#<number>](<url>)) `[M]`
3. **<title>** - <one-sentence summary> ([#<number>](<url>)) `[L]`

---

### Features
- <title> ([#<number>](<url>)) `[L]`
  <one-line summary if helpful>
  - Follow-up: <fix title> ([#<number>](<url>)) `[S]`
- <title> ([#<number>](<url>)) `[M]`

### Bug Fixes
- <title> ([#<number>](<url>)) `[S]`

### Performance
- <title> ([#<number>](<url>)) `[M]`

### Documentation
- <title> ([#<number>](<url>)) `[S]`

### Infrastructure
- <title> ([#<number>](<url>)) `[S]`

### Breaking Changes
- <title> ([#<number>](<url>)) `[L]`

---

### Contributors

| Contributor | PRs |
|-------------|-----|
| @<username> | <count> |
| @<username> | <count> |

---
*<total PR count> PRs merged by <contributor count> contributors, <release count> releases tagged.*
```

## Rules

- Use standard Markdown heading syntax (`#`, `##`, `###`).
- Use `([#<number>](<url>))` for PR links so they render as clickable links.
- Use `---` horizontal rules to separate major sections.
- Impact tags use inline code: `` `[L]` ``, `` `[M]` ``, `` `[S]` ``.
- Omit any section with zero entries.
- Nest related PRs (follow-up fixes, multi-part work) as indented sub-bullets.
- Keep summaries to one sentence. No filler.
- Contributors table uses standard Markdown table syntax.
