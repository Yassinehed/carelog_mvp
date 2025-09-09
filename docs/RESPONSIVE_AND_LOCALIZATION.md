RESPONSIVE DESIGN, ACCESSIBILITY & LOCALIZATION — CareLog MVP

Goals
- Support Web (Chrome) and Android (phone/tablet).
- Adaptive layouts that work on phones, tablets, and desktop browsers.
- French as primary language; full accessibility (WCAG AA) and large touch targets for operators.

Responsive patterns
- Use `LayoutBuilder` and `MediaQuery` to adapt breakpoints.
- Define breakpoints (example):
  - small: <600 (phones)
  - medium: 600-1024 (tablets)
  - large: >1024 (desktop / large tablet)

Example pattern:

Widget build(BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    if (constraints.maxWidth < 600) return PhoneLayout();
    if (constraints.maxWidth < 1024) return TabletLayout();
    return DesktopLayout();
  });
}

Accessibility (WCAG AA) checklist
- Use semantic widgets and provide `semanticsLabel` for important UI elements.
- Ensure color contrast ratio meets WCAG AA (4.5:1 for normal text).
- Support text scaling and respect `MediaQuery.textScaleFactor`.
- Provide large touch targets (minimum 48x48 dp) and sufficient spacing.
- Ensure keyboard navigation and focus order for web/desktop.
- Test with screen readers (TalkBack, VoiceOver) and browser accessibility tools.

Localization
- Use `flutter_localizations` and `intl` packages.
- Keep code identifiers in English; UI strings in French.
- Example `MaterialApp` setup:

MaterialApp(
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  supportedLocales: const [Locale('fr')],
  locale: const Locale('fr'),
  // ...
)

Data residency & deployment scope (Strasbourg only -> national)
- Keep production Firebase project region in the EU (e.g., europe-west).
- Enforce region claims on user accounts (e.g., custom claim `region: "strasbourg"`).
- During national rollout, update claims / rules accordingly.
- Document legal and data residency constraints for hosting and backups.

Testing & QA
- Add responsive snapshot tests for critical screens.
- Perform manual accessibility audits and automated checks (axe, pa11y for web).

Performance
- Lazy-load heavy widgets and images.
- Use deferred imports for infrequently used modules.
- For web, enable tree-shaking and minimize third-party scripts.

Next steps
- Decide whether to add `flutter_localizations` + `intl` to `pubspec.yaml` now (I can add them if you want).
- Implement a small i18n sample with an `arb` file and generated messages.
