const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin only if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

// Cloud Function triggered by Google Cloud Budget alert via Pub/Sub
exports.onBudgetExceeded = functions.pubsub.topic('budget-alerts').onPublish(async (message) => {
  const budgetAlert = message.json;

  console.log('Budget alert received:', budgetAlert);

  // Check if budget is exceeded (100% or more)
  if (budgetAlert.costAmount >= budgetAlert.budgetAmount) {
    console.log('Budget exceeded! Activating read-only mode...');

    try {
      // Update system status to read-only mode
      await admin.firestore().collection('config').doc('system_status').set({
        isReadOnly: true,
        maintenanceMessage: `Sistema in modalità manutenzione per superamento budget. Costo attuale: €${budgetAlert.costAmount}, Budget: €${budgetAlert.budgetAmount}`,
        lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
        budgetExceeded: true,
        budgetAmount: budgetAlert.budgetAmount,
        currentCost: budgetAlert.costAmount
      }, { merge: true });

      console.log('Read-only mode activated successfully');

      // Future enhancement: Send notification emails to administrators
      // Future enhancement: Log budget exceeded event for monitoring

    } catch (error) {
      console.error('Error activating read-only mode:', error);
      throw error;
    }
  } else {
    console.log('Budget alert received but not exceeded yet. Current cost:', budgetAlert.costAmount);
  }

  return null;
});

// Cloud Function to manually reset read-only mode (admin only)
exports.resetReadOnlyMode = functions.https.onCall(async (data, context) => {
  // Ensure caller is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
  }

  // Check custom claim 'admin' set on the user's token
  const token = context.auth.token || {};
  if (!token.admin) {
    console.warn('Unauthorized attempt to reset read-only mode by:', context.auth.uid);
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  try {
    await admin.firestore().collection('config').doc('system_status').set({
      isReadOnly: false,
      maintenanceMessage: null,
      lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
      budgetExceeded: false
    }, { merge: true });

    console.log('Read-only mode deactivated by admin:', context.auth.uid);
    return { success: true, message: 'Read-only mode deactivated' };
  } catch (error) {
    console.error('Error deactivating read-only mode:', error);
    throw new functions.https.HttpsError('internal', 'Failed to deactivate read-only mode');
  }
});

// Cloud Function to get current system status
exports.getSystemStatus = functions.https.onCall(async (data, context) => {
  try {
    // Allow unauthenticated callers to get the public system status, but still
    // log if unauthenticated access occurs.
    const doc = await admin.firestore().collection('config').doc('system_status').get();
    const data = doc.exists ? doc.data() : { isReadOnly: false };
    return data;
  } catch (error) {
    console.error('Error getting system status:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get system status');
  }
});