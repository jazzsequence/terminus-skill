---
name: terminus
description: "Use when working with Terminus (Pantheon's CLI) for site management, environment operations, deployments, backups, domain management, WP-CLI/Drush execution, multidev management, secrets, node builds, and Pantheon platform automation. Also handles Terminus plugin management and scripting."
compatibility: "Targets Terminus 4.x (PHP 8.2+). Terminus 3.x is also supported with minor differences noted inline."
---

# Terminus — Pantheon CLI

Terminus is Pantheon's official CLI. It wraps the Terminus API (`terminus.pantheon.io`) and provides commands for managing every aspect of sites, environments, users, and organizations on Pantheon. Almost everything in the Pantheon Dashboard can be done via Terminus.

## Ground rules

1. **Only use commands that exist.** Never invent command names, options, subcommands, or flags. The complete command reference is in `references/commands.md`. When unsure, use `terminus list` or `terminus <command> --help` to verify before running anything.
2. **Prefer Terminus CLI over direct API calls.** Terminus wraps the Terminus API (`terminus.pantheon.io`). Only call the API directly when no Terminus command or plugin covers the need. See `references/api.md`.
3. **Confirm site and environment before destructive operations.** See `references/safety.md` before running anything that modifies or deletes data.
4. **Verify authentication before every session.** Run `terminus auth:whoami` to confirm an active session. If unauthenticated, prompt for a machine token.

## Command syntax

```bash
terminus <namespace>:<action> [<site>.<env>] [options]
```

- `<site>` — site name (slug) or UUID. Use `terminus site:list` to discover sites.
- `<env>` — `dev`, `test`, `live`, or a multidev name. Use `terminus env:list <site>` to see valid environments.
- Most commands accept `--help` for the full option reference.
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
terminus <command> --help            # full options for one command
terminus self:plugin:list            # installed plugins and the namespaces they add
terminus self:info                   # Terminus version and environment info
```

**Never guess a command.** If it isn't in `references/commands.md` or returned by `terminus list`, it does not exist.

## Inputs to gather

Before running Terminus, confirm:

| Input | How to discover |
|---|---|
| Site name/UUID | `terminus site:list` or ask the user |
| Environment | `terminus env:list <site>` — valid values: `dev`, `test`, `live`, or a multidev name |
| Authentication | `terminus auth:whoami` — if unauthenticated, prompt for a machine token |
| Installed plugins | `terminus self:plugin:list` — needed if the user references a plugin command |

Ask only for what cannot be inferred or discovered programmatically.

## Authentication

```bash
terminus auth:login --machine-token=<token>      # authenticate with a machine token
terminus auth:login --email=<email>              # interactive login (prompts for token)
terminus auth:whoami                             # verify current session + display user
terminus auth:logout                             # clear session
terminus machine-token:list                      # list stored machine tokens
```

**Session duration:** 24 hours of inactivity; forced re-login after 30 days.

**For CI/CD:** set `TERMINUS_TOKEN` in the environment, then:
```bash
terminus auth:login --machine-token="${TERMINUS_TOKEN}"
```

## Common workflows

### Deploy code

```bash
# Dev → Test
terminus env:deploy <site>.test --note="Description" --cc --updatedb

# Test → Live
terminus env:deploy <site>.live --note="Description" --cc --updatedb
```

`--cc` clears caches after deploy. `--updatedb` runs DB updates (Drupal/WordPress). `--sync-content` clones Live DB/files to Test before deploying (Test only).

### Clone content between environments

```bash
terminus env:clone-content <site>.live <site>.dev        # database + files
terminus env:clone-content <site>.live <site>.dev --db-only
terminus env:clone-content <site>.live <site>.dev --files-only
```

### Clear cache

```bash
terminus env:clear-cache <site>.<env>
```

### Execute WP-CLI or Drush remotely

```bash
terminus remote:wp <site>.<env> -- <wp-cli-args>
terminus remote:drush <site>.<env> -- <drush-args>

