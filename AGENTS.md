# AGENTS.md

## Cursor Cloud specific instructions

### Overview

**Seed** is a minimalist idea-capture and project management PWA ("Seeds -> Projects -> Reality"). It is a zero-dependency static web app — a single `index.html` file with inline React/JSX, Tailwind CSS, and Supabase, all loaded from CDNs. There is no build step, no package manager, and no `node_modules`.

### Running the dev server

Serve the static files with any HTTP server on port 3000:

```
serve -l 3000 .
```

Then open `http://localhost:3000/` in Chrome. The app works immediately in guest/localStorage mode without any backend credentials.

### Key caveats

- **No linting, testing, or build commands exist.** There is no `package.json`, no ESLint config, and no test framework. Validation is purely manual via the browser.
- **All JS/CSS dependencies are loaded from CDNs at runtime** (React 18, Babel Standalone, Tailwind CSS, Supabase JS). Internet access is required on first load; the service worker caches assets for subsequent offline use.
- **Supabase credentials are hardcoded** in `index.html` (lines 52-53). Without a reachable Supabase instance, the app still functions in guest mode using localStorage — full auth/sync features require the Supabase backend.
- **The entire application logic lives in `index.html`** (~2175 lines). There are no other source files to edit.
- **PWA icons** (`icon-192.png`, `icon-512.png`) can be regenerated using `generate-icons.html` if needed.
