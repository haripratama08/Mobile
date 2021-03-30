class Validation {
  String password = '';
  String validateUser(String value) {
    if (value.isEmpty) {
      return 'Fill User';
    }
    return null;
  }

  String validatePassword(String value) {
    password = value;
    if (value.length < 4) {
      return 'Minimum 4 Character';
    }
    return null;
  }

  String validateRetype(String value) {
    if (value != password) {
      return 'Password did not match';
    }
    return null;
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Email not Valid';
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Fill name';
    }
    return null;
  }

  String validateAdd(String value) {
    if (value.isEmpty) {
      return 'Fill Address';
    }
    return null;
  }

  String validateTelp(String value) {
    if (value.isEmpty) {
      return 'Fill Telephone';
    }
    return null;
  }

  String validatelahan(String value) {
    if (value.isEmpty) {
      return 'Fill Luas lahan';
    }
    return null;
  }

  String validateall(String value) {
    if (value.isEmpty) {
      return 'Fill the blank';
    }
    return null;
  }
}
