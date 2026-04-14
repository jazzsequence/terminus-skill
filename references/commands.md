# Terminus Command Reference

Complete reference for all Terminus 4.x core commands. Commands are organized by namespace.

**Command format:** `terminus <namespace>:<action> [<site>.<env>] [options]`

Use `terminus help <command>` for full options on any command. Use `terminus list` to see all commands including those added by plugins.

---

## auth

| Command | Description |
|---|---|
| `auth:login` | Authenticate. Options: `--machine-token=<token>`, `--email=<email>` |
| `auth:logout` | Log out and clear the cached session |
| `auth:whoami` | Display information about the currently authenticated user |

---

## backup

| Command | Description |
|---|---|
| `backup:create <site>.<env>` | Create a backup. `--element=all\|code\|files\|database\|db`, `--keep-for=<days>` |
| `backup:get <site>.<env>` | Get download URL or download a backup. `--element=code\|files\|database\|db`, `--file=<filename>`, `--to=<local-path>` |
| `backup:info <site>.<env>` | Display info about a specific or latest backup. `--element=`, `--file=` |
| `backup:list <site>.<env>` | List backups for an environment. `--element=all\|code\|files\|database\|db` |
| `backup:restore <site>.<env>` | Restore a backup. `--element=code\|files\|database\|db`, `--file=<filename>` |
| `backup:automatic:enable <site>.<env>` | Enable automatic daily/weekly backups. `--day=<day>`, `--keep-for=<days>` |
| `backup:automatic:disable <site>.<env>` | Disable automatic backups |
| `backup:automatic:info <site>.<env>` | Show automatic backup schedule |

---

## branch

| Command | Description |
|---|---|
| `branch:list <site>` | List git branches for a site |

---

## connection

| Command | Description |
|---|---|
| `connection:info <site>.<env>` | Display connection info (Git, SFTP, MySQL, Redis) |
| `connection:set <site>.<env> <mode>` | Set connection mode. `<mode>`: `git` or `sftp` |

---

## dashboard

| Command | Description |
|---|---|
| `dashboard:view <site>.<env>` | Open the Pantheon Dashboard in a browser. `--print` to print URL only |

---

## domain

| Command | Description |
|---|---|
| `domain:add <site>.<env> <domain>` | Add a domain to an environment |
| `domain:dns <site>.<env>` | Display recommended DNS settings |
| `domain:list <site>.<env>` | List domains for an environment |
| `domain:lookup <domain>` | Find which site/env a domain is attached to |
| `domain:remove <site>.<env> <domain>` | Remove a domain from an environment |
| `domain:verify <site>.<env> <domain>` | Verify domain ownership |
| `domain:primary:add <site>.<env> <domain>` | Set a domain as primary (redirects all traffic) |
| `domain:primary:remove <site>.<env>` | Remove primary domain designation |

---

## env

| Command | Description |
|---|---|
| `env:clear-cache <site>.<env>` | Clear caches for the environment |
| `env:clone-content <site>.<from-env> <site>.<to-env>` | Clone DB/files between environments. `--db-only`, `--files-only`, `--cc`, `--updatedb` |
| `env:code-log <site>.<env>` | Display commit log for an environment |
| `env:code-rebuild <site>.<env>` | Move code to runtime and retrigger Composer build |
| `env:commit <site>.<env>` | Commit SFTP-mode changes. `--message=<msg>`, `--force` |
| `env:deploy <site>.<env>` | Deploy code to Test or Live. `--note=<msg>`, `--cc`, `--updatedb`, `--sync-content` (Test only) |
| `env:diffstat <site>.<env>` | Show diff of uncommitted changes (SFTP mode) |
| `env:info <site>.<env>` | Display environment status and configuration |
| `env:list <site>` | List all environments for a site |
| `env:metrics <site>.<env>` | Display traffic metrics. `--period=month\|week\|day`, `--datapoints=<n>` |
| `env:rotate-random-seed <site>.<env>` | Rotate the environment's random seed |
| `env:view <site>.<env>` | Open the environment URL in a browser. `--print` to print URL |
| `env:wake <site>.<env>` | Wake a sleeping environment. `--retry=<n>`, `--delay=<seconds>` |
| `env:wipe <site>.<env>` | **DESTRUCTIVE** — Delete all files and database content |

---

## https

| Command | Description |
|---|---|
| `https:info <site>.<env>` | Display HTTPS/SSL configuration |
| `https:set <site>.<env> <cert> <key>` | Enable HTTPS with a custom certificate. `--intermediate-certificate=<cert>` |
| `https:remove <site>.<env>` | Disable HTTPS and remove the certificate |

---

## import

| Command | Description |
|---|---|
| `import:complete <site>` | Finalize the Pantheon import process |
| `import:database <site>.<env> <url>` | Import a database from a publicly accessible archive URL. Alias: `import:db` |
| `import:files <site>.<env> <url>` | Import files from a publicly accessible archive URL |
| `import:site <site-name> <url>` | Import a full site archive (code, database, files) from a URL |

---

## local

