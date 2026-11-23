---
name: terminus
description: "Use when working with Terminus (Pantheon's CLI) for site management, environment operations, deployments, backups, domain management, WP-CLI/Drush execution, multidev management, secrets, node builds, and Pantheon platform automation. Also handles Terminus plugin management and scripting."
compatibility: "Targets Terminus 4.x (PHP 8.2+). Terminus 3.x is also supported with minor differences noted inline."
---

# Terminus — Pantheon CLI

Terminus is Pantheon's official CLI. It wraps the Terminus API (`terminus.pantheon.io`) and provides commands for managing every aspect of sites, environments, users, and organizations on Pantheon. Almost everything in the Pantheon Dashboard can be done via Terminus.

## Ground rules

1. **Only use commands that exist.** Never invent command names, options, subcommands, or flags. The complete command reference is in `references/commands.md`. Plugin commands are in `references/plugins.md`. When unsure, use `terminus list` or `terminus help <command>` to verify before running anything.
2. **Always confirm exact syntax with `terminus help` before running any command.** Run `terminus help <command>` to get the authoritative parameter list for that command before suggesting or executing it. Reference files may lag behind the installed version. But `terminus help` and `terminus list` don't mark deprecated commands (the warning only prints when the command runs), so before suggesting a command also check its row in `references/commands.md`.
3. **Prefer Terminus CLI over direct API calls.** Terminus wraps the Terminus API (`terminus.pantheon.io`). Only call the API directly when no Terminus command or plugin covers the need. See `references/api.md`.
4. **Confirm site and environment before destructive operations.** See `references/safety.md` before running anything that modifies or deletes data.
5. **Verify authentication before every session.** Run `terminus auth:whoami` to confirm an active session. Re-run it after any long pause, before the next command. If unauthenticated, check `~/.terminus/cache/tokens/` for a saved token first (`terminus auth:login --email=<email>` reuses it with no prompt). Only ask for a machine token if none is saved for that email.

## Command syntax

```bash
terminus <namespace>:<action> [<site>.<env>] [options]
```

- `<site>` — site name (slug) or UUID. Use `terminus site:list` to discover sites.
- `<env>` — `dev`, `test`, `live`, or a multidev name. Use `terminus env:list <site>` to see valid environments.
- Get full options for any command: `terminus help <command>`
- Output format: `--format=table|list|json|csv|string` (default: `table`)
- Single field extraction: `--field=<field-name>`
- Skip confirmation prompts in scripts: `-y` / `--yes`
- Suppress all interaction: `-n` / `--no-interaction`
- Verbose/debug output: `-v`, `-vv`, `-vvv`

## Command discovery

When unsure what command to use or what options exist:

```bash
terminus list                        # all available commands (including plugin commands)
terminus list <namespace>            # commands in a namespace, e.g. terminus list site
terminus help <command>              # full options for one command
terminus self:plugin:list            # installed plugins and the namespaces they add
terminus self:info                   # Terminus version and environment info
```

**Never guess a command.** If it isn't in `references/commands.md`, `references/plugins.md`, or returned by `terminus list`, it does not exist.

## Inputs to gather

Before running Terminus, confirm:

| Input | How to discover |
|---|---|
| Site name/UUID | `terminus site:list` or ask the user |
| Environment | `terminus env:list <site>` — valid values: `dev`, `test`, `live`, or a multidev name |
| Authentication | `terminus auth:whoami` — if unauthenticated, check `~/.terminus/cache/tokens/` for a saved token for that email; only prompt for a machine token if none exists |
| Installed plugins | `terminus self:plugin:list` — needed if the user references a plugin command |

Ask only for what cannot be inferred or discovered programmatically.

## Authentication

```bash
terminus auth:login --machine-token=<token>      # authenticate with a machine token
terminus auth:login --email=<email>              # reuses the machine token saved for <email> in ~/.terminus/cache/tokens/; no prompt
terminus auth:whoami                             # verify current session + display user
terminus auth:logout                             # clear session
terminus machine-token:list                      # list stored machine tokens
```

