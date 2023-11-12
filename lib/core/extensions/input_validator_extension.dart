extension InputValidation on String? {
  String? isPasswordStrong(String password) {
    if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[0-9])(?=.*[a-zA-Z]).{8,}$')
        .hasMatch(password)) {
      return '''Password should be at least 8
      characters with 1 special character, 1 number and 1
    alphabetical character''';
    }
    return null;
  }

  String? isValidField() {
    if (this?.isNotEmpty != true) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? isValidEmail() {
    if (this != null) {
      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(this!)) {
        return 'Wrong mail format';
      }
    }
    return 'Please enter your email';
  }
}
