import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputForm extends StatelessWidget {
  const CustomInputForm(
      {super.key,
      this.controller,
      this.keyboardType,
      this.hintText,
      this.validator,
      this.suffixIcon,
      this.inputFormatters,
      this.maxLength,
      this.maxLines = 1,
      this.obscureText = false,
      this.onChanged,
      this.onSubmitted,
      this.contentPadding,
      this.initialValue,
      this.textStyle,
      this.hintTextStyle});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      initialValue: initialValue,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      style: textStyle ??
          theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: theme.colorScheme.surfaceVariant,
        hintStyle: hintTextStyle ??
            theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
    );
  }
}
