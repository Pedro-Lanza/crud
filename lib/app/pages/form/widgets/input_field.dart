import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.label,
    this.icon,
    required this.hint,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.inputFormatters,
  });

  final String label;
  final String hint;
  final Icon? icon;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        icon: icon,
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
