

final class SmsApiEntity {
  int curPage;
  int startRowNum;
  int endRowNum;
  int recordsPerpage;
  int totalRecords;
  int totalPage;
  List<Sms> data;

  SmsApiEntity({
    required this.curPage,
    required this.startRowNum,
    required this.endRowNum,
    required this.recordsPerpage,
    required this.totalRecords,
    required this.totalPage,
    required this.data,
  });

  SmsApiEntity.fromJson(Map<String, dynamic> json)
      : curPage = json['curPage'] as int,
        startRowNum = json['startRowNum'] as int,
        endRowNum = json['endRowNum'] as int,
        recordsPerpage = json['recordsPerpage'] as int,
        totalRecords = json['totalRecords'] as int,
        totalPage = json['totalPage'] as int,
        data = (json['data'] as List<dynamic>)
            .map((sms) => Sms.fromJson(sms))
            .toList();
}

final class Sms {
  String smsContent;
  String phoneNumber;
  String smsDate;
  int messageid;
  int classid;
  String singleCount;
  String smstype;

  /// The router pages SMS globally; this records which page the message was
  /// loaded from, which the delete endpoint needs as `curpage`. Set by the
  /// cubit after each page fetch (the parsed payload doesn't carry it per-row).
  int page = 0;

  Sms({
    required this.smsContent,
    required this.phoneNumber,
    required this.smsDate,
    required this.messageid,
    required this.classid,
    required this.singleCount,
    required this.smstype,
  });

  Sms.fromJson(Map<String, dynamic> json)
      : smsContent = json['smsContent'],
        phoneNumber = json['phoneNumber'],
        smsDate = json['smsDate'],
        messageid = json['messageid'],
        classid = json['classid'],
        singleCount = json['singleCount'],
        smstype = json['smstype'];
}

extension SmsDirection on Sms {
  /// Whether this message was sent from the device (vs. received).
  ///
  /// The router encodes direction in [smstype]; observed values use "2" for
  /// sent and "1" for received. This is a best-effort mapping — adjust here if
  /// a device reports different codes.
  bool get isSent => smstype.trim() == '2';

  /// Parsed timestamp, or null when [smsDate] can't be parsed.
  DateTime? get sentAt => DateTime.tryParse(smsDate);
}
