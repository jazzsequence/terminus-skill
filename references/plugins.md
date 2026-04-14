# Terminus Plugin Directory

Terminus plugins extend the CLI with additional commands. Install plugins with:

```bash
terminus self:plugin:install <packagist-vendor/package-name>
terminus self:plugin:list        # verify installation and see added commands
```

After installing a plugin, its commands appear in `terminus list` just like core commands.

---

## Official Pantheon Plugins

These plugins are maintained by Pantheon Systems (`pantheon-systems` GitHub org). Unless noted, they target Terminus 4.x.

---

### terminus-autopilot-plugin
**Package:** `pantheon-systems/terminus-autopilot-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-autopilot-plugin
**Purpose:** Manage Pantheon Autopilot from the command line.

```bash
terminus self:plugin:install pantheon-systems/terminus-autopilot-plugin
```

Provides commands to trigger, configure, and inspect Autopilot runs for sites that have it enabled.

---

### terminus-build-tools-plugin
**Package:** `pantheon-systems/terminus-build-tools-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-build-tools-plugin
**Purpose:** CI/CD workflow automation — create sites wired to GitHub and CircleCI, manage PR-based multidev environments.

```bash
terminus self:plugin:install pantheon-systems/terminus-build-tools-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `build:project:create` | Create a new site with GitHub + CI integration |
| `build:project:info` | Display project information |
| `build:project:repair` | Repair an existing Build Tools project |
| `build:env:create` | Create a multidev for a PR/branch |
| `build:env:delete:ci` | Delete CI-pattern environments |
| `build:env:delete:pr` | Delete PR-pattern environments |
| `build:env:install` | Install CMS on an environment |
| `build:env:list` | List multidev environments |
| `build:env:merge` | Merge a multidev into dev |
| `build:env:obliterate` | Delete the entire project |
| `build:env:push` | Push code to an existing site |
| `build:secrets:set` | Set a CI secret |
| `build:secrets:show` | Show a CI secret |
| `build:secrets:list` | List CI secrets |
| `build:secrets:delete` | Delete a CI secret |
| `build:comment:add:commit` | Add a comment to a commit |
| `build:comment:add:pr` | Add a comment to a PR |
| `build:credentials:clear` | Clear cached CI credentials |
| `build:workflow:wait` | Wait for a workflow to complete |
| `build:gitignore:cut` | Cut .gitignore at the cut marker |
| `ci:configure` | Configure CI integration for a site |

---

### terminus-carbon-plugin
**Package:** `pantheon-systems/terminus-carbon-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-carbon-plugin
**Purpose:** Retrieve carbon impact and sustainability metrics for Pantheon sites.

```bash
terminus self:plugin:install pantheon-systems/terminus-carbon-plugin
```

---

### terminus-composer-plugin
**Package:** `pantheon-systems/terminus-composer-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-composer-plugin
**Purpose:** Execute Composer operations on Pantheon environments directly via Terminus.

```bash
terminus self:plugin:install pantheon-systems/terminus-composer-plugin
```

Adds `composer` commands that run Composer on the remote environment.

---

### terminus-conversion-tools-plugin
**Package:** `pantheon-systems/terminus-conversion-tools-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-conversion-tools-plugin
**Purpose:** Convert standard Drupal sites into Composer-managed sites; upgrade Drupal versions; migrate between upstreams.

