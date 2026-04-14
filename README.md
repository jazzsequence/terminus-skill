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

### Via Claude Code marketplace (recommended — auto-updates)

Add this repo as a marketplace in your Claude Code `settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "terminus-skill": {
      "source": {
        "source": "github",
        "repo": "jazzsequence/terminus-skill"
      }
    }
  }
}
```

Then install the skill:

```
/plugin install terminus-skill@terminus-skill
```

### Via installer script

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jazzsequence/terminus-skill/main/install.sh)
```

Or from a local clone:

```bash
git clone https://github.com/jazzsequence/terminus-skill
cd terminus-skill
./install.sh
```

The skill will be available as `terminus` in Claude Code.

## Updating

**If installed via the marketplace:** Claude Code handles updates automatically. To update manually:

```
/plugin marketplace update terminus-skill
```

**If installed via the installer script:** Re-run the installer — it detects an existing install and pulls the latest:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jazzsequence/terminus-skill/main/install.sh)
```

## Uninstalling

**Marketplace install:**

```
/plugin uninstall terminus-skill
```

**Installer-based install:**

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

Plugins in the `pantheon-systems` org with a CODEOWNERS file and/or listed in the [Pantheon plugin directory](https://docs.pantheon.io/terminus/directory). Check each repo's README for its current maintenance status badge.

| Plugin | Description |
|---|---|
| [`terminus-autopilot-plugin`](https://github.com/pantheon-systems/terminus-autopilot-plugin) | Autopilot management |
| [`terminus-build-tools-plugin`](https://github.com/pantheon-systems/terminus-build-tools-plugin) | GitHub + CI/CD workflows |
| [`terminus-carbon-plugin`](https://github.com/pantheon-systems/terminus-carbon-plugin) | Carbon impact metrics |
| [`terminus-composer-plugin`](https://github.com/pantheon-systems/terminus-composer-plugin) | Remote Composer operations |
| [`terminus-conversion-tools-plugin`](https://github.com/pantheon-systems/terminus-conversion-tools-plugin) | Drupal Composer conversion and upgrades |
| [`terminus-decoupled-kit-plugin`](https://github.com/pantheon-systems/terminus-decoupled-kit-plugin) | Decoupled/headless site creation |
| [`terminus-mass-update`](https://github.com/pantheon-systems/terminus-mass-update) | Bulk upstream updates |
| [`terminus-quicksilver-plugin`](https://github.com/pantheon-systems/terminus-quicksilver-plugin) | Quicksilver webhook deployment |
| [`terminus-rsync-plugin`](https://github.com/pantheon-systems/terminus-rsync-plugin) | File transfer to/from Pantheon |
| [`terminus-scheduled-jobs-plugin`](https://github.com/pantheon-systems/terminus-scheduled-jobs-plugin) | Cron job scheduling (private beta) |
| [`terminus-site-clone-plugin`](https://github.com/pantheon-systems/terminus-site-clone-plugin) | Full site duplication |

> **Archived — do not install:** `terminus-secrets-plugin` is archived. Use the built-in `secret:site:*` commands in Terminus 4.x instead.

### Community (terminus-plugin-project)

Community-maintained plugins. May not support Terminus 4.x — verify before installing.

| Plugin | Description |
|---|---|
| [`terminus-autocomplete-plugin`](https://github.com/terminus-plugin-project/terminus-autocomplete-plugin) | Tab completion for Terminus commands |
| [`terminus-backup-all-plugin`](https://github.com/terminus-plugin-project/terminus-backup-all-plugin) | Back up all sites at once |
| [`terminus-code-plugin`](https://github.com/terminus-plugin-project/terminus-code-plugin) | Clone site code to local |
| [`terminus-domain-challenge`](https://github.com/terminus-plugin-project/terminus-domain-challenge) | Automate DNS challenge validation |
| [`terminus-filer-plugin`](https://github.com/terminus-plugin-project/terminus-filer-plugin) | Open SFTP in desktop clients |
| [`terminus-pancakes-plugin`](https://github.com/terminus-plugin-project/terminus-pancakes-plugin) | Open databases in SQL clients |
| [`terminus-replica-plugin`](https://github.com/terminus-plugin-project/terminus-replica-plugin) | Expose database replica connection details |
| [`terminus-site-mount-plugin`](https://github.com/terminus-plugin-project/terminus-site-mount-plugin) | Mount Pantheon sites locally |
| [`terminus-site-status-plugin`](https://github.com/terminus-plugin-project/terminus-site-status-plugin) | Multi-environment status overview |
| [`terminus-upstream-deployment-plugin`](https://github.com/terminus-plugin-project/terminus-upstream-deployment-plugin) | Automated upstream updates with backup |

See the [terminus-plugin-project org](https://github.com/terminus-plugin-project) for the full list.

## Contributing

This skill is maintained separately from the Terminus repository. To contribute:

1. Fork this repository
2. Update the relevant reference file(s)
3. Open a pull request with a description of what changed and why

Command reference changes should be verified against the Terminus source at https://github.com/pantheon-systems/terminus.
