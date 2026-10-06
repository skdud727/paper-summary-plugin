# Database schema

Create with the Notion connector's create-database tool (SQL DDL). Title: `Paper Summaries`.

```sql
CREATE TABLE (
  "Title" TITLE,
  "Type" SELECT('Summary':blue, 'Similar':purple, 'Comparison':orange),
  "Authors" RICH_TEXT,
  "Venue" RICH_TEXT,
  "Year" NUMBER,
  "Link" URL,
  "Tags" MULTI_SELECT('Survey':gray),
  "Perspective" MULTI_SELECT('Tech':blue, 'Results':green, 'Experiment Setup':yellow, 'Limitations':red),
  "Compare" CHECKBOX COMMENT 'Check the papers you want to compare',
  "Added" CREATED_TIME
)
```

Then, with the new data source ID, add the single one-way self relation:

```sql
ADD COLUMN "Related Papers" RELATION('<data_source_id>')
```

If Notion still creates a reverse column, drop it (`DROP COLUMN "<reverse name>"`) so only `Related Papers` remains.

Then replace the Tags and Perspective options with the domain presets from `domains.md` (keep `Survey`), and set the data source description to the config line:

```
[paper-summary-plugin] v1 | domain: <comma-separated domains> | lang: <ko|en>
```

## Property meaning

| Property | Use |
|---|---|
| Title | Paper title. Comparison pages: `Compare: <axis> — A vs B (vs C)` |
| Type | Summary = main paper, Similar = auto-found similar paper, Comparison = comparison page |
| Authors / Venue / Year / Link | Metadata. Venue only if verified |
| Tags | 3–6 per page from the domain presets; add new options via ALTER without dropping old ones |
| Perspective | Perspectives the page covers |
| Compare | The user checks papers to compare; the compare skill unchecks them afterwards |
| Related Papers | The only link column. Main ↔ similar ↔ comparison pages, set in both directions |
| Added | Automatic |

There is no One-liner column; the TL;DR callout at the top of each page serves that role.

## Adopting an existing database

Fetch it, add any missing properties above, and never delete or rename the user's own properties. Exception: if it has a `One-liner` or `Referenced By` column created by an older version of this plugin, ask before removing it.
