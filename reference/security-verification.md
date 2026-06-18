# Security Verification Guide

This guide defines the minimum security review steps an AI agent should apply during code review and cleanup.

## Purpose

Use this guide when reviewing:
- authentication logic
- authorization checks
- form handling
- API routes
- database access
- file uploads
- browser storage
- secret handling
- third-party integrations

## Core Security Principles

### 1. Trust No Input
Treat all input as untrusted:
- request bodies
- query parameters
- route params
- headers
- form fields
- cookies
- local storage
- external API responses

Validate and sanitize before use.

### 2. Enforce Authorization Explicitly
Do not assume a user can access a resource because they are authenticated.

Check:
- who the user is
- what resource they are accessing
- whether they are allowed to perform that action

### 3. Keep Secrets Out of the Client
Never expose:
- API keys
- service secrets
- private tokens
- database credentials
- internal admin credentials

Secrets belong on the server only.

### 4. Prefer Safe Defaults
Use secure defaults for:
- cookies
- sessions
- headers
- redirects
- file access
- CORS
- caching

## Security Review Checklist

### Input Validation
- [ ] Are all inputs validated?
- [ ] Are type assumptions enforced server-side?
- [ ] Are unknown values rejected safely?
- [ ] Are limits enforced for size and length?

### Authentication
- [ ] Is login/session handling secure?
- [ ] Are expired or missing sessions rejected?
- [ ] Are passwords handled with a strong hashing algorithm?
- [ ] Are refresh/session tokens protected?

### Authorization
- [ ] Is access checked for every protected action?
- [ ] Are ownership checks present for user-owned resources?
- [ ] Are admin-only operations restricted properly?

### Injection Risks
- [ ] Is SQL parameterized?
- [ ] Is HTML escaped where needed?
- [ ] Are shell commands constructed safely?
- [ ] Are unsafe eval-like patterns avoided?

### Client Exposure
- [ ] Are secrets kept out of client bundles?
- [ ] Are sensitive fields stripped before returning data?
- [ ] Are debug logs free of private data?

### Browser Storage
- [ ] Is sensitive data avoided in localStorage/sessionStorage?
- [ ] Are cookies configured securely when used for auth?
- [ ] Are persistence decisions intentional?

### Uploads and Files
- [ ] Are uploaded files validated?
- [ ] Are file types restricted?
- [ ] Are file sizes capped?
- [ ] Are dangerous filenames normalized?

### Redirects and Routing
- [ ] Are redirects validated against allowed destinations?
- [ ] Are open redirects prevented?
- [ ] Are unauthenticated users redirected safely?

## Common Red Flags

- hardcoded secrets
- insecure direct object references
- missing authorization checks
- string concatenation in SQL
- unsanitized HTML rendering
- unsafe file paths
- exposed stack traces in production
- permissive CORS policies
- unbounded input processing

## Review Standard

If a security issue is found:
1. classify severity
2. explain the risk clearly
3. fix it if possible
4. re-verify the fix
5. ensure the regression path is covered

## Severity Guide

- 🔴 **Critical**: secrets exposed, authorization bypass, injection, remote exploitation
- 🟡 **Important**: weak validation, unsafe storage, missing restrictions, risky defaults
- 🟢 **Minor**: hardening opportunities, defensive improvements, logging cleanup

## Final Principle

Security review is not about style. It is about preventing unauthorized access, data exposure, and exploitable behavior.