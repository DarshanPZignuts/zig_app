import 'package:zig_project/resources/string_manager.dart';

class Validation {
  RegExp regEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String? validateEmail(String? _value) {
    if (_value!.isEmpty) {
      return StringManager.validateEmptyEmail;
    } else if (!regEmail.hasMatch(_value)) {
      return StringManager.validateEmail;
    }
    return null;
  }

  String? validatePassword(String? _value) {
    if (_value!.isEmpty) {
      return StringManager.validateEmptyPassword;
    } else if (_value.length < 6) {
      return StringManager.validatePasswordLength;
    } else if (!RegExp(r"[a-zA-Z]").hasMatch(_value)) {
      return StringManager.validatePasswordCharacter;
    } else if (!RegExp(r"[0-9]").hasMatch(_value)) {
      return StringManager.validatePasswordNumber;
    }
    return null;
  }

  String? validateConfirmPassword(String? _value, String? _password) {
    if (_value!.isEmpty) {
      return StringManager.validateEmptyPassword;
    } else if (!(_value == _password)) {
      return StringManager.validateConfirmPasswordMatch;
    }
    return null;
  }

  String? validateEmptyFields(String? _value, String validationText) {
    if (_value!.isEmpty) {
      return validationText;
    }
    return null;
  }
}
