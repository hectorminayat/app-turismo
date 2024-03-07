import 'package:form_field_validator/form_field_validator.dart';

class CustomMinLengthValidator extends TextFieldValidator {
  final int min;

  CustomMinLengthValidator(this.min, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if(value!.length == 0)
    return true;

    return value.length >= min;
  }
}