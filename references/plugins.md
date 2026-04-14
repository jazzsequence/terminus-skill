# Terminus Plugin Directory

Terminus plugins extend the CLI with additional commands. Install plugins with:

```bash
terminus self:plugin:install <packagist-vendor/package-name>
terminus self:plugin:list        # verify installation and see added commands
```

After installing a plugin, its commands appear in `terminus list` just like core commands.

**Terminus compatibility** is taken from the `compatible-version` constraint in each plugin's `composer.json`. A plugin may work on newer versions even if not yet declared — verify before assuming incompatibility.

---

## Pantheon-maintained Plugins

These plugins live in the `pantheon-systems` GitHub org and have a CODEOWNERS file assigning a Pantheon team. Check each repo's README badge for its current OSS support level.

---

### [terminus-autopilot-plugin](https://github.com/pantheon-systems/terminus-autopilot-plugin)
**Package:** `pantheon-systems/terminus-autopilot-plugin`
**Owner:** `@pantheon-systems/developer-experience`, `@pantheon-systems/otto`
**Terminus:** 3.x, 4.x
**Purpose:** Manage Pantheon Autopilot from the command line.

```bash
terminus self:plugin:install pantheon-systems/terminus-autopilot-plugin
```

Provides commands to trigger, configure, and inspect Autopilot runs for sites that have it enabled.

---

### [terminus-build-tools-plugin](https://github.com/pantheon-systems/terminus-build-tools-plugin)
**Package:** `pantheon-systems/terminus-build-tools-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 3.x (4.x not yet declared)
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

### [terminus-composer-logs-plugin](https://github.com/pantheon-systems/terminus-composer-logs-plugin)
**Package:** `pantheon-systems/terminus-composer-logs-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 3.x (4.x not yet declared)
**Purpose:** View Composer operation logs for Pantheon site environments.

```bash
terminus self:plugin:install pantheon-systems/terminus-composer-logs-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `composer:logs <site>.<env>` | Show Composer logs for the latest commit |
| `composer:logs <site>.<env> --commit=<sha>` | Show logs for a specific commit |
| `composer:logs:upstream-update <site>.<env>` | Show Composer logs from the last upstream update |

---

### [terminus-composer-plugin](https://github.com/pantheon-systems/terminus-composer-plugin)
**Package:** `pantheon-systems/terminus-composer-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 3.x, 4.x
**Purpose:** Execute Composer operations on Pantheon environments directly via Terminus.

```bash
terminus self:plugin:install pantheon-systems/terminus-composer-plugin
```

Adds `composer` commands that run Composer on the remote environment.

---

### [terminus-conversion-tools-plugin](https://github.com/pantheon-systems/terminus-conversion-tools-plugin)
**Package:** `pantheon-systems/terminus-conversion-tools-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 3.x (4.x not yet declared)
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

### [terminus-decoupled-kit-plugin](https://github.com/pantheon-systems/terminus-decoupled-kit-plugin)
**Package:** `pantheon-systems/terminus-decoupled-kit-plugin`
**Owner:** `@pantheon-systems/site-experience`, `@pantheon-systems/decoupled-kit-administrators`
**Terminus:** 1.x, 2.x, 3.x (4.x not yet declared)
**Purpose:** Create decoupled (headless) CMS sites on Pantheon with a paired front-end codebase.

```bash
terminus self:plugin:install pantheon-systems/terminus-decoupled-kit-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `decoupled-kit:create <site-name> <label> [<upstream-id>]` | Create a CMS backend site and front-end codebase |

Options: `--org=<org>`, `--region=<region>`, `--cms=drupal\|wordpress`, `--install-cms=true\|false`

Note: The front-end codebase is scaffolded locally but not deployed automatically.

---

### [terminus-gcdn-plugin](https://github.com/pantheon-systems/terminus-gcdn-plugin)
**Package:** `pantheon-systems/terminus-gcdn-plugin`
**Owner:** `@pantheon-systems/platform-edge-routing`
**Terminus:** 3.x, 4.x
**Purpose:** Upgrade sites to Pantheon's Global CDN and verify DNS configuration for custom domains.

