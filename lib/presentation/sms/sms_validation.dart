// Validation rules for composing an SMS on the PR71.

/// Maximum characters the router accepts in a single SMS body.
const int smsMaxLength = 50;

/// Accepted Bangladeshi mobile-number forms:
/// * local — `01XXXXXXXXX` (11 digits, e.g. `01918261840`)
/// * international — `+8801XXXXXXXXX` (14 chars, e.g. `+8801918261840`)
///
/// Both encode the same subscriber number; the international form is `+880`
/// followed by the local number without its leading `0`.
final _bdLocal = RegExp(r'^01\d{9}$');
final _bdIntl = RegExp(r'^\+8801\d{9}$');

/// Returns an error message for an invalid number, or `null` when it's valid.
String? validateBdPhone(String raw) {
  final number = raw.trim();
  if (number.isEmpty) return 'Enter a phone number';
  if (_bdLocal.hasMatch(number) || _bdIntl.hasMatch(number)) return null;
  return 'Use 01XXXXXXXXX or +8801XXXXXXXXX';
}

bool isValidBdPhone(String raw) => validateBdPhone(raw) == null;
