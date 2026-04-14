# Terminus Scripting Patterns

## Core scripting principles

- Use `--format=list` to get newline-delimited output for iteration
- Use `--field=<name>` to extract a single column value as a string
- Use `-y` / `--yes` to skip confirmation prompts
- Use `-n` / `--no-interaction` to suppress all interactive prompts
- Use `--quiet` to suppress all non-error output

## Extracting single values

```bash
# Get a single field value as a plain string
terminus site:info mysite --field=id             # site UUID
terminus env:info mysite.live --field=php_version
terminus site:info mysite --field=frozen         # "true" or "false"
```

## Iterating over sites in an organization

```bash
export ORG_UUID="your-org-uuid-here"

# Get list of site names
SITES=$(terminus org:site:list "$ORG_UUID" --format=list --field=Name 2>/dev/null)

for SITE in $SITES; do
    # Skip frozen sites
    IS_FROZEN=$(terminus site:info "$SITE" --field=frozen 2>/dev/null)
    if [ "$IS_FROZEN" = "true" ]; then
        echo "Skipping frozen site: $SITE"
        continue
    fi

    echo "Processing: $SITE"
    terminus backup:create "${SITE}.live" --element=database
done
```

## Iterating over multidevs

```bash
MULTIDEVS=$(terminus multidev:list mysite --format=list --field=Name 2>/dev/null)

for MULTIDEV in $MULTIDEVS; do
    echo "Clearing cache on: $MULTIDEV"
    terminus env:clear-cache "mysite.${MULTIDEV}"
done
```

## Applying upstream updates across all org sites

```bash
# Dry run first (mass-update plugin required)
terminus site:list --org="$ORG_UUID" --format=list \
  | terminus site:mass-update:apply --accept-upstream --updatedb --dry-run

# Apply for real
terminus site:list --org="$ORG_UUID" --format=list \
  | terminus site:mass-update:apply --accept-upstream --updatedb
```

## Auditing PHP versions across an org

```bash
export ORG_UUID="your-org-uuid-here"
SITES=$(terminus org:site:list "$ORG_UUID" --format=list --field=Name 2>/dev/null)

echo "site,php_version" > php-audit.csv
for SITE in $SITES; do
    PHP_VERSION=$(terminus env:info "${SITE}.live" --field=php_version 2>/dev/null)
    echo "${SITE},${PHP_VERSION}" >> php-audit.csv
done
```

## Waiting for a workflow to complete

```bash
terminus env:deploy mysite.test --note="Deploy" -y
terminus workflow:wait mysite.test --max=300     # wait up to 5 minutes
```

## Authentication in CI/CD

### GitHub Actions

```yaml
- name: Authenticate Terminus
  env:
    TERMINUS_TOKEN: ${{ secrets.TERMINUS_TOKEN }}
  run: terminus auth:login --machine-token="$TERMINUS_TOKEN"

# Optional: cache the session between jobs
- uses: actions/cache@v4
  with:
    path: ~/.terminus/cache
    key: terminus-${{ runner.os }}
```

### CircleCI

```yaml
- run:
    name: Authenticate Terminus
    command: terminus auth:login --machine-token="${TERMINUS_TOKEN}"
```

### GitLab CI

```yaml
variables:
  TERMINUS_CACHE_DIR: /tmp/terminus-cache

before_script:
  - terminus auth:login --machine-token="${TERMINUS_TOKEN}"

cache:
  paths:
    - /tmp/terminus-cache
```

### Bitbucket Pipelines

```yaml
script:
  - terminus auth:login --machine-token="${TERMINUS_TOKEN}"
```

## Deploying from CI

```bash
# Full deploy pipeline: Dev → Test → Live
terminus env:deploy mysite.test --note="Deploy from CI build ${BUILD_NUMBER}" --cc --updatedb -y
terminus workflow:wait mysite.test --max=300

terminus env:deploy mysite.live --note="Deploy from CI build ${BUILD_NUMBER}" --cc --updatedb -y
terminus workflow:wait mysite.live --max=300
```

## Creating a backup before a risky operation

```bash
terminus backup:create mysite.live --element=database
terminus workflow:wait mysite.live --max=180

# Proceed with risky operation...
terminus env:clone-content mysite.live mysite.dev -y
```

## Checking upstream update status in CI

```bash
STATUS=$(terminus upstream:updates:status mysite.dev 2>/dev/null)
if [ "$STATUS" = "outdated" ]; then
    terminus upstream:updates:apply mysite.dev --updatedb --accept-upstream -y
fi
```

## Output format reference

| Format | Use case |
|---|---|
| `--format=table` | Human-readable (default) |
| `--format=list` | Newline-delimited, ideal for `for` loops and piping |
| `--format=json` | Machine-readable, use with `jq` |
| `--format=csv` | Spreadsheet import, reporting |
| `--format=string` | Single value (same as `--field` for single-field output) |

```bash
# Use jq with JSON output
terminus site:list --format=json | jq '.[].name'

# Get one field directly
terminus site:info mysite --field=id
```