**Session duration:** nominally 24 hours of inactivity; forced re-login after 30 days. Sessions have been observed to expire sooner (`You are not logged in` after ~10.5 idle hours), so re-run `terminus auth:whoami` after any long pause before the next command.

**For CI/CD:** set `TERMINUS_TOKEN` in the environment, then:
```bash
terminus auth:login --machine-token="${TERMINUS_TOKEN}"
```

## Common workflows

All exact command syntax is in `references/commands.md`, organized by namespace. Use the namespace as a guide:

| Task | Namespace(s) | Notes |
|---|---|---|
| Deploy code (dev→test, test→live) | `env` | See `env:deploy` — use `--cc`, `--updatedb`, `--sync-content` |
| Clone content between environments | `env` | `env:clone-content` — `--db-only` or `--files-only` available |
| Clear cache | `env` | `env:clear-cache` |
| Manage multidev environments | `multidev` | Create, list, merge, delete |
| Backup and restore | `backup` | Create, list, download, restore; automatic schedule via `backup:automatic:*` |
| Switch connection mode (git/SFTP) | `connection` | Required before some plugin installs |
| Manage domains and HTTPS | `domain`, `https` | Add/remove domains, DNS recommendations, custom certs |
| Manage secrets | `secret` | `secret:site:*` and `secret:org:*` — built into Terminus 4.x |
| Site CRUD and upstream updates | `site`, `upstream` | List, create, delete sites; apply upstream updates |
| Node.js / Frontend builds | `node` | `node:builds:*` and `node:logs:*` |
| Monitor workflows | `workflow` | List, watch live, wait for completion |

### WP-CLI and Drush

```bash
terminus remote:wp <site>.<env> -- <wp-cli-args>
terminus remote:drush <site>.<env> -- <drush-args>
```

The `--` separator is required — without it, flags are parsed by Terminus instead of WP-CLI/Drush. See `references/commands.md` under `remote` for full options.

### Creating a site

`terminus site:create` is slow. WordPress sites have taken 2m40s–4m+, so allow a timeout over 5 minutes. A new site isn't usable right away, and what's left to do depends on the framework:

| Site type | After `site:create` |
|---|---|
| WordPress | Dev has code but no install. Run `terminus remote:wp <site>.dev -- core install ...` before anything else works. |
| Drupal | Dev has code but no install. Run `terminus remote:drush <site>.dev -- site-install -y`; `remote:drush <site>.dev -- user-login` gives a one-time login link. |
| Next.js | No install step. The code lives in an external repo (`--vcs-provider=github`), and the creation workflow triggers the first build. `terminus node:builds:wait <site>.dev` can fail with "This command only works for sites using external VCS" until that workflow finishes. That's expected, so keep polling rather than recreating the site. |

## Plugins

Plugin commands are only available after installation. Always verify a plugin is installed with `terminus self:plugin:list` before suggesting its commands.

```bash
terminus self:plugin:install <vendor/package>      # install from Packagist
terminus self:plugin:list                          # list installed plugins + namespaces added
terminus self:plugin:update <plugin-name>
terminus self:plugin:uninstall <plugin-name>
terminus self:plugin:search <keyword>
terminus self:plugin:reload
```

For the full plugin directory — Pantheon-maintained, community, and archived — with commands, Terminus compatibility, and install instructions, see `references/plugins.md`.

## Reference files

| File | Contents |
|---|---|
| `references/commands.md` | Complete reference for all core commands, organized by namespace |
| `references/plugins.md` | All known plugins — Pantheon-maintained, community, archived — with Terminus compatibility, commands, and install instructions |
| `references/env-vars.md` | Environment variables and `~/.terminus/config.yml` configuration |
| `references/scripting.md` | Bash scripting patterns and CI/CD integration (GitHub Actions, CircleCI, GitLab, Bitbucket) |
| `references/safety.md` | Destructive command checklist and confirmation requirements |
| `references/api.md` | When and how to call the Terminus API directly (rare — CLI is almost always correct) |
