///
/// Parse [FirebaseAuthException] codes to response message
///
String parseAuthCodeToMessage(String code) {
  switch (code) {
    case 'email-already-in-use':
      return 'Email is already used!';
    case 'wrong-password':
      return 'The pasword is wrong!';
    case 'invalid-email':
      return 'Enter a valid email!';
    case 'user-not-found':
      return 'User not corresponding to the given email';
    case 'invalid-credential':
      return 'Wrong user or password';
    case 'network-request-failed':
      return 'Connection error';
    default:
      return 'Unknown error';
  }
}
