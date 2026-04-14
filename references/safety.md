# Terminus Safety Rules

Use this file before running any command that modifies, deletes, or overwrites data.

## Golden rules

- Always verify `<site>.<env>` targets before executing — confirm with the user if there is any ambiguity.
- Never run destructive commands against Live without an explicit backup or user confirmation.
- Prefer `--dry-run` where available (e.g., `site:mass-update:apply --dry-run`).
- Prefer creating a backup before any operation that replaces database or files content.
- When writing scripts that iterate over sites, skip frozen sites.

## High-risk commands (require explicit user confirmation)

| Command | Risk |
|---|---|
| `env:wipe <site>.<env>` | Deletes all files and database content — cannot be undone |
| `site:delete <site>` | Permanently deletes the site from Pantheon — cannot be undone |
| `backup:restore <site>.<env>` | Overwrites current DB/files with backup — cannot be undone |
| `env:clone-content <src> <dest>` | Overwrites the destination environment's DB and/or files |
| `multidev:delete <site>.<multidev>` | Deletes the multidev environment and optionally the git branch |
| `upstream:updates:apply <site>.<env> --accept-upstream` | May discard local git changes in favor of upstream |

## Before any destructive operation

1. Confirm the exact `<site>.<env>` target with the user.
2. Check if the environment has a recent backup: `terminus backup:list <site>.<env>`
3. If no recent backup, offer to create one: `terminus backup:create <site>.<env>`
4. Present what will happen and ask for confirmation before proceeding.

## Connection mode safety

- `connection:set <site>.<env> sftp` enables SFTP mode, which allows uncommitted changes to accumulate.
- Always switch back to `git` mode after SFTP work: `connection:set <site>.<env> git`
- Committing in SFTP mode (`env:commit`) is permanent — review `env:diffstat` first.

## Environment promotion order

Pantheon's deployment path is strictly: **Dev → Test → Live**

- You can only deploy to Test from Dev, and to Live from Test.
- You cannot deploy directly from Dev to Live.
- Content (DB/files) can be cloned in either direction but is most commonly cloned Live → Dev for local testing.

## Multidev considerations

- Multidev environments are cloned from Dev (or another multidev) at creation time.
- Deleting a multidev with `--delete-branch` also removes the git branch — confirm if the branch has unmerged work.
- Always run `multidev:merge-to-dev` before deleting if the branch has pending changes you want to keep.

## Frozen sites

Frozen sites cannot have code deployed or environments modified. Check before scripting:

```bash
terminus site:info <site> --field=frozen    # returns "true" or "false"
```

Skip frozen sites in bulk scripts.

## Live environment caution

Commands run against `.live` affect the production site immediately. Before running anything against Live:
- Is there a maintenance window?
- Is a backup current?
- Has the change been validated on Test first?
