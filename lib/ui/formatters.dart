class PhoneFormatter {
  static String toRaw(String? value) {
    if (value == null) return '';
    return value.replaceAll(RegExp(r'[^\d+]'), '');
  }

  static String toVisual(String? digits) {
    if (digits == null) return '';
    final cleanDigits = digits.replaceAll(RegExp(r'\D'), '');

    if (cleanDigits.isEmpty) return "";

    final buffer = StringBuffer();
    for (int i = 0; i < cleanDigits.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');
      buffer.write(cleanDigits[i]);
      if (i >= 9) break; // Limit to 10 digits
    }
    return buffer.toString();
  }

  static String toFullDisplay(String countryCode, String digits) {
    return '$countryCode ${toVisual(digits)}';
  }
}