# Examples
terminus remote:wp mysite.dev -- plugin list
terminus remote:wp mysite.live -- plugin activate debug-bar
terminus remote:drush mysite.dev -- cr
terminus remote:drush mysite.dev -- updb
```

The `--` separator is required to pass flags to WP-CLI/Drush rather than Terminus.

### Multidev environments

```bash
terminus multidev:create <site>.dev <multidev-name>          # create from dev
terminus multidev:list <site>                                 # list all multidevs
terminus multidev:merge-to-dev <site>.<multidev-name>         # merge into dev
terminus multidev:merge-from-dev <site>.<multidev-name>       # merge dev into multidev
terminus multidev:delete <site>.<multidev-name>               # delete
terminus multidev:delete <site>.<multidev-name> --delete-branch  # also delete git branch
```

### Backup and restore

```bash
terminus backup:create <site>.<env>                                   # full backup
terminus backup:create <site>.<env> --element=database
terminus backup:list <site>.<env>
terminus backup:get <site>.<env> --element=database --to=/tmp/        # download
terminus backup:restore <site>.<env> --element=database               # restore latest
terminus backup:restore <site>.<env> --element=database --file=<name> # restore specific
terminus backup:automatic:enable <site>.<env>
terminus backup:automatic:info <site>.<env>
```

### Connection mode

```bash
terminus connection:set <site>.<env> sftp    # SFTP mode (needed for some plugin installs)
terminus connection:set <site>.<env> git     # Git mode
terminus connection:info <site>.<env>        # connection details (SFTP, Git, MySQL, Redis)
```

### Domains and HTTPS

```bash
terminus domain:list <site>.<env>
terminus domain:add <site>.<env> example.com
terminus domain:remove <site>.<env> example.com
terminus domain:dns <site>.<env>                    # recommended DNS settings
terminus domain:primary:add <site>.<env> example.com
terminus https:info <site>.<env>
terminus https:set <site>.<env> <cert> <key>        # custom certificate
terminus https:remove <site>.<env>
```

### Secrets

```bash
terminus secret:site:list <site>
terminus secret:site:set <site> <name> <value> --scope=web,ic
terminus secret:site:delete <site> <name>
terminus secret:org:list <org>
terminus secret:org:set <org> <name> <value>
```

### Site management

```bash
terminus site:list
terminus site:list --org=<org>
terminus site:info <site>
terminus site:create <name> <label> <upstream-id> [--org=<org>] [--region=us|eu|au|ca]
terminus site:delete <site>
terminus upstream:list                              # list available upstreams
terminus upstream:updates:list <site>.<env>         # pending upstream updates
terminus upstream:updates:apply <site>.<env> --updatedb --accept-upstream
```

### Node.js sites (Frontend)

```bash
terminus node:builds:list <site>.<env>
terminus node:builds:rebuild <site>.<env>
terminus node:builds:rollback <site>.<env> <build-id>
terminus node:builds:wait <site>.<env>
terminus node:logs:build:get <site>.<env> <build-id>
terminus node:logs:runtime:get <site>.<env>
```

### Workflows

```bash
terminus workflow:list <site>
terminus workflow:watch <site>                      # stream live workflow updates
terminus workflow:wait <site>.<env> --max=300       # wait up to N seconds
```

## Plugin management

```bash
terminus self:plugin:install <vendor/package>      # install from Packagist
terminus self:plugin:list                          # list installed plugins
terminus self:plugin:update <plugin-name>
terminus self:plugin:uninstall <plugin-name>
terminus self:plugin:search <keyword>
terminus self:plugin:reload
```

For the full plugin directory with commands and install examples — see `references/plugins.md`.

## Reference files

| File | Contents |
|---|---|
| `references/commands.md` | Complete reference for all 170+ core commands, organized by namespace |
| `references/plugins.md` | All known plugins — Pantheon-maintained, community, archived — with Terminus compatibility, commands, and install instructions |
| `references/env-vars.md` | Environment variables and `~/.terminus/config.yml` configuration |
| `references/scripting.md` | Bash scripting patterns and CI/CD integration (GitHub Actions, CircleCI, GitLab, Bitbucket) |
| `references/safety.md` | Destructive command checklist and confirmation requirements |
| `references/api.md` | When and how to call the Terminus API directly (rare — CLI is almost always correct) |
