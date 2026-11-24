# terminus-skill

A Claude Code skill for working with [Terminus](https://github.com/pantheon-systems/terminus), Pantheon's official CLI.

## What this skill does

When active, Claude Code can:

- Infer the correct Terminus command from a natural-language request
- Discover valid commands via `terminus list` and `terminus help <command>` rather than guessing
- Know about all official Pantheon plugins and community plugins, with exact command names
- Guide scripting and CI/CD integration patterns
- Refuse to suggest commands, flags, or subcommands that don't exist
- Know when (rarely) to call the Terminus API directly instead of using the CLI

## Requirements

- [Terminus 4.x](https://docs.pantheon.io/terminus/install) installed (`brew install terminus` on macOS)
- PHP 8.2+
- An active Pantheon account with a [machine token](https://docs.pantheon.io/machine-tokens)

Terminus 3.x is also supported with minor differences.

## Installation

Install from the marketplace in this repo:

```bash
claude plugin marketplace add jazzsequence/terminus-skill
claude plugin install terminus-skill@terminus-skill
```

Or, inside Claude Code: `/plugin marketplace add jazzsequence/terminus-skill`, then `/plugin install terminus-skill@terminus-skill`.

Start a new session (or run `/reload-plugins`) and the skill is available as `terminus`.

### Upgrading from the installer-based setup

Versions before 1.1.0 were installed by `install.sh` into `~/.claude/skills/terminus/`. Install the plugin as above. The first time the skill loads, it detects the old copy and offers to remove it, so you don't end up with two versions.

If it doesn't (for example if Claude picks the old copy instead of the plugin), remove it yourself: `rm -rf ~/.claude/skills/terminus`.

## Updating

```bash
claude plugin update terminus-skill@terminus-skill
```

To have Claude Code update it automatically, enable auto-update for the marketplace:

```
/plugin
→ → Marketplace
↓ terminus-skill
[RETURN] → → Enable auto-update
```

## Uninstalling

```bash
claude plugin uninstall terminus-skill@terminus-skill
```

## Usage

Invoke the skill by name in Claude Code:

```
/terminus
```

Or reference it in a prompt — Claude Code will automatically activate it when you're asking about Terminus commands.

## Skill structure

```
skills/terminus/
  SKILL.md                  Main skill file (loaded when invoked)
  references/
    commands.md             Complete command reference — all 170+ core commands
    plugins.md              Official and community plugin directory with commands
    env-vars.md             Environment variables and config.yml reference
    scripting.md            Bash scripting patterns and CI/CD examples
    safety.md               Destructive command checklist
    api.md                  Terminus API direct access (rare use cases)
```

## Covered plugins

Terminus compatibility is taken from the `compatible-version` field in each plugin's `composer.json`. A plugin may work on newer versions even if not yet declared.

### Pantheon-maintained

Plugins in the `pantheon-systems` org with a CODEOWNERS file assigning a Pantheon team. Check each repo's README badge for its current OSS support level.

| Plugin | Description | Terminus |
|---|---|---|
| [`terminus-autopilot-plugin`](https://github.com/pantheon-systems/terminus-autopilot-plugin) | Autopilot management | 3.x, 4.x |
| [`terminus-build-tools-plugin`](https://github.com/pantheon-systems/terminus-build-tools-plugin) | GitHub + CI/CD workflows | 3.x |
| [`terminus-composer-logs-plugin`](https://github.com/pantheon-systems/terminus-composer-logs-plugin) | View Composer operation logs | 3.x |
| [`terminus-composer-plugin`](https://github.com/pantheon-systems/terminus-composer-plugin) | Remote Composer operations | 3.x, 4.x |
| [`terminus-conversion-tools-plugin`](https://github.com/pantheon-systems/terminus-conversion-tools-plugin) | Drupal Composer conversion and upgrades | 3.x |
| [`terminus-decoupled-kit-plugin`](https://github.com/pantheon-systems/terminus-decoupled-kit-plugin) | Decoupled/headless site creation | 1.x–3.x |
| [`terminus-gcdn-plugin`](https://github.com/pantheon-systems/terminus-gcdn-plugin) | Global CDN upgrade and DNS verification | 3.x, 4.x |
| [`terminus-mass-update`](https://github.com/pantheon-systems/terminus-mass-update) | Bulk upstream updates | 1.x–4.x |
| [`terminus-quicksilver-plugin`](https://github.com/pantheon-systems/terminus-quicksilver-plugin) | Quicksilver webhook deployment | 1.x–4.x |
| [`terminus-rsync-plugin`](https://github.com/pantheon-systems/terminus-rsync-plugin) | File transfer to/from Pantheon | 3.x, 4.x |
| [`terminus-scheduled-jobs-plugin`](https://github.com/pantheon-systems/terminus-scheduled-jobs-plugin) | Cron job scheduling (private beta) | 3.x |
| [`terminus-site-clone-plugin`](https://github.com/pantheon-systems/terminus-site-clone-plugin) | Full site duplication | 2.x–4.x |
| [`terminus-site-debug`](https://github.com/pantheon-systems/terminus-site-debug) | Log parsing and New Relic summary | 1.x–4.x |
| [`terminus_debugging_tools`](https://github.com/pantheon-systems/terminus_debugging_tools) | Database blob and table analysis | 2.x |

### Community

Plugins without an assigned Pantheon team, including repos in `pantheon-systems` with no CODEOWNERS and all `terminus-plugin-project` plugins.

| Plugin | Description | Terminus |
|---|---|---|
| [`terminus-carbon-plugin`](https://github.com/pantheon-systems/terminus-carbon-plugin) | Carbon impact metrics | 2.x, 3.x |
| [`terminus-autocomplete-plugin`](https://github.com/terminus-plugin-project/terminus-autocomplete-plugin) | Tab completion for Terminus commands | 2.x–4.x |
| [`terminus-backup-all-plugin`](https://github.com/terminus-plugin-project/terminus-backup-all-plugin) | Back up all sites at once | 2.x |
| [`terminus-code-plugin`](https://github.com/terminus-plugin-project/terminus-code-plugin) | Clone site code to local | 2.x |
| [`terminus-domain-challenge`](https://github.com/terminus-plugin-project/terminus-domain-challenge) | Automate DNS challenge validation | 1.x–3.x |
| [`terminus-filer-plugin`](https://github.com/terminus-plugin-project/terminus-filer-plugin) | Open SFTP in desktop clients | 2.x, 3.x |
| [`terminus-pancakes-plugin`](https://github.com/terminus-plugin-project/terminus-pancakes-plugin) | Open databases in SQL clients | 1.x–4.x |
| [`terminus-replica-plugin`](https://github.com/terminus-plugin-project/terminus-replica-plugin) | Expose database replica connection details | 2.x |
| [`terminus-site-mount-plugin`](https://github.com/terminus-plugin-project/terminus-site-mount-plugin) | Mount Pantheon sites locally | 2.x |
| [`terminus-site-status-plugin`](https://github.com/terminus-plugin-project/terminus-site-status-plugin) | Multi-environment status overview | 2.x, 3.x |
| [`terminus-upstream-deployment-plugin`](https://github.com/terminus-plugin-project/terminus-upstream-deployment-plugin) | Automated upstream updates with backup | 1.x |

See the [terminus-plugin-project org](https://github.com/terminus-plugin-project) for the full list.

### Archived

Do not install. See [`references/plugins.md`](skills/terminus/references/plugins.md) for what each plugin did and what replaced it.

| Plugin | Last active | Notes |
|---|---|---|
| [`terminus-acme-plugin`](https://github.com/pantheon-systems/terminus-acme-plugin) | 2024-06 | Archived |
| [`terminus-aliases-plugin`](https://github.com/pantheon-systems/terminus-aliases-plugin) | 2020-06 | Built into Terminus 4.x (`aliases`) |
| [`terminus-clu-plugin`](https://github.com/pantheon-systems/terminus-clu-plugin) | 2024-10 | Archived |
| [`terminus-drupal-console-plugin`](https://github.com/pantheon-systems/terminus-drupal-console-plugin) | 2023-01 | Archived; Drupal Console deprecated |
| [`terminus-newrelic-data-plugin`](https://github.com/pantheon-systems/terminus-newrelic-data-plugin) | 2025-03 | Archived |
| [`terminus-node-logs-plugin`](https://github.com/pantheon-systems/terminus-node-logs-plugin) | 2024 | Built into Terminus 4.2+ (`node:logs:*`) |
| [`terminus-power-tools`](https://github.com/pantheon-systems/terminus-power-tools) | 2022-06 | Deprecated |
| [`terminus-repository-plugin`](https://github.com/pantheon-systems/terminus-repository-plugin) | 2024 | Built into Terminus 4.2+ (`vcs:*`) |
| [`terminus-retry`](https://github.com/pantheon-systems/terminus-retry) | 2024-12 | Archived |
| [`terminus-secrets-manager-plugin`](https://github.com/pantheon-systems/terminus-secrets-manager-plugin) | 2024 | Built into Terminus 4.2+ (`secret:site:*`, `secret:org:*`) |
| [`terminus-secrets-plugin`](https://github.com/pantheon-systems/terminus-secrets-plugin) | 2025-05 | Use built-in `secret:site:*` |
| [`terminus-yml-validator-plugin`](https://github.com/pantheon-systems/terminus-yml-validator-plugin) | 2023-04 | Use `sites-yml-validator` directly |

## Contributing

This skill is maintained separately from the Terminus repository. To contribute:

1. Fork this repository
2. Update the relevant reference file(s)
3. Open a pull request with a description of what changed and why

Command reference changes should be verified against the Terminus source at https://github.com/pantheon-systems/terminus.
