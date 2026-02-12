# Remediation Priority

## Order
1. Blocker rule failures with low-risk fixes.
2. Blocker rule failures with privileged or high-risk fixes.
3. Warning rule failures.

## Grouping
- Group by capability to reduce repeated work.
- Separate OS-specific steps from cross-platform steps.
- Keep each global CLI install in a separate command to avoid batch aborts from one bad package name.
