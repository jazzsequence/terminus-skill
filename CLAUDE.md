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

1. **New Terminus commands**: run `terminus list` against a fresh install or diff `src/Commands/` in the terminus repo — update `references/commands.md`
2. **New plugins**: check https://docs.pantheon.io/terminus/directory and the `pantheon-systems` GitHub org — update `references/plugins.md`
3. **Deprecated commands**: watch for `@deprecated` annotations in terminus source — mark in the command reference
4. **Plugin commands rolled into core**: when a plugin repo gets archived, move its commands into the core section and note they no longer need separate installation

## Skill file map

| File | Purpose |
|---|---|
| `SKILL.md` | Main skill — loaded when invoked. Workflows, syntax, common patterns. |
| `references/commands.md` | Full command reference, all namespaces |
| `references/plugins.md` | All known plugins with commands and install instructions |
| `references/env-vars.md` | Environment variables and `~/.terminus/config.yml` |
| `references/scripting.md` | Bash patterns and CI/CD examples |
| `references/safety.md` | Destructive command guardrails |
| `references/api.md` | Terminus API direct access (rare) |

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

## Installation path

Users install by copying this directory to `~/.claude/skills/terminus/`. The skill is invoked as `terminus` in Claude Code.

## Do not add to pantheon-skills

This skill is intentionally standalone and publicly distributable. Do not move it into the `pantheon-skills` marketplace or any Pantheon-internal plugin collection.
