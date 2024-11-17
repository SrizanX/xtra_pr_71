class NetworkInfo {
  bool isDataOpen;
  bool isRoaming;
  bool issim;
  int netType;

  NetworkInfo({
    required this.isDataOpen,
    required this.isRoaming,
    required this.issim,
    required this.netType,
  });

  factory NetworkInfo.fromJson(Map<String, dynamic> json) => NetworkInfo(
        isDataOpen: json['isDataOpen'] == "true",
        isRoaming: json['isRoaming'] == "true",
        issim: json['issim'] == "true",
        netType: int.parse(json['netType']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isDataOpen': isDataOpen,
        'isRoaming': isRoaming,
        'issim': issim,
        'netType': netType,
      };
}