```bash
terminus self:plugin:install pantheon-systems/terminus-conversion-tools-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `conversion:advise <site>` | Analyze site state and advise on next steps |
| `conversion:composer <site>` | Convert a site to Composer-managed Drupal |
| `conversion:create-project <name> <label>` | Create a site from a Drupal distribution |
| `conversion:convert-upstream-from-site <site>` | Convert an exemplar site to an upstream |
| `conversion:enable-ic <site>` | Enable Pantheon Integrated Composer |
| `conversion:import-site <site>` | Create a site from imported code, database, and files |
| `conversion:push-to-multidev <site>` | Push converted site to a multidev |
| `conversion:release-to-dev <site>` | Release converted site to dev |
| `conversion:restore-dev <site>` | Restore dev to its pre-conversion state |
| `conversion:update-from-deprecated-upstream <site>` | Migrate from deprecated upstream to `drupal-composer-managed` |
| `conversion:upgrade-d9 <site>` | Upgrade Drupal 8 (IC) to Drupal 9 |
| `conversion:validate-gitignore <site>` | Validate and update the `.gitignore` file |

Notable options: `--dry-run`, `--ignore-build-tools`, `--run-updb`, `--run-cr`, `--branch=<branch>`

---

### terminus-decoupled-kit-plugin
**Package:** `pantheon-systems/terminus-decoupled-kit-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-decoupled-kit-plugin
**Purpose:** Create decoupled (headless) CMS sites on Pantheon with a paired front-end codebase.

```bash
terminus self:plugin:install pantheon-systems/terminus-decoupled-kit-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `decoupled-kit:create <site-name> <label> [<upstream-id>]` | Create a CMS backend site and front-end codebase |

Options: `--org=<org>`, `--region=<region>`, `--cms=drupal\|wordpress`, `--install-cms=true\|false`

Note: The front-end codebase is scaffolded locally but not deployed automatically. Deploy separately via the import repository workflow.

---

### terminus-mass-update
**Package:** `pantheon-systems/terminus-mass-update`
**GitHub:** https://github.com/pantheon-systems/terminus-mass-update
**Purpose:** Apply upstream updates across multiple sites in bulk.

```bash
terminus self:plugin:install pantheon-systems/terminus-mass-update
```

**Commands:**

| Command | Description |
|---|---|
| `site:mass-update:apply` | Apply upstream updates to multiple sites |

Common pattern (pipe site list):
```bash
terminus site:list --format=list | terminus site:mass-update:apply --accept-upstream --updatedb
```

Options: `--accept-upstream` (auto-accept upstream changes), `--updatedb`, `--dry-run`

---

### terminus-quicksilver-plugin
**Package:** `pantheon-systems/terminus-quicksilver-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-quicksilver-plugin
**Purpose:** Deploy Quicksilver webhooks and scripts from the official example collection.

```bash
terminus self:plugin:install pantheon-systems/terminus-quicksilver-plugin
```

---

### terminus-rsync-plugin
**Package:** `pantheon-systems/terminus-rsync-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-rsync-plugin
**Purpose:** Transfer files between local filesystem and Pantheon environments via rsync.

```bash
terminus self:plugin:install pantheon-systems/terminus-rsync-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `rsync <site>.<env>:<remote-path> <local-path>` | Download files from Pantheon |
| `rsync <local-path> <site>.<env>:<remote-path>` | Upload files to Pantheon |

---

### terminus-scheduled-jobs-plugin
**Package:** `pantheon-systems/terminus-scheduled-jobs-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-scheduled-jobs-plugin
**Purpose:** Create and manage scheduled cron jobs on Pantheon environments.

```bash
terminus self:plugin:install pantheon-systems/terminus-scheduled-jobs-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `scheduledjobs:schedule:create <site>.<env>` | Create a scheduled job (UNIX cron format: `* * * * *`) |
| `scheduledjobs:schedule:list <site>.<env>` | List all job schedules |
| `scheduledjobs:schedule:pause <site>.<env> <schedule-id>` | Pause a schedule |
| `scheduledjobs:schedule:resume <site>.<env> <schedule-id>` | Resume a paused schedule |
| `scheduledjobs:schedule:delete <site>.<env> <schedule-id>` | Delete a schedule |
| `scheduledjobs:job:list <site>.<env> <schedule-id>` | List executions for a schedule |
| `scheduledjobs:job:logs <site>.<env> <job-id>` | View logs for a job execution |
| `scheduledjobs:budget:info <site>.<env>` | View job budget (daily limit: 300 minutes) |

