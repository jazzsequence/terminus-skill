# Terminus API — When and How to Use It Directly

## Two separate APIs

There are two distinct Pantheon API endpoints. This skill concerns the **Terminus API** only.

| API | Endpoint | Purpose |
|---|---|---|
| **Terminus API** | `https://terminus.pantheon.io` | Backend API that Terminus CLI wraps. All Terminus commands call this. |
| **Pantheon API** | `https://api.pantheon.io` | A separate Pantheon platform API. Out of scope for this skill. |

---

## Default: always prefer the Terminus CLI

Every Terminus command is a thin wrapper around the Terminus API (`terminus.pantheon.io`). In almost all cases, using a Terminus command is the correct approach. Calling the Terminus API directly should be a last resort.

Only call the Terminus API directly when **all** of these are true:

1. No Terminus command covers the operation
2. You've confirmed by checking `terminus list` and the full command reference
3. No plugin provides the needed command (`terminus self:plugin:search <keyword>`)

If a plugin solves the problem, install and use it rather than calling the API.

---

## How to discover the correct API endpoint

The best way to identify a Terminus API endpoint is to inspect what Terminus does internally. Run any Terminus command with maximum verbosity:

```bash
terminus <command> <site>.<env> -vvv
```

The `-vvv` output logs the HTTP method, full URI, and (sanitized) request/response. Use this to identify the exact endpoint, method, and body shape before constructing a direct call.

**Never guess API paths** — derive them from Terminus's own debug output.

---

## API base and authentication

```
Base: https://terminus.pantheon.io/api/{path}
Auth: Authorization: Bearer <session-token>
```

The session token is the value stored in `~/.terminus/cache/tokens/` after `terminus auth:login`. It is **not** the machine token — it is the session token exchanged for it.

Sensitive headers Terminus strips from debug output: `machine_token`, `Authorization`, `session`.

---

## Site UUIDs vs. names

The Terminus API uses site UUIDs, not name slugs. Resolve the UUID first:

```bash
terminus site:lookup <site-name>     # returns UUID
terminus site:info <site> --field=id # also returns UUID
```

---

## When direct API access may be appropriate

- Retrieving raw data that Terminus formats or truncates (e.g., deeply nested workflow events)
- Endpoints not yet covered by any Terminus command or available plugin
- Event-driven or webhook-driven automation where spawning the Terminus binary is impractical

Even then, validate the endpoint via `-vvv` before writing any code.

---

## What this skill does not cover

The **Pantheon API** (`api.pantheon.io`) is a separate service with different authentication, endpoints, and use cases. If a task requires the Pantheon API specifically, that is outside the scope of Terminus and this skill.
