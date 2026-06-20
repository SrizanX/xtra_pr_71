import '../../domain/entity/apn/apn_settings.dart';
import '../../domain/entity/contact/contact.dart';
import '../../domain/entity/device/connected_device.dart';
import '../../domain/entity/device_info.dart';
import '../../domain/entity/internet/internet_allowance.dart';
import '../../domain/entity/internet/network_info.dart';
import '../../domain/entity/mac_filter/mac_filter.dart';
import '../../domain/entity/sms/sms.dart';
import '../../domain/entity/statistics/usage_statistics.dart';
import '../../domain/entity/system/time_status.dart';
import '../../domain/entity/wireless/wireless_info.dart';
import '../network/model/state_response.dart';

/// Canned data served by every API service while [DemoMode] is on. The values
/// mirror the Play Store screenshots so the demo and the listing look alike.
abstract final class DemoData {
  /// Generic "router accepted the write" response for demo writes/toggles.
  static StateResponse get ok => StateResponse(state: 1);

  static DeviceInfo get deviceInfo => DeviceInfo(
        '86', // batteryPercent
        '180000', // functionTimes (uptime → "up 2d 2h")
        4, // hotcount
        '1.2.0', // hwVersion
        '350000000000000', // imei
        '470010100000000', // imsi
        '192.168.0.1', // ipAddress
        true, // issim
        'A0:B1:C2:D3:E4:F5', // macAddress
        '4G', // networkType
        '255.255.255.0', // networkmask
        '-67 dBm', // strengthDbm
        4, // strengthLevel
        '1.0.3', // swVersion
        'XTRA-PR71', // wifihotname
        'WPA2/WPA3', // wifisafetype
        'SN2026XTRA0001', // sn
        12, // dashSinr
        3, // dashBand
        '89014103211118510720', // dashIccid
        '1.0.3', // devVersion
      );

  static const UsageStatistics statistics = UsageStatistics(
    download: '8.42GB',
    upload: '1.20GB',
    speed: '1.20MB/s',
    total: '9.62GB',
  );

  static NetworkInfo get networkInfo => NetworkInfo(
        isDataOpen: true,
        isRoaming: false,
        issim: true,
        netType: 2, // 4G
      );

  static InternetAllowanceEntity get allowance => InternetAllowanceEntity(
        allowanceData: '5GB',
        dataLimit: true,
        issim: true,
        totalUsed: '2.30GB',
      );

  static const MacFilter macFilter = MacFilter(
    denyEnabled: true,
    macs: ['A0:B1:C2:00:11:22', 'AA:BB:CC:DD:EE:01'],
    issim: true,
  );

  static const List<ConnectedDevice> connectedDevices = [
    ConnectedDevice(ipAddress: '192.168.0.101', macAddress: 'A0:B1:C2:D3:E4:01'),
    ConnectedDevice(ipAddress: '192.168.0.102', macAddress: 'B4:C5:D6:E7:F8:02'),
    ConnectedDevice(ipAddress: '192.168.0.103', macAddress: 'A0:B1:C2:00:11:22'),
  ];

  static const ApnSettings apn = ApnSettings(
    name: 'XTRA Internet',
    apn: 'xtra.net.bd',
    username: '',
    password: '',
    proxy: '',
    port: '',
    server: '',
    mmsc: '',
    mmsProxy: '',
    mmsPort: '',
    mcc: '470',
    mnc: '01',
    apnType: 'default',
    mvnoType: '',
    authType: ApnAuthType.none,
    protocol: ApnProtocol.ipv4v6,
    roamingProtocol: ApnProtocol.ipv4,
  );

  static WirelessInfo get wireless => WirelessInfo.fromJson(const {
        'm__ip': 'XTRA-PR71',
        'mac__address': 'demo1234',
        'bandtype': '0',
        'iswifihot': '1',
        'maxnum': '10',
        'wifitype': '4',
        'isHide': 'false',
        'isClose': 'false',
      });

  static const TimeStatus timeStatus = TimeStatus(
    isAutoTimezone: true,
    time: '2026-06-21 14:30',
    timezone: '0',
  );

  static const String ussdResponse =
      'Balance: 152.30 BDT\n'
      'Validity: 2026-07-15\n'
      'Data remaining: 4.8 GB\n\n'
      '1. Buy a pack\n'
      '2. Check usage\n'
      '0. Exit';

  static ContactListPage get contacts => ContactListPage(
        curPage: 1,
        totalPage: 1,
        totalRecords: 5,
        data: [
          Contact(id: 1, name: 'Rafiul Islam', phone: '+8801712345678'),
          Contact(id: 2, name: 'Mom', phone: '+8801911111111'),
          Contact(id: 3, name: 'Office Reception', phone: '+8809612345678'),
          Contact(id: 4, name: 'Ayesha', phone: '+8801822223344'),
          Contact(id: 5, name: '', phone: '16263'),
        ],
      );

  static SmsApiEntity get sms => SmsApiEntity(
        curPage: 1,
        startRowNum: 1,
        endRowNum: 4,
        recordsPerpage: 10,
        totalRecords: 4,
        totalPage: 1,
        data: [
          Sms(
            smsContent: 'Your OTP is 481920. Do not share it with anyone.',
            phoneNumber: 'VERIFY',
            smsDate: '2026-06-21 09:15:00',
            messageid: 1,
            classid: 0,
            singleCount: '1',
            smstype: '1',
          ),
          Sms(
            smsContent:
                'Recharge of 100 BDT successful. Current balance 152.30 BDT.',
            phoneNumber: '+8801712345678',
            smsDate: '2026-06-21 08:02:00',
            messageid: 2,
            classid: 0,
            singleCount: '1',
            smstype: '1',
          ),
          Sms(
            smsContent: 'On my way, see you at 8!',
            phoneNumber: '+8801911111111',
            smsDate: '2026-06-20 19:40:00',
            messageid: 3,
            classid: 0,
            singleCount: '1',
            smstype: '2',
          ),
          Sms(
            smsContent: 'Your 5GB data pack is now active for 30 days.',
            phoneNumber: 'XTRA',
            smsDate: '2026-06-19 21:30:00',
            messageid: 4,
            classid: 0,
            singleCount: '1',
            smstype: '1',
          ),
        ],
      );
}
