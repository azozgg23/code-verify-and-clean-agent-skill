# code-verify-and-clean-skill

A reusable AI skill for code verification, cleanup, runtime auditing, and security-focused review.

## Purpose

This skill helps an AI agent:
- verify code correctness
- remove dead code and duplication
- audit runtime behavior in the browser
- check security issues
- enforce clean architecture
- validate builds, tests, and linting

## Repository Structure

```text
code-verify-and-clean-skill/
├── assets/
│   ├── review-template.md
│   └── verification-checklist.md
├── reference/
│   ├── code-cleaning-universal.md
│   ├── devtools-verification.md
│   └── security-verification.md
├── scripts/
│   └── verify-pipeline.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── README.md
└── skill.md