import 'package:flutter/services.dart';

class PositiveNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // Permitir vacío temporalmente (para poder borrar)
    if (newText.isEmpty) return newValue;

    final parsed = int.tryParse(newText);

    if (parsed == null || parsed <= 0) {
      return const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    return newValue;
  }
}