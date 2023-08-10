mixin ValidationMixin {
  defaultValidationMixin(String? text) {
    if (text == null || text == '') {
      return 'Required';
    } else {
      return null;
    }
  }

  emailValidationBySentence(String text) {
    if (text.contains('@') && text.length > 8) {
      return null;
    } else {
      return 'Unvalid Email.';
    }
  }

  passwordValidationMixin(String text) {
    if (text.length < 5) {
      return "Weak Password";
    }
    if (text.isEmpty) {
      return 'Unvalid Password';
    } else {
      return null;
    }
  }

  ipAdressValidationMixin(String text) {
    if (RegExp(r'^[0-9.]+$').hasMatch(text) == true) {
      return null;
    } else {
      return 'Wrong IP Address';
    }
  }

  portValidationMixin(String text) {
    if (RegExp(r'[0-9]+$').hasMatch(text)) {
      return null;
    } else {
      return 'Wrong Port Address';
    }
  }

  plcNameValidationMixin(String text) {
    if (text == '') {
      return 'PLC Name can not be empty.';
    } else {
      return null;
    }
  }
}
