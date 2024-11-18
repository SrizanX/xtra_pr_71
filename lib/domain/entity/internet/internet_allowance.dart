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
