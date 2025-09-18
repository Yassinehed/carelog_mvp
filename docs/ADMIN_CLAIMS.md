Admin custom claims and Cloud Functions (CareLog)

Overview
--------
This project enforces admin access via Firebase custom claims. Cloud Functions check `context.auth.token.admin == true` before allowing privileged operations (for example, `resetReadOnlyMode`). Firestore security rules also use `request.auth.token.admin == true` in `isAdmin()`.

Setting admin claims
--------------------
Use the Firebase Admin SDK to set the `admin` claim on a user. Example (Node.js):

```js
const admin = require('firebase-admin');
admin.initializeApp({ /* service account */ });
await admin.auth().setCustomUserClaims(uid, { admin: true });
```

After setting the claim, the client must refresh its ID token:

```js
await firebase.auth().currentUser.getIdToken(true);
```

Calling functions securely from Flutter
--------------------------------------
1. Ensure the current user is authenticated and has the admin claim.
2. Call the function using Cloud Functions client:

```dart
import 'package:cloud_functions/cloud_functions.dart';

final functions = FirebaseFunctions.instance;
final callable = functions.httpsCallable('resetReadOnlyMode');
try {
  final result = await callable.call();
  // handle success
} on FirebaseFunctionsException catch (e) {
  // handle error (permission-denied, unauthenticated, etc.)
}
```

Testing
-------
- Use the Firebase Emulator Suite to test local behavior.
- In emulator, you can use Admin SDK to set custom claims.

Notes
-----
- The codebase currently requires you to set claims externally (e.g. via a small admin script or Console using Admin SDK).
- Consider building a protected admin UI to manage roles securely (server-side only expose endpoints to set claims after proper auth).
