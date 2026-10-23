// Scanner configuration.
//
// PUBLIC_KEY: the production Ed25519 public key (unpadded base64url, 43 chars),
// copied from the generator page. Until it is filled in, the scanner shows a
// configuration error instead of scanning.
//
// Never paste the TEST key from test-vectors.json here.

export const PLACEHOLDER_PUBLIC_KEY = 'REPLACE_WITH_PRODUCTION_PUBLIC_KEY';

// Production key from the "Ceibos weekend pass" Apps Script project (created 2026-10-07).
export const PUBLIC_KEY = 'K4wOF_gqDk65lsSuyXNIdE6WFXFOLa4DSqk5ZhiOLhs';

// The test-only key from test-vectors.json; the app refuses to run with it.
export const TEST_PUBLIC_KEY = 'IiEksVknboFVtfJ3mTcaj6WNx1tSmyXYk7YosrlBPEM';

// Booking cancellation (cancelar/): the sheet project's web app (calendar-export/cancel.gs) of this
// installation. tools/publish-production.sh replaces it with production's.
export const CANCEL_API = 'https://script.google.com/macros/s/AKfycbzl4RXFvqAbgVVWYZ74GvGxzakCUtzi82OAbYBpiBxqHRPTAa9H-GfvEn1z_j0mHCC-Wg/exec';
