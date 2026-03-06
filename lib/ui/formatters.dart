class PhoneFormatter {
    static String toRaw(String? value) {
    if (value == null) return '';
    return value.replaceAll(RegExp(r'[^\d+]'), '');
  }

  static String toDisplay(String? phone) {
    if (phone == null || phone.isEmpty) return "";

    // 1. Clean the input to get raw digits and check for '+'
    final bool hasPlus = phone.startsWith('+');
    final String digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return phone;

    // 2. Handle Mexico (+52)
    if (hasPlus && digits.startsWith('52')) {
      final String national = digits.substring(2);
      if (national.length == 10) {
        // Rule: 55 or 56 prefix -> 55 5902 6567
        if (national.startsWith('55') || national.startsWith('56')) {
          return "+52 ${national.substring(0, 2)} ${national.substring(2, 6)} ${national.substring(6)}";
        }
        // Rule: Anything else -> XXX XXX XXXX
        return "+52 ${national.substring(0, 3)} ${national.substring(3, 6)} ${national.substring(6)}";
      }
    }

    // 3. Handle US/Canada (+1)
    if (hasPlus && digits.startsWith('1')) {
      final String national = digits.substring(1);
      if (national.length == 10) {
        return "+1 ${national.substring(0, 3)} ${national.substring(3, 6)} ${national.substring(6)}";
      }
    }

    // 4. Fallback: +X (xxx) xxxx xxxx xx (4 numbers per section)
    return _formatGlobalFallback(digits, hasPlus);
  }

  static String _formatGlobalFallback(String digits, bool hasPlus) {
    if (digits.length < 4) return hasPlus ? '+$digits' : digits;

    final buffer = StringBuffer(hasPlus ? '+' : '');
    
    // Assume first 2 digits are the country code for the visual mask if no + was provided
    // but since your DB has '+', we'll treat the first 2 as the code for the '(' ')'
    buffer.write('${digits.substring(0, 2)} (');
    
    String remaining = digits.substring(2);
    if (remaining.length > 3) {
      buffer.write('${remaining.substring(0, 3)}) ');
      remaining = remaining.substring(3);
    } else {
      buffer.write('$remaining)');
      return buffer.toString();
    }

    // Chunk the rest by 4
    for (int i = 0; i < remaining.length; i += 4) {
      int end = (i + 4 < remaining.length) ? i + 4 : remaining.length;
      buffer.write(remaining.substring(i, end));
      if (end < remaining.length) buffer.write(' ');
    }

    return buffer.toString();
  }
}