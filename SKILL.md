---
name: nextjs-verify-and-clean-skill
description: |
  Provides strict, comprehensive code review, verification, and cleaning specifically tailored for modern Next.js (App Router, v14/v15) and React architectures.
  Detects and fixes hydration mismatches, Client/Server boundary serialization errors, caching pitfalls, and parallel routing bugs.
  Use when: reviewing pull requests, fixing hydration errors, resolving Next.js build failures, auditing React Server Components (RSC), or establishing Next.js best practices.
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
  - Bash        # To run type-checks, linters, and build commands
  - WebFetch    # To check the latest Next.js/React documentation
  - Browser     # To launch the app and audit the DevTools console for runtime/hydration errors
---

# Next.js & React Code Verification and Cleaning Skill

Transform Next.js codebases by enforcing strict architectural boundaries, eliminating hydration mismatches, and ensuring robust data fetching and routing patterns.

## When to Use This Skill

- **Pre-Merge Audits:** Validating that Server and Client components are correctly isolated.
- **Hydration Debugging:** Fixing mismatches between server-rendered HTML and client-rendered React trees.
- **Build Optimization:** Resolving build-time errors and reducing JavaScript bundle sizes.
- **Routing & Caching Verification:** Ensuring Parallel Routes and Next.js 15 caching defaults are correctly implemented.

## Core Principles & Verification Rules

### 1. The Server/Client Boundary (Serialization)
When code crosses the boundary from a Server Component to a Client Component, enforce strict serialization rules:
- [cite_start]**No Functions as Props:** Props passed to a "use client" entry component must be serializable[cite: 288]. [cite_start]Functions (like `onChange` or `setShow`) are not serializable and cannot be passed directly from a Server Component[cite: 300].
- [cite_start]**Resolution:** Define the handler inside the Client Component, or convert the function into a Server Action[cite: 300].

### 2. Hydration Mismatch Prevention
[cite_start]Hydration errors occur when server-rendered HTML differs from what React expects on the client[cite: 930]. The Agent MUST audit components for the following triggers:
- [cite_start]**Browser-Only APIs:** Accessing APIs like `window`, `document`, or `localStorage` during the initial render causes mismatches[cite: 934]. [cite_start]**Fix:** Wrap browser-only logic inside a `useEffect` hook to ensure it only runs on the client[cite: 1613].
- [cite_start]**Dynamic Values:** Rendering time-dependent APIs (like `Date()`) or random values during SSR will differ between server and client[cite: 935]. **Fix:** Use `useEffect` or React's `useId` for stable identifiers.
- [cite_start]**HTML Nesting:** Invalid HTML structure (e.g., nesting a `<div>` inside a `<p>` tag) causes the browser to modify the DOM during parsing, breaking hydration[cite: 940, 1606].

### 3. Data Fetching & Caching (Next.js 15 Standards)
Audit data fetching strategies to align with the latest framework defaults:
- [cite_start]**No-Store Default:** In Next.js 15 and above, the default behavior for `fetch()` requests is `no-store` (fresh request every time)[cite: 1385]. [cite_start]To cache data, explicitly use `{ cache: 'force-cache' }`[cite: 1047].
- **Server Component Fetching:** Do not use Route Handlers to fetch data for Server Components. [cite_start]Both run securely on the server, so you don't need the additional network hop; call the logic or database directly inside the Server Component[cite: 1064].

### 4. Parallel & Intercepted Routes
When verifying advanced routing structures (folders starting with `@`):
- [cite_start]**Missing Default Files:** Soft navigation preserves slot state, but hard navigation to a URL that doesn't match a parallel slot will fail[cite: 894]. [cite_start]**Fix:** Always ensure a `default.tsx` file is present in parallel route slots to render a fallback and prevent 404 errors[cite: 895].

---

## The AI Verification Process

### Phase 1: Static Code Analysis (Grep & Read)
1. Scan for `"use client"` directives.
2. Check the props being passed into these Client Components from their parent Server Components. Flag any functions or non-serializable objects.
3. Search for `window.` or `localStorage` outside of `useEffect` blocks.

### Phase 2: Structural Sanitation
1. Check Parallel Routes (`@folder`) for the existence of `default.tsx`.
2. Audit `fetch()` calls to ensure explicit caching strategies (`force-cache` or `no-store`) are defined according to business logic.

### Phase 3: Dynamic Browser Audit (Using DevTools)
1. Run `npm run build` then `npm run start` (or `dev`) using the `Bash` tool.
2. Use the `Browser` tool to navigate to the locally hosted application.
3. Open the browser console and actively scan for:
   - `Error: Text content does not match server-rendered HTML`
   - `Error: Props must be serializable...`
4. If errors are found, trace them back to the source file, apply the fixes outlined in the Core Principles, and re-test.

## Cross-Cutting Reference Modules

When the Agent requires deeper context, it must read the following guides:

| Topic | Reference File |
| :--- | :--- |
| **Hydration Fixes** | `reference/hydration-guide.md` |
| **RSC & Serialization** | `reference/rsc-boundaries.md` |
| **Next.js 15 Caching** | `reference/caching-v15.md` |
| **Routing Structures** | `reference/parallel-routes.md` |
