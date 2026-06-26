# Slack Format Template

Use this template when formatting shipped digests for Slack. The output should be ready to copy and paste directly into a Slack channel with no modifications.

## Important: Slack mrkdwn vs standard Markdown

Slack uses its own markup language called mrkdwn. Do NOT use standard Markdown syntax.

| Element | Standard Markdown | Slack mrkdwn |
|---------|-------------------|--------------|
| Bold | `**text**` | `*text*` |
| Italic | `*text*` | `_text_` |
| Links | `[text](url)` | `<url\|text>` |
| Headings | `# Heading` | Not supported. Use bold + emoji. |
| Code | `` `code` `` | `` `code` `` |
| Code block | ` ```code``` ` | ` ```code``` ` |

## Structure

```
:ship: *What Shipped: <repo name>*
:calendar: <timeframe> (<start date> to <end date>)
:bar_chart: <total PRs> PRs merged by <contributor count> contributors | <release count> releases

---

:star: *Top Highlights*

1. *<title>* - <one-sentence summary> (<url|#number>) `[L]`
2. *<title>* - <one-sentence summary> (<url|#number>) `[M]`
3. *<title>* - <one-sentence summary> (<url|#number>) `[L]`

---

:rocket: *Features*
- <title> (<url|#number>) `[L]`
   - Follow-up fix: <title> (<url|#number>) `[S]`
- <title> (<url|#number>) `[M]`

:bug: *Bug Fixes*
- <title> (<url|#number>) `[S]`

:zap: *Performance*
- <title> (<url|#number>) `[M]`

:books: *Docs*
- <title> (<url|#number>) `[S]`

:wrench: *Infra*
- <title> (<url|#number>) `[S]`

:warning: *Breaking Changes*
- <title> (<url|#number>) `[L]` - <what breaks>

---

:busts_in_silhouette: *Top Contributors:* @<username> (<count>), @<username> (<count>), @<username> (<count>)
```

## Rules

- Use Slack emoji codes (`:ship:`, `:rocket:`, `:bug:`, etc.) for section headers.
- Use single `*` for bold, not double `**`.
- Use `<url|display text>` for links, not `[text](url)`.
- No `#` headings. Use bold text with emoji instead.
- Keep it dense. Slack messages that are too long get skimmed or ignored.
- If any category has more than 5 items, show the top 5 and add "(+N more)" at the end.
- Contributors go on a single line, comma-separated. No table.
- Omit sections with zero entries.
- Do NOT wrap the output in a code block. The output is the raw Slack message.
