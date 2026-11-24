# Terminus Environment Variables and Configuration

## Environment Variables

These environment variables are recognized by Terminus and can be set in shell profiles, CI/CD pipelines, or `.env` files.

| Variable | Purpose | Example |
|---|---|---|
| `TERMINUS_TOKEN` | Machine token for CI/CD authentication | `terminus auth:login --machine-token="${TERMINUS_TOKEN}"` |
| `TERMINUS_SITE` | Default site name — avoids repeating it in scripts | `export TERMINUS_SITE=my-site` |
| `TERMINUS_ENV` | Default environment — avoids repeating it in scripts | `export TERMINUS_ENV=dev` |
| `TERMINUS_HIDE_GIT_MODE_WARNING` | Suppress the "site is in git mode" warning | `true` |
| `TERMINUS_PLUGINS_DIR` | Override the directory where plugins are installed | `~/.terminus/plugins` |
| `TERMINUS_CACHE_DIR` | Override the session token cache directory (useful in CI) | `/tmp/terminus-cache` |
| `TERMINUS_RELEASE` | Used in install scripts to pin a specific version | `3.6.0` |

### Scripting with TERMINUS_SITE / TERMINUS_ENV

When these are set, many commands can omit the `<site>.<env>` argument:

```bash
export TERMINUS_SITE=my-site
export TERMINUS_ENV=live

terminus env:clear-cache           # equivalent to: terminus env:clear-cache my-site.live
terminus backup:create             # equivalent to: terminus backup:create my-site.live
```

---

## Configuration File

Terminus reads defaults from `$HOME/.terminus/config.yml`. Any option normally passed as `--option=value` on the command line can be configured here as a default. Command-line arguments always override configured defaults.

**File location:** `~/.terminus/config.yml`
**Format:** YAML with 2-space indentation

### Example configuration

```yaml
# Suppress the Git mode warning globally
TERMINUS_HIDE_GIT_MODE_WARNING: true

# Set a default email for auth:login
auth:
  login:
    email: you@example.com

# Terminus Pancakes plugin: set default SQL client
pancakes:
  application: tableplus
```

### Common configuration keys

| Key | Effect |
|---|---|
| `TERMINUS_HIDE_GIT_MODE_WARNING: true` | Suppress Git mode warnings globally |
| `auth.login.email` | Pre-fill email for interactive login |
| `command_namespace.command.option` | Set a default for any command option |

To see the current resolved configuration:
```bash
terminus self:config:dump
```

---

## Session Cache

Terminus caches authentication sessions at:
- `~/.terminus/cache/` (default)
- Override with `TERMINUS_CACHE_DIR`

In CI environments, cache this directory between runs to avoid repeated `auth:login` calls and stay within Auth0 rate limits:

```yaml
# GitHub Actions example
- uses: actions/cache@v4
  with:
    path: ~/.terminus/cache
    key: terminus-${{ runner.os }}-${{ hashFiles('**/composer.lock') }}
```

---

## Plugin Installation Path

By default, plugins install into `~/.terminus/plugins/vendor/` via Composer. To use a custom path:

```bash
export TERMINUS_PLUGINS_DIR=/custom/path
terminus self:plugin:install vendor/package
```

To install a plugin from a local directory (development):
```bash
terminus self:plugin:install /path/to/local/plugin
```
