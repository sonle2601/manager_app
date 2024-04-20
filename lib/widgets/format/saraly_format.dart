import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CurrencyFormatter extends TextInputFormatter {
  static const int _maxDigits = 10;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int selectionIndex = newValue.selection.end;
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.length > _maxDigits) {
      return oldValue;
    }

    final StringBuffer newTextWithSeparator = StringBuffer();
    int count = 0;
    for (int i = newText.length - 1; i >= 0; i--) {
      if (count != 0 && count % 3 == 0) {
        newTextWithSeparator.write(',');
      }
      newTextWithSeparator.write(newText[i]);
      count++;
    }

    final String formattedText = newTextWithSeparator.toString().split('').reversed.join('');

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex + 1),
    );
  }
}
