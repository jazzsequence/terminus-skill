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

## Legacy install cleanup

Before 1.1.0 this skill was installed by a script into `~/.claude/skills/terminus/`. If that path still exists next to the marketplace plugin, Claude Code loads two copies and the old one goes stale. Once per session, the first time this skill loads:

1. **Check which copy is running.** The skill's base directory is shown when it loads. If it is `~/.claude/skills/terminus`, you are the legacy copy: tell the user to switch to the marketplace install (see the README) and stop. Never delete the directory you are running from.
2. **Otherwise, look for the old copy:** `ls -ld ~/.claude/skills/terminus`. If it doesn't exist, there is nothing to do.
3. **Verify it is the old install before touching it.**
   - Symlink (from the old `--symlink` option): it points into a local clone. Remove only the link with `rm ~/.claude/skills/terminus`, never the target.
   - Directory: it must be a clone of this repo with no local changes, i.e. `git -C ~/.claude/skills/terminus remote get-url origin` contains `jazzsequence/terminus-skill` and `git -C ~/.claude/skills/terminus status --porcelain` prints nothing. If either check fails, don't remove it; tell the user why.
4. **Ask the user to confirm, then remove it:** `rm -rf ~/.claude/skills/terminus`. Don't remove it without a yes.

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

On accounts that see many sites, an unfiltered `terminus site:list` can take 90+ seconds or time out. Use `org:site:list <org>` or `site:list --owner=me` instead, or `site:info <site>` when the site is already known.

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
| Next.js | No install step. The code lives in an external repo (`--vcs-provider=github`), and the creation workflow triggers the first build automatically. **That build can fail if the app needs secrets that aren't set yet** — see below. |

**Next.js builds and secrets.** Whether the first build succeeds depends on the app. If it reads environment variables during the build, those must exist before the build runs, or it ends in `BUILD_FAILURE`. For example, a Content Publisher starter needs `PCC_SITE_ID` and `PCC_TOKEN`, and a headless CMS frontend typically needs the CMS URL. Check the app's `.env.example`, README, or the Pantheon docs for what it expects.

- Set them as `--type=env --scope=web` secrets: `terminus secret:site:set <site> <name> <value> --type=env --scope=web`. Other type/scope combinations aren't exposed as `process.env.*` during the build, and type and scope can't be changed after creation (delete and re-create the secret).
- Set them as soon as the site exists, before the first build runs. The dev environment isn't ready the moment `site:info` starts answering, so retry `secret:site:set` until it succeeds. Running `site:create` as a background task makes this possible. The Pantheon Dashboard can also take secrets at site creation time.
- New or changed secrets only take effect on the next build. If the first build already failed or ran without them, set the secrets and run `terminus node:builds:rebuild <site>.dev`.
- `terminus node:builds:wait <site>.dev` can fail with "This command only works for sites using external VCS" until the creation workflow finishes. That's expected, so keep polling. If the build status becomes `BUILD_FAILURE`, stop polling and list builds with `terminus node:builds:list <site>.dev` and read the failing one with `terminus node:logs:build:get <site>.<env> <build-id>` (works on dev and multidev environments too). Don't recreate the site.

### Looking up site and environment details

Some values are per environment rather than per site, so asking `site:info` for them fails with `The requested field, '<name>', is not defined.`

| Value | Command |
|---|---|
| PHP version | `terminus env:list <site> --fields=id,php_version` (all environments) or `terminus env:info <site>.<env> --field=php_version` |
| Object cache (Redis) state | `terminus site:info <site> --field=has_object_cache` |
| Search (Solr/Elasticsearch) state | `terminus site:info <site> --field=search` |
| Organization, plan | `terminus site:info <site> --fields=organization,plan_name` (`site:list` has no `organization` field) |

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
