String getFirebaseAuthErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Please enter a valid email address';
    case 'network-request-failed':
      return 'PLease check your internet connection';
    case 'invalid-credential':
      return 'The e-mail or password entered is incorrect';
    case 'user-disabled':
      return 'User account has been disabled';
    case 'email-already-in-use':
      return 'The Account already exists';
    case 'operation-not-allowed':
      return 'Operation not allowed';
    case 'weak-password':
      return 'Password is too weak';
    default:
      return 'An error occurred: $code';
  }
}

String getFirestoreErrorMessage(String code) {
  switch (code) {
    case 'permission-denied':
      return 'You do not have permission to perform this operation.';
    case 'not-found':
      return 'The requested document does not exist.';
    case 'already-exists':
      return 'The document already exists.';
    case 'resource-exhausted':
      return 'Resource limits exceeded. Try again later.';
    case 'unavailable':
      return 'Firestore service is currently unavailable. Please try again later.';
    case 'cancelled':
      return 'The operation was cancelled.';
    case 'invalid-argument':
      return 'Invalid input provided. Please check your data and try again.';
    case 'deadline-exceeded':
      return 'The operation took too long to complete. Please try again.';
    case 'failed-precondition':
      return 'Operation cannot be performed in the current state.';
    case 'aborted':
      return 'The operation was aborted due to a conflict.';
    case 'out-of-range':
      return 'An operation was attempted outside of the valid range.';
    case 'internal':
      return 'An internal Firestore error occurred. Please try again.';
    case 'unauthenticated':
      return 'You must be signed in to perform this operation.';
    default:
      return 'An unknown error occurred: $code';
  }
}