| Command | Description |
|---|---|
| `local:clone <site>` | Clone site code to `$HOME/pantheon-local-copies`. `--site_dir=<dir>`, `--override`, `--branch=<branch>` |
| `local:commitAndPush <site>` | Commit and push local changes to the remote |
| `local:dockerize <site>` | Create backup, download, and generate Docker setup. `--overwrite` |
| `local:getLiveDB <site>` | Download a fresh backup of the Live database. `--overwrite` |
| `local:getLiveFiles <site>` | Download a fresh backup of Live files. `--overwrite` |

---

## lock

| Command | Description |
|---|---|
| `lock:enable <site>.<env> <username> <password>` | Enable HTTP basic authentication |
| `lock:disable <site>.<env>` | Disable HTTP basic authentication |
| `lock:info <site>.<env>` | Display lock status |

---

## machine-token

| Command | Description |
|---|---|
| `machine-token:list` | List machine tokens for the current user |
| `machine-token:delete <machine-token-id>` | Delete a specific machine token |
| `machine-token:delete-all` | Delete all stored machine tokens and log out |

---

## multidev

| Command | Description |
|---|---|
| `multidev:create <site>.<env> <multidev-name>` | Create a multidev from an environment. `--no-db`, `--no-files` |
| `multidev:delete <site>.<multidev-name>` | Delete a multidev environment. `--delete-branch` to also delete the git branch |
| `multidev:list <site>` | List all multidev environments for a site |
| `multidev:merge-from-dev <site>.<multidev-name>` | Merge Dev commits into a multidev. `--updatedb` |
| `multidev:merge-to-dev <site>.<multidev-name>` | Merge multidev commits into Dev. `--updatedb` |

---

## new-relic

| Command | Description |
|---|---|
| `new-relic:info <site>` | Display New Relic configuration |
| `new-relic:enable <site>` | Enable New Relic |
| `new-relic:disable <site>` | Disable New Relic |

---

## node (Node.js sites)

| Command | Description |
|---|---|
| `node:builds:list <site>.<env>` | List builds and deployment status. `--status=<status>`, `--branch=<branch>`, `--limit=<n>` |
| `node:builds:rebuild <site>.<env>` | Trigger a rebuild. `--commit=<sha>` to rebuild from a specific commit |
| `node:builds:rollback <site>.<env> <build-id>` | Roll back a deployed build |
| `node:builds:wait <site>.<env>` | Wait for a build/deployment to complete. `--commit=<sha>`, `--max=<seconds>` |
| `node:logs:build:get <site>.<env> <build-id>` | Print the build log |
| `node:logs:runtime:get <site>.<env>` | Print runtime logs (last 24 hours). `--log-name=<name>`, `--severity=<level>`, `--exclude-requests` |

---

## org

| Command | Description |
|---|---|
| `org:info <org>` | Display information about an organization |
| `org:list` | List all organizations you belong to |
| `org:people:add <org> <email> <role>` | Add a user. `<role>`: `admin`, `team_member`, `developer`, `unprivileged` |
| `org:people:list <org>` | List organization members |
| `org:people:remove <org> <member>` | Remove a member (UUID, email, or name) |
| `org:people:role <org> <member> <role>` | Change a member's role |
| `org:site:list <org>` | List sites in an organization |
| `org:site:remove <org> <site>` | Remove a site from an organization |
| `org:upstream:list <org>` | List upstreams available to the organization |

---

## owner

| Command | Description |
|---|---|
| `owner:set <site> <owner>` | Transfer site ownership (UUID, email, or name) |

---

## payment-method

| Command | Description |
|---|---|
| `payment-method:list` | List payment methods for the current user |
| `payment-method:add <site> <payment-method>` | Associate a payment method with a site |
| `payment-method:remove <site>` | Remove the active payment method from a site |

---

## plan

| Command | Description |
|---|---|
| `plan:list <site>` | List available plans for a site |
| `plan:info <site>` | Display the current plan |
| `plan:set <site> <plan-sku>` | Change the site plan (get SKU from `plan:list`) |

---

## redis

| Command | Description |
|---|---|
| `redis:enable <site>` | Enable Redis add-on |
| `redis:disable <site>` | Disable Redis add-on |

---

## remote

| Command | Description |
|---|---|
| `remote:drush <site>.<env> -- <drush-command>` | Run Drush remotely. `--progress`, `--retry=<n>` |
| `remote:wp <site>.<env> -- <wp-cli-command>` | Run WP-CLI remotely. `--progress`, `--retry=<n>` |

The `--` separator is required. SSH key must be configured on the account.

---

## search

| Command | Description |
|---|---|
| `search:enable <site>` | Enable search indexing. `--flavor=solr\|elasticsearch` |
| `search:disable <site>` | Disable search indexing. `--flavor=solr\|elasticsearch` |

---

## secret

| Command | Description |
|---|---|
| `secret:site:list <site>` | List secrets for a site. `--debug` |
| `secret:site:set <site> <name> <value>` | Set a secret. `--type=<type>`, `--scope=web,ic`, `--debug` |
| `secret:site:delete <site> <name>` | Delete a site secret. `--debug` |
| `secret:org:list <org>` | List secrets for an organization |
| `secret:org:set <org> <name> <value>` | Set an org secret. `--type=<type>`, `--scope=<scope>`, `--env=<env>` |
| `secret:org:delete <org> <name>` | Delete an org secret. `--env=<env>` |

