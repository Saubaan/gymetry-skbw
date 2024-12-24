String getFirebaseAuthErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Please enter a valid email address';
    case 'network-request-failed':
      return 'No internet connection';
    case 'invalid-credential':
      return 'Username or password is incorrect';
    case 'user-disabled':
      return 'User account has been disabled';
    case 'email-already-in-use':
      return 'Email already in use';
    case 'operation-not-allowed':
      return 'Operation not allowed';
    case 'weak-password':
      return 'Password is too weak';
    default:
      return 'An error occurred: $code';
  }
}
