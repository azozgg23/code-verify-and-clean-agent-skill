
## `reference/devtools-verification.md`

```md
# DevTools Verification Guide

This guide defines how an AI agent should verify runtime behavior using browser-based tools and local execution.

## Purpose

Use this guide when a change affects:
- UI rendering
- hydration
- component state
- browser APIs
- routing
- client-side data fetching
- animations
- network behavior

## Verification Workflow

### 1. Start from the Working Build
Before visual review:
- run the project’s formatter
- run linting
- run type checks
- run tests
- start the local app

The browser is for verification, not for compensating for broken builds.

### 2. Inspect the Page
When the app is running:
- open the affected route
- confirm the page loads successfully
- verify layout, spacing, and responsive behavior
- check interactions that were changed

### 3. Check the Console
Review:
- `console.error`
- `console.warn`
- unhandled promise rejections
- hydration warnings
- runtime exceptions
- asset loading failures

Any unexpected console error is a verification failure unless proven harmless.

### 4. Check the Network
Confirm:
- correct request URLs
- correct request payloads
- correct response status codes
- no repeated unnecessary calls
- no failed API requests
- no infinite refetch loops

### 5. Confirm State Transitions
Verify:
- loading states
- empty states
- error states
- success states
- navigation transitions
- form submission behavior

## Common UI Failure Modes

### Hydration Issues
Watch for:
- text mismatch
- invalid HTML nesting
- browser-only APIs used during initial render
- unstable values rendered on the server

### Layout Issues
Watch for:
- broken flex/grid alignment
- overflow
- clipped content
- incorrect z-index layering
- mobile responsiveness regressions

### Interaction Issues
Watch for:
- buttons not firing
- duplicate event handlers
- broken keyboard navigation
- focus traps
- stale state after navigation

## Verification Rules

### Rule 1: Do Not Assume
If a component looks correct in code, still verify it in the browser.

### Rule 2: Prefer Evidence
Use console logs, DOM inspection, network traces, and screenshots when needed.

### Rule 3: Verify the Exact Change
Do not generalize from an unrelated screen. Review the specific route or component that changed.

### Rule 4: Re-test After Fixes
Any fix should be re-verified in the browser before approval.

## Browser Audit Checklist

- [ ] Page loads without crashes
- [ ] No hydration warnings
- [ ] No unexpected console errors
- [ ] Network requests succeed
- [ ] UI matches expected behavior
- [ ] Responsive layout is intact
- [ ] Accessibility basics still work
- [ ] State updates correctly after user actions

## Reporting Standard

When reporting verification results:
- name the route or component reviewed
- list any runtime errors found
- note whether they were fixed
- summarize the final browser result

## Closing Principle

Static code review is incomplete without runtime verification for client-facing changes.