---

## self

| Command | Description |
|---|---|
| `self:clear-cache` | Clear Terminus's local command cache |
| `self:config:dump` | Display current Terminus configuration |
| `self:console` | Open an interactive PHP console |
| `self:info` | Display PHP and Terminus environment details |
| `self:plugin:create <name>` | Scaffold a new plugin. `--project-name=<vendor/name>` |
| `self:plugin:install <vendor/package>` | Install a plugin from Packagist |
| `self:plugin:list` | List installed plugins |
| `self:plugin:migrate` | Migrate Terminus 2 plugins to Terminus 3+ |
| `self:plugin:reload` | Reload plugins |
| `self:plugin:search <keyword>` | Search for plugins on Packagist |
| `self:plugin:uninstall <plugin-name>` | Uninstall a plugin |
| `self:plugin:update <plugin-name>` | Update a plugin |

---

## site

| Command | Description |
|---|---|
| `site:create <name> <label> <upstream-id>` | Create a new site. `--org=<org>`, `--region=us\|eu\|au\|ca`, `--vcs-provider=<provider>`, `--vcs-org=<org>`, `--visibility=public\|private`, `--create-repo`, `--repository-name=<name>`, `--skip-clone-repo` |
| `site:delete <site>` | **DESTRUCTIVE** — Permanently delete a site from Pantheon |
| `site:info <site>` | Display site information |
| `site:label:set <site> <label>` | Change the site label |
| `site:list` | List all accessible sites. `--name=<filter>`, `--org=<org>`, `--owner=<owner>`, `--plan=<plan>`, `--team`, `--upstream=<upstream-id>` |
| `site:lookup <site>` | Get the UUID for a site by name |
| `site:org:add <site> <org>` | Add the site to an organization |
| `site:org:list <site>` | List organizations the site belongs to |
| `site:org:remove <site> <org>` | Remove the site from an organization |
| `site:team:add <site> <member> <role>` | Add a team member |
| `site:team:list <site>` | List team members |
| `site:team:remove <site> <member>` | Remove a team member |
| `site:team:role <site> <member> <role>` | Change a team member's role |
| `site:upstream:clear-cache <site>` | Clear the upstream cache for a site |
| `site:upstream:set <site> <upstream-id>` | Change the site's upstream |
| `site:pause-builds <site>` | Pause builds (experimental) |
| `site:resume-builds <site>` | Resume builds (experimental) |

---

## solr (deprecated)

These commands are deprecated in favor of `search:enable/disable --flavor=solr`.

| Command | Description |
|---|---|
| `solr:enable <site>` | Enable Solr (use `search:enable --flavor=solr` instead) |
| `solr:disable <site>` | Disable Solr (use `search:disable --flavor=solr` instead) |

---

## ssh-key

| Command | Description |
|---|---|
| `ssh-key:list` | List SSH keys for the current user |
| `ssh-key:add <file>` | Add an SSH public key (path to `.pub` file) |
| `ssh-key:remove <ssh-key-id>` | Remove an SSH key |

---

## tag

| Command | Description |
|---|---|
| `tag:list <site> <org>` | List tags for a site within an org |
| `tag:add <site> <org> <tag>` | Add a tag |
| `tag:remove <site> <org> <tag>` | Remove a tag |

---

## upstream

| Command | Description |
|---|---|
| `upstream:info <upstream>` | Display upstream information |
| `upstream:list` | List accessible upstreams. `--all`, `--framework=drupal\|wordpress`, `--name=<filter>`, `--org=<org>` |
| `upstream:updates:apply <site>.<env>` | Apply pending upstream updates. `--updatedb`, `--accept-upstream` |
| `upstream:updates:list <site>.<env>` | List available upstream updates |
| `upstream:updates:status <site>.<env>` | Check if updates are available (`current` or `outdated`) |

---

## vcs

| Command | Description |
|---|---|
| `vcs:connection:list` | List connected VCS (GitHub) installations |
| `vcs:connection:add` | Register a GitHub App installation |
| `vcs:connection:link` | Link a VCS org to a Pantheon org. `--vcs-org=<org>`, `--source-org=<org>` |

---

## workflow

| Command | Description |
|---|---|
| `workflow:list <site>` | List workflows for a site. `--all` |
| `workflow:wait <site>.<env>` | Wait for a workflow to complete. `--start=<epoch>`, `--commit=<sha>`, `--max=<seconds>` |
| `workflow:watch <site>` | Stream workflow updates to console. `--checks=<n>` |

---

## Top-level commands

| Command | Description |
|---|---|
| `aliases` | Generate Drush aliases for Pantheon sites. `--print`, `--location=<path>`, `--all`, `--only=<filter>`, `--type=<type>`, `--base=<base>`, `--target=<target>`, `--db-url` |
| `art` | Display Pantheon ASCII art |
