# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
- Fix: Registered concrete repository implementations to resolve injectable_generator warnings (OfOrderRepository & SignalementRepository). See PR #12.
- Test: Added a DI smoke test to CI to detect codegen/DI regressions early. See PR #13.
- Docs: Added generated files policy to CONTRIBUTING.md explaining the "do not commit generated files" recommendation and local regeneration steps.
