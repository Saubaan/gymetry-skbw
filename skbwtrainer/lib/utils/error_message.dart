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
