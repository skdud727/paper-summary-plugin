---
name: summarize
description: This skill should be used when the user shares a research paper (attached PDF, arXiv or DOI link, or a title) and asks to "summarize this paper", "요약해줘", "add this paper to Notion", "explain this paper's pipeline", or runs "/paper-summary:summarize". It writes a block-style summary with an input-to-output pipeline flowchart, finds up to two similar papers, and saves all of them to the user's Notion database.
metadata:
  version: "0.1.0"
---

# Summarize a paper

## Steps

1. Read `../../references/common.md` (relative to this file) and run Preflight. Read `../../references/layout.md` before writing any page.
2. **Perspectives.** Ask with AskUserQuestion (multiSelect) using the database's Perspective options. Pre-select nothing; mention that Tech + Results is the default. Skip the question and reuse the last choice if the user says "same as before", or use the default if the session is unattended.
3. **Read the paper.**
   - Attached PDF: extract the full text.
   - arXiv: fetch the abstract page and the HTML full text.
   - Other links: fetch the page; if paywalled and no PDF is attached, summarize from the abstract and state that on the page.
   - Verify the venue (proceedings site, open-access page). Leave it marked unverified otherwise.
4. **Deduplicate.** Query the database for the same title. If it exists, update that page instead of creating a new one.
5. **Understand the pipeline before writing.** Identify every input (with modality and shape/format), every output, each stage, which components are frozen/pretrained vs. learned, and any loop (iterations, denoising steps). This drives the flowchart.
6. **Similar papers.** Follow "Similar-paper search" in common.md. For each, collect overlap keywords.
7. **Write pages** in the configured lang, following layout.md:
   - Similar papers first (`Type = Similar`), with the overlap block on top.
   - Then the main paper (`Type = Summary`).
   - Set `Related Papers` in both directions between the main page and each similar page (common.md, Relations rule).
   - Fill Title, Authors, Venue, Year, Link, Tags (Tags rule), Perspective. No page icon.
8. **Check** by fetching the main page once: flowchart present with explicit input and output nodes, Results table present, no emoji outside the allowed callout icons.
9. **Reply** with one line per page (title + link + "new" or "linked existing"). Do not paste the summary into chat.
