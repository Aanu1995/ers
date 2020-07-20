class Validators {
  static String Function(String) validatePhone([String error]) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Phone number is required.';
      }
      if (!RegExp(r'^\d+?$').hasMatch(value) ||
          !value.startsWith(RegExp("0[1789]")) ||
          // Land lines eg 01
          (value.startsWith("01") && value.length != 9) ||
          // Land lines eg 080
          (value.startsWith(RegExp("0[789]")) && value.length != 11)) {
        return error ?? 'Not a valid phone number.';
      }
      return null;
    };
  }

  static String Function(String) validateAddress([String error]) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error ?? 'Address is required.';
      }
      if (value.length < 4) {
        return error ?? 'Address should be greater than 4 characters';
      }
      return null;
    };
  }

  static String Function(String) validateName([String error]) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Name is required.';
      }
      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphabetical characters.';
      }
      return null;
    };
  }

  static String Function(String) validateLocal([String error]) {
    return (String value) {
      if (value == null) {
        return error ?? 'Local Governement is required.';
      }
      return null;
    };
  }
}
