/// Bangladesh mobile operators, identified from the SIM's IMSI.
///
/// An IMSI is `MCC + MNC + MSIN`. Bangladesh's MCC is 470; the two MNC digits
/// that follow pick the operator.
enum MobileOperator {
  grameenphone('Grameenphone'),
  robi('Robi'),
  banglalink('Banglalink'),
  teletalk('Teletalk'),
  airtel('Airtel'),
  unknown('Unknown');

  const MobileOperator(this.displayName);

  final String displayName;

  bool get isKnown => this != MobileOperator.unknown;

  static MobileOperator fromImsi(String? imsi) {
    final digits = (imsi ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.length < 5 || !digits.startsWith('470')) {
      return MobileOperator.unknown;
    }
    return switch (digits.substring(3, 5)) {
      '01' => MobileOperator.grameenphone,
      '02' => MobileOperator.robi,
      '03' => MobileOperator.banglalink,
      '04' => MobileOperator.teletalk,
      '07' => MobileOperator.airtel,
      _ => MobileOperator.unknown,
    };
  }
}
