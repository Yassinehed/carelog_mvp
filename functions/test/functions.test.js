const { expect } = require('chai');
const test = require('firebase-functions-test')({ projectId: 'carelog-mv' });
const admin = require('firebase-admin');
const myFunctions = require('..');

describe('Cloud Functions', () => {
  before(() => {
    // initialize admin SDK to the emulator if available
    if (!admin.apps.length) {
      admin.initializeApp({ projectId: 'carelog-mv' });
    }
  });

  after(() => {
    test.cleanup();
  });

  it('onBudgetExceeded writes read-only state when budget exceeded', async () => {
    const wrapped = test.wrap(myFunctions.onBudgetExceeded);

    const fakeMessage = {
      json: {
        costAmount: 120,
        budgetAmount: 100
      }
    };

    await wrapped(fakeMessage);

    const doc = await admin.firestore().collection('config').doc('system_status').get();
    const data = doc.data();

    expect(data).to.have.property('isReadOnly', true);
    expect(data).to.have.property('budgetExceeded', true);
  });

  it('resetReadOnlyMode rejects unauthenticated caller', async () => {
    const wrapped = test.wrap(myFunctions.resetReadOnlyMode);
    try {
      await wrapped({}, { auth: null });
      throw new Error('Expected unauthenticated error');
    } catch (err) {
      expect(err).to.exist;
    }
  });

  it('getSystemStatus returns object', async () => {
    const wrapped = test.wrap(myFunctions.getSystemStatus);
    const res = await wrapped({}, { auth: null });
    expect(res).to.be.an('object');
  });
});
