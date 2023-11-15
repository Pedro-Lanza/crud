import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.label,
    this.icon,
    required this.hint,
    this.onSaved,
    this.initialValue,
  });

  final String label;
  final String hint;
  final Icon? icon;
  final initialValue;
  final onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: (val) {
        if (val == null || val.isEmpty) return 'Campo obrigatório';
        return null;
      },
      onSaved: onSaved,
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
