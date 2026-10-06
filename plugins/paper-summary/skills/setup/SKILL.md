---
name: setup
description: This skill should be used when the user runs "/paper-summary:setup", says "set up paper summary", "change my paper domain", "reset paper-summary settings", "switch summary language", or when another paper-summary skill finds no configured Notion database. It creates or adopts the user's Notion "Paper Summaries" database, seeds domain tags, and stores the output language.
metadata:
  version: "0.1.0"
---

# Setup

Configure where and how papers are saved. Run once per user; re-run to change domain or language.

## Steps

1. Read `../../references/common.md` (relative to this file) and run its Preflight step 1 (Notion tools available). If Notion is missing, stop with the message given there.
2. Search Notion for an existing database titled `Paper Summaries` with `[paper-summary-plugin]` in its description. If found, show its current domain and lang, and treat this run as a settings change.
3. Ask in one AskUserQuestion call (or plain chat if that tool is unavailable):
   - **Domain** (multiSelect): the domains in `../../references/domains.md`. The user may type their own.
   - **Language for Notion pages**: Korean (technical terms stay in English) / English.
   - **Database** (only when none exists yet): Create a new "Paper Summaries" database (default) / Use an existing database (ask for its link).
4. Create or adopt the database following `../../references/schema.md`:
   - New: create it under the page the user names; if none is named, create it at the workspace level (private). Add the one-way `Related Papers` relation in a second call.
   - Existing: add missing properties only; never delete or rename the user's properties without asking.
5. Seed options:
   - Tags: merge the tag lists of the chosen domains (drop duplicates), plus `Survey`. For a custom domain, propose 10–15 tags in the same style and confirm in one short question.
   - Perspective: the four base options (Tech, Results, Experiment Setup, Limitations) plus each chosen domain's extra perspectives.
   - On a settings change, keep every existing option and only add new ones.
6. Write the config line into the data source description:
   `[paper-summary-plugin] v1 | domain: <comma-separated> | lang: <ko|en>`
7. Reply in 3–4 lines: database link, domain and language set, and three example requests:
   - "Summarize this paper" (with a PDF or link)
   - "/paper-summary:compare" after checking papers in Notion
   - "Compare A and B on how they use the prior model"
