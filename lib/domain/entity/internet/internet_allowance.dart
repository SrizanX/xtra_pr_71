import '../../constants.dart';

class InternetAllowanceEntity {
  final String allowanceData;
  final bool dataLimit;
  final bool issim;
  final String totalUsed;

  InternetAllowanceEntity(
      {required this.allowanceData,
      required this.dataLimit,
      required this.issim,
      required this.totalUsed});

  factory InternetAllowanceEntity.fromJson(Map<String, dynamic> json) =>
      InternetAllowanceEntity(
        allowanceData: json['allowanceData'] ?? cUnknownStr,
        dataLimit: int.tryParse(json['dataLimit']) == 1,
        issim: json['issim'] == cTrueStr,
        totalUsed: json['totalUsed'] ?? cUnknownStr,
      );
}

enum AllowanceUnit {
  mb(label: "MB", multiplier: 1024 * 1024),
  gb(label: "GB", multiplier: 1024 * 1024 * 1024);

  final String label;
  final num multiplier;

  const AllowanceUnit({required this.label, required this.multiplier});
}
