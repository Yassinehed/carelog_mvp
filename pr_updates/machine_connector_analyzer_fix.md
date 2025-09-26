Title: fix(analyzer): resolve info lints and small cleanups for Machine connector

Summary

This PR updates small code issues discovered by static analysis and keeps the Machine connector feature branch in a CI-ready state.

Changes

- Fix linter/info warnings across the codebase:
  - Reordered widget named arguments so `child` is last where applicable.
  - Converted non-const instantiations to `const` where safe (e.g., `Left(ServerFailure())`).
  - Replaced deprecated `pw.Table.fromTextArray` with `pw.TableHelper.fromTextArray`.
  - Used `super.key` and `super` constructor parameters where applicable.
- Regenerated code with `build_runner`.
- Tests: ran unit+widget tests locally (all passing).
- Analyzer: ran `flutter analyze --no-pub --fatal-infos` locally — no issues found.

Why

These fixes are small, low-risk, and improve CI stability (no info-level lint failures). They unblock merging and CI validation for the `feature/machine-connector-mvp` branch.

How to test

- Run `flutter pub get` then `flutter pub run build_runner build --delete-conflicting-outputs`.
- Run `flutter analyze --no-pub --fatal-infos`.
- Run `flutter test` (unit & widget tests).

Notes

- Emulator/integration tests are opt-in (previously caused timeouts locally).
- If you'd prefer not to commit generated files, we can revert them and rely on CI to generate at build time.
