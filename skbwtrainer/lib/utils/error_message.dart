String getFirebaseAuthErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Invalid email address';
    case 'invalid-credential':
      return 'Username or password is incorrect';
    case 'user-disabled':
      return 'User account has been disabled';
    case 'user-not-found':
      return 'User not found';
    case 'wrong-password':
      return 'Invalid password';
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