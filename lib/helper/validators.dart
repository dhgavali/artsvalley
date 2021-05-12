import 'package:artsvalley/shared/constants.dart';

class CustomFormValidators {
  String emailValidator(String value) {
    if (value.isEmpty) return "Email can't be empty";
    if (!emailValidatorRegExp.hasMatch(value)) {
      return 'Please enter valid Email';
    } else {
      return null;
    }
  }

  String validateName(value) {
    if (value.isEmpty) {
      return "This can't be empty";
    }
    return null;
  }
}
