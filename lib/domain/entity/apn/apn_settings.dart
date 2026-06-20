/// Identity-authentication options for an APN (maps to `mApnauthtype` 0–3).
enum ApnAuthType {
  none('None'),
  pap('PAP'),
  chap('CHAP'),
  papOrChap('PAP or CHAP');

  const ApnAuthType(this.label);
  final String label;

  static ApnAuthType fromCode(String? code) => switch (code) {
        '1' => ApnAuthType.pap,
        '2' => ApnAuthType.chap,
        '3' => ApnAuthType.papOrChap,
        _ => ApnAuthType.none,
      };
}

/// IP protocol options for an APN (used for both protocol and roaming).
enum ApnProtocol {
  ipv4('IPV4'),
  ipv6('IPV6'),
  ipv4v6('IPV4/IPV6');

  const ApnProtocol(this.label);
  final String label;

  /// The firmware is inconsistent: `mApnp` uses "IPV4V6" for the combined mode
  /// while `mApnrp` uses "IPV4/IPV6". Both are accepted here.
  static ApnProtocol parse(String? value) => switch (value?.toUpperCase()) {
        'IPV6' => ApnProtocol.ipv6,
        'IPV4V6' || 'IPV4/IPV6' => ApnProtocol.ipv4v6,
        _ => ApnProtocol.ipv4,
      };
}

/// Access Point Name configuration from `jsonp_pin_apn_setting`.
///
/// Values are stored raw (empty when unset) so they can pre-fill an editable
/// form; the read-only display substitutes "None" at render time.
class ApnSettings {
  final String name;
  final String apn;
  final String username;
  final String password;
  final String proxy;
  final String port;
  final String server;
  final String mmsc;
  final String mmsProxy;
  final String mmsPort;
  final String mcc;
  final String mnc;
  final String apnType;
  final String mvnoType;
  final ApnAuthType authType;
  final ApnProtocol protocol;
  final ApnProtocol roamingProtocol;

  const ApnSettings({
    required this.name,
    required this.apn,
    required this.username,
    required this.password,
    required this.proxy,
    required this.port,
    required this.server,
    required this.mmsc,
    required this.mmsProxy,
    required this.mmsPort,
    required this.mcc,
    required this.mnc,
    required this.apnType,
    required this.mvnoType,
    required this.authType,
    required this.protocol,
    required this.roamingProtocol,
  });

  factory ApnSettings.fromJson(Map<String, dynamic> json) {
    String text(Object? v) => v?.toString().trim() ?? '';
    return ApnSettings(
      name: text(json['mApnname']),
      apn: text(json['mApnapn']),
      username: text(json['mApnuser']),
      password: text(json['mApnpassword']),
      proxy: text(json['mApnproxy']),
      port: text(json['mApnport']),
      server: text(json['mApnserver']),
      mmsc: text(json['mApnmmsc']),
      mmsProxy: text(json['mApnmmsproxy']),
      mmsPort: text(json['mApnmmsport']),
      mcc: text(json['mApnmcc']),
      mnc: text(json['mApnmnc']),
      apnType: text(json['mApntype']),
      mvnoType: text(json['Apnmvnotype']),
      authType: ApnAuthType.fromCode(text(json['mApnauthtype'])),
      protocol: ApnProtocol.parse(text(json['mApnp'])),
      roamingProtocol: ApnProtocol.parse(text(json['mApnrp'])),
    );
  }
}
