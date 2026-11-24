# Changelog

## 1.1.0 - 2026-11-24

### Changed
- Installation is now marketplace-only (`claude plugin marketplace add` + `claude plugin install`). The skill moved to `skills/terminus/` so the plugin system loads it, and the marketplace entry uses `"source": "./"`
- Existing installs made with `install.sh` must remove `~/.claude/skills/terminus/` (see README)
- The skill detects a leftover `~/.claude/skills/terminus/` from the old installer and offers to remove it (never the copy it is running from, and not if it has local changes)

### Removed
- `install.sh` and its git-clone based install and update path

## 1.0.1 - 2026-11-24

### Added
- "Creating a site" section in `SKILL.md`: post-`site:create` steps for WordPress, Drupal and Next.js, including setting `env`/`web` secrets before the first Next.js build
- "Looking up site and environment details" section in `SKILL.md` (PHP version, object cache, search state, organization)
- `gcdn:bot-bypass` in the plugin reference
- Guidance on not filtering output (`head`, `tail`, `grep -v`) when checking command success
- Backup verification step in the safety checklist

### Changed
- `auth:login --email` reuses the saved machine token instead of prompting; check `~/.terminus/cache/tokens/` before asking for one
- Session duration note and re-checking `auth:whoami` after long pauses
- Ground rule 2: `help` and `list` don't flag deprecated commands, so also check `references/commands.md`
- `site:info`, `site:list`, `redis`, `search:enable` and `solr` entries in the command reference corrected (real fields, deprecated flags, no `redis:info`, Elasticsearch default on WordPress)

## 1.0.0

### Added
- Initial skill release
- Complete command reference for Terminus 4.x core (170+ commands across 30+ namespaces)
- Plugin directory covering official Pantheon plugins and community plugins
- Environment variables and `~/.terminus/config.yml` configuration reference
- Bash scripting patterns and CI/CD integration examples (GitHub Actions, CircleCI, GitLab, Bitbucket)
- Safety reference with destructive command checklist
- Terminus API direct-access guidance with correct endpoint (`terminus.pantheon.io`)
- `CLAUDE.md` with authoring context and maintenance instructions
