CARELOG MVP — Security Guidance

Scope
- Target: Web (Chrome), Android tablets and phones.
- Deployment phases: start limited to Strasbourg, then national rollout.

Goals
- Prevent common web/mobile attacks.
- Harden Firebase (Auth, Firestore, Storage, Functions).
- Ensure secure client storage and communication.
- Provide operational steps for incident response and dependency hygiene.

Immediate actionable checklist
1. Enforce HTTPS everywhere
   - Web: host with HTTPS and HSTS. Ensure CDN or hosting provider sets Strict-Transport-Security header.
   - Android: use network security config if using non-HTTPS dev endpoints.

2. Firebase hardening
   - Use Firebase Authentication for all user access.
   - Apply Firestore Security Rules (example below) and test with the Rules Simulator.
   - Enable Firebase App Check to prevent unauthorized clients.

Example minimal Firestore rule (adapt for your data model):

service cloud.firestore {
  match /databases/{database}/documents {
    // example: orders collection — only authenticated users with allowed region can read
    match /orders/{orderId} {
      allow read: if request.auth != null && request.auth.token.region == 'strasbourg';
      allow write: if request.auth != null && request.auth.token.role == 'operator';
    }
  }
}

Notes:
- The claim `request.auth.token.region` requires setting custom claims server-side (e.g., during account provisioning) to restrict users to Strasbourg or national scope.
- Use server-side verification for sensitive authorization logic where client claims can't be trusted.

3. Secure storage & secrets
   - Do not store secrets in code or repository.
   - Use `flutter_secure_storage` (Android Keystore / iOS Keychain) for tokens.
   - For web, avoid persistent secrets in client; rely on secure short-lived tokens and server-side APIs.

4. Client integrity
   - Use Firebase App Check (with reCAPTCHA v3 for web) to ensure only valid instances use your backend.
   - For Android, consider safetyNet or Play Integrity.

5. Web-specific security
   - Add a Content Security Policy (CSP) at the hosting layer. Example header:
     Content-Security-Policy: default-src 'self'; script-src 'self' https://www.gstatic.com; connect-src 'self' https://*.firebaseio.com https://firestore.googleapis.com; img-src 'self' data:; style-src 'self' 'unsafe-inline';
   - Use Subresource Integrity (SRI) for third-party scripts when possible.

6. Dependency hygiene
   - Pin dependency versions and run `flutter pub outdated` regularly.
   - Add automated dependency scanning in CI (e.g., GitHub Dependabot, Snyk).

7. Runtime protections & monitoring
   - Enable Firebase Logging & Monitoring.
   - Use alerts for suspicious auth patterns (multiple failed logins, unusual IPs).

8. Incident response
   - Maintain an incident runbook with steps to revoke keys, disable functions, and rotate secrets.

Recommended packages to add (discuss before adding to `pubspec.yaml`):
- flutter_secure_storage — secure local storage for tokens
- firebase_app_check — protect your Firebase resources
- package:jwt_decode or similar — validate tokens when needed
- flutter_localizations + intl — for localization (French default)

Further hardening suggestions
- Perform threat modeling for your data flows and sensitive assets.
- Enforce least privilege in Firestore rules and Cloud Functions.
- Use server-side validation for all critical operations and audits.

References
- Firebase Security Rules docs: https://firebase.google.com/docs/rules
- OWASP Mobile Top 10: https://owasp.org/www-project-mobile-top-10/
- CSP reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP

Contact
- Add internal contacts and escalation paths here as you form your security team.
