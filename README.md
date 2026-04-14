# terminus-skill

A Claude Code skill for working with [Terminus](https://github.com/pantheon-systems/terminus), Pantheon's official CLI.

## What this skill does

When active, Claude Code can:

- Infer the correct Terminus command from a natural-language request
- Discover valid commands via `terminus list` and `--help` rather than guessing
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

### One-liner (once repo is published)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jazzsequence/terminus-skill/main/install.sh)
```

### From a local clone

```bash
git clone https://github.com/jazzsequence/terminus-skill
cd terminus-skill
./install.sh
```

### Symlink mode (recommended for contributors)

Installs a symlink so `git pull` in your clone automatically updates the skill:

```bash
./install.sh --symlink
```

The skill will be available as `terminus` in Claude Code.

## Updating

**If installed via the installer (default):** Re-run the installer — it detects an existing git-managed install and runs `git pull`:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jazzsequence/terminus-skill/main/install.sh)
# or, from your local clone:
./install.sh
```

**If installed with `--symlink`:** Update your local clone:

```bash
cd /path/to/terminus-skill
git pull
```

## Uninstalling

```bash
./install.sh --uninstall
```

## Usage

Invoke the skill by name in Claude Code:

```
/terminus
```

Or reference it in a prompt — Claude Code will automatically activate it when you're asking about Terminus commands.

## Skill structure

```
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

### Official (Pantheon Systems)
- `terminus-autopilot-plugin` — Autopilot management
- `terminus-build-tools-plugin` — GitHub + CI/CD workflows
- `terminus-carbon-plugin` — Carbon impact metrics
- `terminus-composer-plugin` — Remote Composer operations
- `terminus-conversion-tools-plugin` — Drupal Composer conversion and upgrades
- `terminus-decoupled-kit-plugin` — Decoupled/headless site creation
- `terminus-mass-update` — Bulk upstream updates
- `terminus-quicksilver-plugin` — Quicksilver webhook deployment
- `terminus-rsync-plugin` — File transfer to/from Pantheon
- `terminus-scheduled-jobs-plugin` — Cron job scheduling
- `terminus-secrets-plugin` — Legacy secrets.json management
- `terminus-site-clone-plugin` — Full site duplication

### Community (terminus-plugin-project)
- `terminus-filer-plugin` — Open SFTP connections in desktop clients
- `terminus-pancakes-plugin` — Open databases in SQL clients
- `terminus-site-status-plugin` — Multi-environment status overview

## Contributing

This skill is maintained separately from the Terminus repository. To contribute:

1. Fork this repository
2. Update the relevant reference file(s)
3. Open a pull request with a description of what changed and why

Command reference changes should be verified against the Terminus source at https://github.com/pantheon-systems/terminus.
