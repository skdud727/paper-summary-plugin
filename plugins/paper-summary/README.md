# paper-summary

A Claude plugin that turns research papers into clean, block-style Notion pages.

- **Summarize** a paper: TL;DR, motivation, key idea, an **input-to-output pipeline flowchart**, a results table, and the perspectives you pick.
- **Similar papers**: finds up to two closely related papers, summarizes them too, and opens each with the **overlap keywords** it shares with your paper.
- **Compare** papers: proposes comparison perspectives tailored to the papers you selected, then writes one comparison page (table, per-paper explanations, commonalities, differences, takeaway).
- **Your database, your language**: pages go into a `Paper Summaries` database in your own Notion, written in Korean or English.

## Requirements

| | |
|---|---|
| Claude | Any plan that supports plugins, with code execution enabled. Works in the Claude desktop app (Cowork), claude.ai chat, and Claude Code |
| Notion | Connect the Notion connector yourself in Claude's connector settings, and allow access to the page where results should live (or your Private section). The plugin never connects or signs in for you |
| Web search | Enabled, for reading papers and finding similar work |

## Install

In the Claude desktop app or claude.ai: **Customize → Plugins → Add → Add marketplace** and enter:

```
skdud727/paper-summary-plugin
```

Then install **paper-summary** from the list. In Claude Code:

```
/plugin marketplace add skdud727/paper-summary-plugin
/plugin install paper-summary@paper-summary-marketplace
```

## First run

Run `/paper-summary:setup` (or just ask to summarize a paper — setup starts automatically). It asks for:

1. **Domain(s)** — Computer Vision, Robotics, NLP / LLM, ML, Security / Privacy, CPS / IoT, Systems, HCI, Biomedical, or your own. This seeds the Tags.
2. **Page language** — Korean (technical terms stay in English) or English.
3. **Database** — create a new `Paper Summaries` database, or use an existing one.

Settings are stored in the database description, so you are only asked once. Run setup again to change them.

## Usage

| You say | What happens |
|---|---|
| `Summarize this paper` + PDF or link, or `/paper-summary:summarize` | Summary page + up to two Similar pages, linked to each other |
| Check **Compare** on some rows in Notion, then `/paper-summary:compare` | Claude proposes perspectives for those papers, you pick, it writes a Comparison page |
| `Compare A, B and C on how they use the prior model and which datasets they use` | Uses your perspectives directly |
| `Compare these, centered on A` | Writes differences relative to A |

## Database columns

Title · Type (Summary / Similar / Comparison) · Authors · Venue · Year · Link · Tags · Perspective · Compare · Related Papers · Added

## Notes

- Paywalled papers: attach the PDF; a link alone gives only the abstract.
- Unverified numbers and venues are marked "(verify in source)" / "(원문 확인 필요)".
- Questions are asked in Claude (desktop, web, mobile, or Claude Code). Results are written to Notion.

## License

MIT
