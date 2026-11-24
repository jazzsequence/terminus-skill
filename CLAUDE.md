# CLAUDE.md — terminus-skill

This repository contains a Claude Code skill for Terminus, Pantheon's CLI. It is **not** part of the Terminus codebase — it is a standalone, installable skill.

## Context that started this work

This skill was created from the following sources of truth (all consulted during initial authoring):

- **Terminus source**: `~/git/terminus` (pantheon-systems/terminus) — used to extract the complete command inventory from `src/Commands/`, understand the plugin architecture, and identify the Terminus API endpoint (`terminus.pantheon.io`)
- **Pantheon documentation repo**: `~/git/documentation` (pantheon-systems/documentation) — terminus docs at `src/source/content/terminus/` including the commands.json reference, CI/CD guides, scripting patterns, and plugin directory
- **docs.pantheon.io/terminus** — live documentation for install, configuration, scripting, plugins
- **Local plugin repos** in `~/git/`:
  - `terminus-build-tools-plugin`
  - `terminus-repository-plugin` (deprecated, rolled into Terminus 4.x core)
  - `terminus-addons-installer-plugin`
  - `terminus-admin-plugin` (internal only)
  - `terminus-vulnerability-monitor-plugin` (internal only)
- **GitHub org scan** of `pantheon-systems` for all repos matching `terminus-*-plugin`

## Key facts to preserve

- The **Terminus API** endpoint is `https://terminus.pantheon.io` — this is what Terminus wraps
- The **Pantheon API** is a separate service at `https://api.pantheon.io` — out of scope for this skill
- Four plugins were rolled into Terminus 4.x core and are now archived: `terminus-aliases-plugin`, `terminus-node-logs-plugin`, `terminus-repository-plugin`, `terminus-secrets-manager-plugin`
- Terminus 4.x requires PHP 8.2+; Terminus 3.x required PHP 7.4–8.1
- Plugin type identifier in composer.json: `"type": "terminus-plugin"`
- Plugins install via Packagist into `~/.terminus/plugins/vendor/`

## What needs ongoing maintenance

When updating this skill, check:

1. **New Terminus commands**: run `terminus list` against a fresh install or diff `src/Commands/` in the terminus repo — update `skills/terminus/references/commands.md`
2. **New plugins**: check https://docs.pantheon.io/terminus/directory and the `pantheon-systems` GitHub org — update `skills/terminus/references/plugins.md`
3. **Deprecated commands**: watch for `@deprecated` annotations in terminus source — mark in the command reference
4. **Plugin commands rolled into core**: when a plugin repo gets archived, move its commands into the core section and note they no longer need separate installation

## Skill file map

| File | Purpose |
|---|---|
| `skills/terminus/SKILL.md` | Main skill — loaded when invoked. Workflows, syntax, common patterns. |
| `skills/terminus/references/commands.md` | Full command reference, all namespaces |
| `skills/terminus/references/plugins.md` | All known plugins with commands and install instructions |
| `skills/terminus/references/env-vars.md` | Environment variables and `~/.terminus/config.yml` |
| `skills/terminus/references/scripting.md` | Bash patterns and CI/CD examples |
| `skills/terminus/references/safety.md` | Destructive command guardrails |
| `skills/terminus/references/api.md` | Terminus API direct access (rare) |

## Commands to verify the skill

After making changes, spot-check with:

```bash
# Verify command names are real
terminus list | grep <command-name>

# Verify plugin commands
terminus self:plugin:install <vendor/package>
terminus list | grep <plugin-namespace>

# Verify API endpoint behavior
terminus <command> -vvv 2>&1 | grep terminus.pantheon.io
```

## Versioning

**Bump the version in both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` whenever skill content changes**, and add a `CHANGELOG.md` entry. The plugin system compares version numbers to decide whether an update is available — if the version never changes, `claude plugin update` reports "already at the latest version" even when `SKILL.md` or the references changed.

Use semantic versioning: `patch` for corrections and small additions to the guidance or references, `minor` for new workflows or sections, `major` for breaking changes.

## Installation

This repo is both a plugin and its own marketplace (`.claude-plugin/marketplace.json` with `"source": "./"`). Users install with `claude plugin marketplace add jazzsequence/terminus-skill` and `claude plugin install terminus-skill@terminus-skill`; there is no installer script and nothing in the install or update path uses git directly. The skill must live at `skills/terminus/SKILL.md` — a `SKILL.md` at the repo root is not picked up by the plugin system. Run `claude plugin validate .` after structural changes.

## Do not add to pantheon-skills

This skill is intentionally standalone and publicly distributable. Do not move it into the `pantheon-skills` marketplace or any Pantheon-internal plugin collection.
