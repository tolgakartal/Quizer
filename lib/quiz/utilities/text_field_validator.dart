import 'package:flutter/widgets.dart';

/// This validator indicate the validation error by replacing
/// the text field text value with the error message.
///
/// This validator displays the validation error message for 1 second
/// after which the text field is cleared.
abstract class TextFieldValidator {
  final String validationMessage;
  final TextEditingController controller;
  static const int messageDisplayLengthInSeconds = 1;

  TextFieldValidator({
    required this.validationMessage,
    required this.controller,
  });

  void validate();
}

class TextFieldRequiredValidator extends TextFieldValidator {
  TextFieldRequiredValidator({
    required String validationMessage,
    required TextEditingController controller,
  }) : super(
          validationMessage: validationMessage,
          controller: controller,
        );

  @override
  bool validate() {
    if (controller.text.isEmpty || controller.text == validationMessage) {
      controller.text = validationMessage;
      Future.delayed(
          const Duration(
              seconds: TextFieldValidator.messageDisplayLengthInSeconds), () {
        controller.clear();
      });
      return false;
    }

    return true;
  }
}
