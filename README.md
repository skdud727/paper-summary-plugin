# paper-summary-plugin

A Claude plugin marketplace with one plugin, **paper-summary**: summarize and compare research papers and save them as block-style pages in your own Notion database.

See [plugins/paper-summary/README.md](plugins/paper-summary/README.md) for features, requirements, and usage.

## Install

Claude desktop app / claude.ai: **Customize → Plugins → Add → Add marketplace** → `skdud727/paper-summary-plugin`

Claude Code:

```
/plugin marketplace add skdud727/paper-summary-plugin
/plugin install paper-summary@paper-summary-marketplace
```

## Repository layout

```
.claude-plugin/marketplace.json     marketplace catalog
plugins/paper-summary/
  .claude-plugin/plugin.json        plugin manifest
  skills/setup/                     /paper-summary:setup
  skills/summarize/                 /paper-summary:summarize
  skills/compare/                   /paper-summary:compare
  references/                       shared rules, schema, layouts, domain presets
scripts/check-privacy.sh            scan for personal data before pushing
```

## Contributing

Run `scripts/check-privacy.sh` before every push. It fails if it finds email addresses, Notion page or database IDs, local file paths, or other personal identifiers.

## License

MIT
