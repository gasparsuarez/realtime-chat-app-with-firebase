class Validators {
  ///
  /// Input and other validators
  ///
  Validators._();

  ///
  /// Validate email with Regexp Pattern
  ///
  static validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
