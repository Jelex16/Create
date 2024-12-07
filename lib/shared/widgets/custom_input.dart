import 'package:flutter/material.dart';

class CustomInputs extends StatelessWidget {
  const CustomInputs(
      {super.key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.errorText,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.initialValue,
      this.maxLength,
      this.maxLines,
      this.controller,
      this.borderRadious = 10,
      this.colorStyle,
      this.enabled = true,
      this.textCapitalization = true,
      this.label,
      this.helperText});
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? helperText;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController? controller;
  final double borderRadious;
  final bool enabled;
  final Color? colorStyle;
  final bool textCapitalization;
  final Widget? label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 10),
            child: label,
          ),
        TextFormField(
          keyboardType: keyboardType,
          style: TextStyle(
            color: colorStyle ?? Theme.of(context).primaryColorDark,
          ),
          textCapitalization: textCapitalization
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          enabled: enabled,
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            helperText: helperText,
            helperStyle: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            prefixIconColor: colorStyle ?? Theme.of(context).primaryColorDark,
            suffixIconColor: colorStyle ?? Theme.of(context).primaryColorDark,
            hintStyle: TextStyle(
                color: colorStyle ?? Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.normal),
            errorText: errorText,
            errorStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadious),
            ),
            filled: true,
            fillColor: const Color(0xFFF3F3F3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadious),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadious),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadious),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