```bash
terminus self:plugin:install pantheon-systems/terminus-gcdn-plugin
```

**Commands:**

| Command | Description |
|---|---|
| `gcdn:upgrade <site>` | Upgrade a site to Global CDN |
| `gcdn:dns <site>.live` | Show DNS records required for custom domains |
| `gcdn:verify <site>.live <domain>` | Verify that a domain is correctly pointed to GCDN |

---

### [terminus-mass-update](https://github.com/pantheon-systems/terminus-mass-update)
**Package:** `pantheon-systems/terminus-mass-update`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 1.x, 2.x, 3.x, 4.x
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

### [terminus-quicksilver-plugin](https://github.com/pantheon-systems/terminus-quicksilver-plugin)
**Package:** `pantheon-systems/terminus-quicksilver-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 1.x, 2.x, 3.x, 4.x
**Purpose:** Deploy Quicksilver webhooks and scripts from the official example collection.

```bash
terminus self:plugin:install pantheon-systems/terminus-quicksilver-plugin
```

---

### [terminus-rsync-plugin](https://github.com/pantheon-systems/terminus-rsync-plugin)
**Package:** `pantheon-systems/terminus-rsync-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 3.x, 4.x
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

### [terminus-scheduled-jobs-plugin](https://github.com/pantheon-systems/terminus-scheduled-jobs-plugin)
**Package:** `pantheon-systems/terminus-scheduled-jobs-plugin`
**Owner:** `@pantheon-systems/pie`
**Terminus:** 3.x (4.x not yet declared)
**Purpose:** Create and manage scheduled cron jobs on Pantheon environments. Feature is in private beta — must be enabled per site on request.

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

### [terminus-site-clone-plugin](https://github.com/pantheon-systems/terminus-site-clone-plugin)
**Package:** `pantheon-systems/terminus-site-clone-plugin`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 2.x, 3.x, 4.x
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

### [terminus-site-debug](https://github.com/pantheon-systems/terminus-site-debug)
**Package:** `pantheon-systems/terminus-site-debug`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 1.x, 2.x, 3.x, 4.x
**Purpose:** Download and parse Pantheon site logs (nginx, PHP errors) and display New Relic summaries. Not supported on Windows.

```bash
terminus self:plugin:install pantheon-systems/terminus-site-debug
```

**Commands:**

| Command | Description |
|---|---|
| `logs:get <site>.<env>` | Download all logs |
| `logs:get <site>.<env> --nginx-access --nginx-error` | Download only nginx logs |
| `logs:parse:nginx-access <site>.<env> --grouped-by=<type>` | Parse nginx access logs; group by: `ip`, `response-code`, `403`, `404`, `php-404`, `502`, `request-per-second`, `request-method` |
| `logs:parse:nginx-error <site>.<env> --grouped-by=<string>` | Parse nginx error logs |
| `logs:parse:php-error <site>.<env> --grouped-by=latest` | Parse PHP error logs |

---

### [terminus_debugging_tools](https://github.com/pantheon-systems/terminus_debugging_tools)
**Package:** `pantheon-systems/terminus-debugging-tools`
**Owner:** `@pantheon-systems/developer-experience`
**Terminus:** 2.x (3.x/4.x not declared — verify before installing)
**Purpose:** Database debugging — inspect blob columns and run table analysis on Pantheon site databases.

```bash
terminus self:plugin:install pantheon-systems/terminus-debugging-tools
```

**Commands:**

| Command | Description |
|---|---|
| `blob:columns <site>.<env>` | List columns containing blob data |
| `blob:cells <site>.<env> <table> <column>` | Inspect blob cell contents |
| `analyze-table:run <site>.<env> <table>` | Run ANALYZE TABLE on one or more tables (comma-separated or `all`) |

---

## Community Plugins

Plugins without an assigned Pantheon team. Includes plugins in the `pantheon-systems` org with no CODEOWNERS and all plugins from the `terminus-plugin-project` org.

---

