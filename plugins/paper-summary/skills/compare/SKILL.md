---
name: compare
description: This skill should be used when the user asks to "compare these papers", "비교해줘", "how do A and B differ", "what do these papers have in common", "compare the papers I checked in Notion", or runs "/paper-summary:compare". It gathers the paper set, proposes comparison perspectives tailored to those papers, and writes one block-style comparison page to the user's Notion database.
metadata:
  version: "0.1.0"
---

# Compare papers

## Steps

1. Read `../../references/common.md` (relative to this file) and run Preflight. Read `../../references/layout.md` before writing.
2. **Collect the paper set** from, in order of precedence:
   - papers named, linked, or mentioned in the user's message;
   - rows with `Compare` checked in the database;
   - a tag or filter the user names ("papers tagged Metric Depth").
   If nothing is found, ask which papers to compare. Papers not yet in the database: summarize them first with the summarize skill's procedure, skipping the similar-paper search.
   If the user names a center paper, put it first and write differences relative to it.
3. **Read** each paper's Notion page. Note what each covers and where they diverge.
4. **Propose perspectives before writing** — unless the user already gave explicit perspectives or a question, in which case use those and skip to step 5.
   - Derive 4–6 candidate perspectives specific to this set, from where the papers actually differ. Examples of the right granularity: "How the prior model is used (frozen, guided, post-hoc)", "Where sparse measurements are injected", "Loss / update target", "Training data vs. evaluation data", "Runtime and deployability", "Downstream tasks demonstrated".
   - Ask with AskUserQuestion (multiSelect), one option per perspective with a one-line description of what it would reveal for these papers. The user can also type their own.
5. **Fill gaps.** If a chosen perspective needs details the Notion pages lack, go back to the paper sources.
6. **Write one page** following the comparison layout in layout.md:
   - `Type = Comparison`, Title `Compare: <short axis> — A vs B (vs C ...)`.
   - Perspective: the matching database options (add new ones via ALTER if a custom perspective deserves an option; otherwise leave it in the page only).
   - Tags: union of the relevant tags of the compared papers (3–6).
   - `Related Papers`: all compared pages, and add this comparison page to each compared page's `Related Papers` (both directions).
   - Short answers go in the table; perspectives that need explanation get their own section with per-paper callouts.
   - Include an Overview flowchart when the pipelines differ structurally; keep explicit input and output nodes.
7. Uncheck `Compare` on the compared pages.
8. **Reply** with the page link. If the user asked for an explanation in chat, add a compact table of the key differences; otherwise keep the reply to two lines.
