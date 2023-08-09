import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldApp extends StatelessWidget {
  TextFieldApp({
    super.key,
    required this.controller,
    required this.validate,
    required this.textInputType,
    required this.inputFormatter,
  });

  String? Function(String?)? validate;
  TextEditingController controller;
  TextInputType textInputType;
  List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      keyboardType: textInputType,
      style: AppTypography.nunitoSemiBold16,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: ColorName.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: ColorName.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white70,
      ),
      validator: validate,
    );
  }
}

class TextFieldSearchApp extends StatelessWidget {
  TextFieldSearchApp({
    super.key,
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTypography.nunitoSemiBold16,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Поиск по чату',
        hintStyle:
            AppTypography.gilroyMedium16.copyWith(color: Color(0xffA1ADBF)),
        prefixIcon: const Icon(Icons.search, color: Color(0xffA1ADBF)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xffE8E8F0)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xffE8E8F0)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: const Color(0xffF7F9FD),
      ),
    );
  }
}

// Валидация полей TextFieldApp
mixin InputValidationMixin {
  /// Валидация на null
  bool isNotNull(String? value) {
    return value.toString().isEmpty;
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