### [terminus-carbon-plugin](https://github.com/pantheon-systems/terminus-carbon-plugin)
**Package:** `pantheon-systems/terminus-carbon-plugin`
**Terminus:** 2.x, 3.x (4.x not declared)
**Purpose:** Retrieve carbon impact and sustainability metrics for Pantheon sites. Listed in the Pantheon plugin directory but has no CODEOWNERS file or OSS support badge.

```bash
terminus self:plugin:install pantheon-systems/terminus-carbon-plugin
```

---

### [terminus-autocomplete-plugin](https://github.com/terminus-plugin-project/terminus-autocomplete-plugin)
**Package:** `terminus-plugin-project/terminus-autocomplete-plugin`
**Terminus:** 2.x, 3.x, 4.x
**Purpose:** Tab completion for Terminus commands in bash/zsh.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-autocomplete-plugin
```

---

### [terminus-backup-all-plugin](https://github.com/terminus-plugin-project/terminus-backup-all-plugin)
**Package:** `terminus-plugin-project/terminus-backup-all-plugin`
**Terminus:** 2.x (3.x/4.x not declared)
**Purpose:** Create backups across all accessible Pantheon sites with a single command.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-backup-all-plugin
```

---

### [terminus-code-plugin](https://github.com/terminus-plugin-project/terminus-code-plugin)
**Package:** `terminus-plugin-project/terminus-code-plugin`
**Terminus:** 2.x (3.x/4.x not declared)
**Purpose:** Clone site code from any Pantheon environment to your local system.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-code-plugin
```

---

### [terminus-domain-challenge](https://github.com/terminus-plugin-project/terminus-domain-challenge)
**Package:** `terminus-plugin-project/terminus-domain-challenge`
**Terminus:** 1.x, 2.x, 3.x (4.x not declared)
**Purpose:** Retrieve domain ACME challenge records to automate DNS validation.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-domain-challenge
```

---

### [terminus-filer-plugin](https://github.com/terminus-plugin-project/terminus-filer-plugin)
**Package:** `terminus-plugin-project/terminus-filer-plugin`
**Terminus:** 2.x, 3.x (4.x not declared)
**Purpose:** Open SFTP connections to Pantheon sites in a desktop SFTP client.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-filer-plugin
```

---

### [terminus-pancakes-plugin](https://github.com/terminus-plugin-project/terminus-pancakes-plugin)
**Package:** `terminus-plugin-project/terminus-pancakes-plugin`
**Terminus:** 1.x, 2.x, 3.x, 4.x
**Purpose:** Open site databases directly in a local SQL client (Sequel Ace, TablePlus, etc.).

```bash
terminus self:plugin:install terminus-plugin-project/terminus-pancakes-plugin
```

---

### [terminus-replica-plugin](https://github.com/terminus-plugin-project/terminus-replica-plugin)
**Package:** `terminus-plugin-project/terminus-replica-plugin`
**Terminus:** 2.x (3.x/4.x not declared)
**Purpose:** Expose database replica connection details for Pantheon sites.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-replica-plugin
```

---

### [terminus-site-mount-plugin](https://github.com/terminus-plugin-project/terminus-site-mount-plugin)
**Package:** `terminus-plugin-project/terminus-site-mount-plugin`
**Terminus:** 2.x (3.x/4.x not declared)
**Purpose:** Mount Pantheon site filesystems locally.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-site-mount-plugin
```

---

### [terminus-site-status-plugin](https://github.com/terminus-plugin-project/terminus-site-status-plugin)
**Package:** `terminus-plugin-project/terminus-site-status-plugin`
**Terminus:** 2.x, 3.x (4.x not declared)
**Purpose:** Display status of all environments across Pantheon sites in a single view.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-site-status-plugin
```

---

### [terminus-upstream-deployment-plugin](https://github.com/terminus-plugin-project/terminus-upstream-deployment-plugin)
**Package:** `terminus-plugin-project/terminus-upstream-deployment-plugin`
**Terminus:** 1.x (2.x/3.x/4.x not declared)
**Purpose:** Automates upstream updates with a pre-update backup. Safer alternative to `site:mass-update:apply` for individual sites.

```bash
terminus self:plugin:install terminus-plugin-project/terminus-upstream-deployment-plugin
```

