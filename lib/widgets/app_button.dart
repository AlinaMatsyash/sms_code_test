import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Стандартная кнопка в приложении
///
/// Текст кнопки [text]
/// Коллбэк при нажатии на кнопку [onPressed]
class AppButton extends StatelessWidget {
  const AppButton({required this.text, this.onPressed, Key? key})
      : super(key: key);

  /// Текст у кнопки
  final String text;

  /// Коллбэк при нажатии на кнопку
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: ColorName.color7,
      textColor: ColorName.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      disabledColor: Theme.of(context).colorScheme.secondary,
      disabledTextColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTypography.nunitoSemiBold18,
      ),
    );
  }
}
