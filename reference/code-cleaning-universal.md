# Universal Code Cleaning Guide

This guide defines language-agnostic cleanup rules for AI agents performing code review, refactoring, or verification.

## Goals

- Reduce technical debt
- Improve readability and maintainability
- Remove dead code and duplication
- Make intent explicit
- Preserve behavior unless a change is intentionally requested

## Core Rules

### 1. Remove Dead Code
Delete:
- unused imports
- unused variables
- unreachable branches
- commented-out code
- obsolete helper functions
- duplicated constants

Do not preserve dead code “just in case”. Version control already preserves history.

### 2. Prefer Simple Control Flow
Use:
- early returns
- guard clauses
- small functions with one responsibility
- explicit error handling

Avoid:
- deep nesting
- long chained conditionals
- switch statements with repeated logic
- boolean flags that obscure behavior

### 3. Reduce Duplication
Before adding new code, search for:
- existing helpers
- shared utilities
- common abstractions
- existing validation logic
- existing formatting or mapping functions

If equivalent logic already exists, reuse it.

### 4. Make Data Flow Explicit
Prefer:
- descriptive names
- immutable values where possible
- typed objects over loose ad-hoc structures
- clear function signatures
- minimal parameter counts

Avoid:
- magic strings
- magic numbers
- ambiguous abbreviations
- parameter sprawl
- hidden side effects

### 5. Keep Changes Focused
A cleanup pass should not expand the scope of a task unnecessarily.

Good cleanup:
- removes noise
- simplifies logic
- improves reliability
- preserves behavior

Bad cleanup:
- unrelated rewrites
- style preferences without value
- architectural churn without justification

## Refactoring Patterns

### Replace Nested Conditionals
```ts
// Before
if (user) {
  if (user.isActive) {
    if (user.role === "admin") {
      return true;
    }
  }
}
return false;

// After
if (!user) return false;
if (!user.isActive) return false;
return user.role === "admin";

// Before
const fullNameA = `${firstName} ${lastName}`;
const fullNameB = `${firstName} ${lastName}`;

// After
const getFullName = (firstName: string, lastName: string) =>
  `${firstName} ${lastName}`;


Replace Stringly-Typed Logic

Prefer constants or enums when values are reused across branches.

Cleanup Priority

When reviewing code, prioritize in this order:

Correctness
Security
Maintainability
Performance
Style
Acceptance Criteria

A cleanup is complete only if:

behavior is preserved or intentionally improved
dead code is removed
control flow is clearer
duplication is reduced
the result remains easy to test
Final Check

Before approving, ask:

Is this simpler than before?
Is the intent clearer?
Did we remove anything unnecessary?
Did we avoid adding new complexity?

If the answer to any of those is no, continue refining.