import 'package:flutter/widgets.dart';

/// This base validator indicate the validation error by replacing
/// the text field text value with the error message.
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

  /// This validator indicate the validation error by replacing
  /// the text field text value with the error message.
  ///
  /// This validator displays the [validationMessage] for 1 second
  /// after which the text field is cleared.
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