Notes:
- Schedule format: standard 5-field UNIX cron (`minute hour day month weekday`)
- Daily budget: 300 minutes per environment
- Email via `sendmail`/`localhost` SMTP is not permitted in jobs

---

### terminus-secrets-plugin (legacy)
**Package:** `pantheon-systems/terminus-secrets-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-secrets-plugin
**Purpose:** Manage `secrets.json` configuration files (older method; prefer `secret:site:*` core commands in Terminus 4.x).

This plugin is for managing the older `private/secrets.json` approach. For Terminus 4.x, use the built-in `secret:site:*` and `secret:org:*` commands instead.

---

### terminus-site-clone-plugin
**Package:** `pantheon-systems/terminus-site-clone-plugin`
**GitHub:** https://github.com/pantheon-systems/terminus-site-clone-plugin
**Purpose:** Duplicate an entire Pantheon site (code, database, and files) to a new site.

```bash
terminus self:plugin:install pantheon-systems/terminus-site-clone-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `site:clone <source-site>.<env> <destination-site>.<env>` | Clone a site to another site/env |

Options: `--cc`, `--updatedb`, `--no-source-backup`, `--no-destination-backup`

---

## Plugins Rolled Into Terminus Core (4.x)

The following plugins are now built into Terminus 4.x and should **not** be installed separately. Their repos are archived.

| Plugin | Now part of core command |
|---|---|
| `terminus-aliases-plugin` | `aliases` command |
| `terminus-node-logs-plugin` | `node:logs:*` commands |
| `terminus-repository-plugin` | `vcs:*` commands |
| `terminus-secrets-manager-plugin` | `secret:site:*` and `secret:org:*` commands |

---

## Community Plugins

Maintained by the community (`terminus-plugin-project` GitHub org).

---

### terminus-filer-plugin
**Package:** `terminus-plugin-project/terminus-filer-plugin`
**GitHub:** https://github.com/terminus-plugin-project/terminus-filer-plugin
**Purpose:** Open SFTP connections to Pantheon sites in a desktop SFTP client.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-filer-plugin
```

---

### terminus-pancakes-plugin
**Package:** `terminus-plugin-project/terminus-pancakes-plugin`
**GitHub:** https://github.com/terminus-plugin-project/terminus-pancakes-plugin
**Purpose:** Open site databases directly in a local SQL client (Sequel Ace, TablePlus, etc.).

```bash
terminus self:plugin:install terminus-plugin-project/terminus-pancakes-plugin
```

Configuration in `~/.terminus/config.yml`:
```yaml
# Example: configure your preferred SQL client
```

---

### terminus-site-status-plugin
**Package:** `terminus-plugin-project/terminus-site-status-plugin`
**GitHub:** https://github.com/terminus-plugin-project/terminus-site-status-plugin
**Purpose:** Display status of all environments across Pantheon sites in a single view.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-site-status-plugin
```

---

## Pantheon-Internal Plugins (not publicly available)

These plugins exist in the `pantheon-systems` GitHub org but are intended for internal use. They may require Pantheon employee access or internal configuration to function.

| Plugin | Purpose |
|---|---|
| `terminus-addons-installer-plugin` | Trigger platform workflows to configure themes/plugins. Commands: `addons-install:list`, `addons-install:run <job>` |
| `terminus-admin-plugin` | Admin-level operations for Pantheon employees. Requires `TERMINUS_HOST_CERT` env var. Commands: `session`, `site:thaw`, `org:site:add` |
| `terminus-vulnerability-monitor-plugin` | Interact with the Pantheon vulnerability monitoring service. Commands: `site-data:info`, `site-data:plugins`, `site-data:themes`, `site-data:cms`, `site-data:index` |

---

## Discovering More Plugins

```bash
terminus self:plugin:search <keyword>    # search Packagist for terminus plugins
```

Terminus plugins on Packagist have `type: "terminus-plugin"` in their `composer.json`. The Pantheon plugin directory at https://docs.pantheon.io/terminus/directory lists curated plugins.