---

## Archived Plugins

These plugins are archived and should not be installed. Documented here so questions about them and their former commands can be answered.

| Plugin | Purpose | Last active | Notes |
|---|---|---|---|
| [`terminus-acme-plugin`](https://github.com/pantheon-systems/terminus-acme-plugin) | ACME certificate challenge management | 2024-06 | Archived |
| [`terminus-aliases-plugin`](https://github.com/pantheon-systems/terminus-aliases-plugin) | Drush aliases file generation | 2020-06 | Built into Terminus 4.x as `aliases` command |
| [`terminus-clu-plugin`](https://github.com/pantheon-systems/terminus-clu-plugin) | Open Composer dependency update PRs | 2024-10 | Archived |
| [`terminus-drupal-console-plugin`](https://github.com/pantheon-systems/terminus-drupal-console-plugin) | Run Drupal Console commands remotely | 2023-01 | Archived; Drupal Console itself is deprecated |
| [`terminus-newrelic-data-plugin`](https://github.com/pantheon-systems/terminus-newrelic-data-plugin) | New Relic performance metrics | 2025-03 | Archived |
| [`terminus-node-logs-plugin`](https://github.com/pantheon-systems/terminus-node-logs-plugin) | Node.js log access | 2024 | Built into Terminus 4.2+ as `node:logs:*` commands |
| [`terminus-power-tools`](https://github.com/pantheon-systems/terminus-power-tools) | Build Tools extensions for decoupled projects | 2022-06 | Deprecated |
| [`terminus-repository-plugin`](https://github.com/pantheon-systems/terminus-repository-plugin) | GitHub/VCS integration | 2024 | Built into Terminus 4.2+ as `vcs:*` commands |
| [`terminus-retry`](https://github.com/pantheon-systems/terminus-retry) | Retry failed `remote:wp` and `remote:drush` commands | 2024-12 | Archived |
| [`terminus-secrets-manager-plugin`](https://github.com/pantheon-systems/terminus-secrets-manager-plugin) | Secrets Manager API integration | 2024 | Built into Terminus 4.2+ as `secret:site:*` and `secret:org:*` |
| [`terminus-secrets-plugin`](https://github.com/pantheon-systems/terminus-secrets-plugin) | Legacy `secrets.json` file management | 2025-05 | Archived; use built-in `secret:site:*` commands |
| [`terminus-yml-validator-plugin`](https://github.com/pantheon-systems/terminus-yml-validator-plugin) | `sites.yml` validation for WPMS | 2023-04 | Archived; use `sites-yml-validator` directly |

---

## Pantheon-Internal Plugins

These plugins exist in the `pantheon-systems` org but are for internal Pantheon use only. Not publicly installable.

| Plugin | Purpose |
|---|---|
| [`terminus-addons-installer-plugin`](https://github.com/pantheon-systems/terminus-addons-installer-plugin) | Trigger platform workflows to configure themes/plugins. Commands: `addons-install:list`, `addons-install:run <job>` |
| [`terminus-admin-plugin`](https://github.com/pantheon-systems/terminus-admin-plugin) | Admin-level operations for Pantheon employees. Requires `TERMINUS_HOST_CERT` env var. Commands: `session`, `site:thaw`, `org:site:add` |
| [`terminus-vulnerability-monitor-plugin`](https://github.com/pantheon-systems/terminus-vulnerability-monitor-plugin) | Interact with the Pantheon vulnerability monitoring service. Commands: `site-data:info`, `site-data:plugins`, `site-data:themes`, `site-data:cms`, `site-data:index` |

---

## Discovering More Plugins

```bash
terminus self:plugin:search <keyword>    # search Packagist for terminus plugins
```

Terminus plugins on Packagist have `"type": "terminus-plugin"` in their `composer.json`. See also:
- [Pantheon plugin directory](https://docs.pantheon.io/terminus/directory) — curated list
- [pantheon-systems org](https://github.com/orgs/pantheon-systems/repositories?q=terminus-) — all repos matching `terminus-`
- [terminus-plugin-project org](https://github.com/terminus-plugin-project) — community plugins
