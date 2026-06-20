// Realistic-looking canned data used to populate each screen for the Play
// Store screenshots. None of it touches the network — the fake cubits in
// fakes.dart emit these directly.

import 'package:xtra_pr_71/domain/entity/apn/apn_settings.dart';
import 'package:xtra_pr_71/domain/entity/contact/contact.dart';
import 'package:xtra_pr_71/domain/entity/device/connected_device.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/domain/entity/internet/internet_allowance.dart';
import 'package:xtra_pr_71/domain/entity/network_mode.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import 'package:xtra_pr_71/domain/entity/statistics/usage_statistics.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_connectivity_state.dart';
import 'package:xtra_pr_71/presentation/home/bloc/data_limit_state.dart';

/// Home dashboard device snapshot: charged battery, strong 4G, a few clients,
/// ~2 days uptime.
final DeviceInfo sampleDeviceInfo = DeviceInfo(
  '86', // batteryPercent
  '180000', // functionTimes (uptime seconds → "up 2d 2h")
  4, // hotcount (connected devices)
  '1.2.0', // hwVersion
  '350000000000000', // imei
  '470010100000000', // imsi
  '192.168.0.1', // ipAddress
  true, // issim
  'A0:B1:C2:D3:E4:F5', // macAddress
  '4G', // networkType
  '255.255.255.0', // networkmask
  '-67 dBm', // strengthDbm
  4, // strengthLevel (of 5)
  '1.0.3', // swVersion
  'XTRA-PR71', // wifihotname
  'WPA2/WPA3', // wifisafetype
  'SN2026XTRA0001', // sn
  12, // dashSinr
  3, // dashBand
  '89014103211118510720', // dashIccid
  '1.0.3', // devVersion
);

const UsageStatistics sampleStatistics = UsageStatistics(
  download: '8.42GB',
  upload: '1.20GB',
  speed: '1.20MB/s',
  total: '9.62GB',
);

const DataConnectivityState sampleConnectivity = DataConnectivityState(
  isLoading: false,
  isMobileDataEnabled: true,
  isRoamingEnabled: false,
  networkMode: NetworkMode.forthGeneration,
);

const DataLimitState sampleDataLimit = DataLimitState(
  isLoading: false,
  isUsageLimitEnabled: true,
  allowance: 5,
  allowanceUnit: AllowanceUnit.gb,
  totalUsed: '2.30GB',
);

final List<Contact> sampleContacts = [
  Contact(id: 1, name: 'Rafiul Islam', phone: '+8801712345678'),
  Contact(id: 2, name: 'Mom', phone: '+8801911111111'),
  Contact(id: 3, name: 'Office Reception', phone: '+8809612345678'),
  Contact(id: 4, name: 'Ayesha', phone: '+8801822223344'),
  Contact(id: 5, name: '', phone: '16263'),
];

final SmsApiEntity sampleSms = SmsApiEntity(
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
      smsDate: '2026-06-20 09:15:00',
      messageid: 1,
      classid: 0,
      singleCount: '1',
      smstype: '1', // received
    ),
    Sms(
      smsContent: 'Recharge of 100 BDT successful. Current balance 152.30 BDT.',
      phoneNumber: '+8801712345678',
      smsDate: '2026-06-20 08:02:00',
      messageid: 2,
      classid: 0,
      singleCount: '1',
      smstype: '1',
    ),
    Sms(
      smsContent: 'On my way, see you at 8!',
      phoneNumber: '+8801911111111',
      smsDate: '2026-06-19 19:40:00',
      messageid: 3,
      classid: 0,
      singleCount: '1',
      smstype: '2', // sent
    ),
    Sms(
      smsContent: 'Your 5GB data pack is now active for 30 days.',
      phoneNumber: 'XTRA',
      smsDate: '2026-06-18 21:30:00',
      messageid: 4,
      classid: 0,
      singleCount: '1',
      smstype: '1',
    ),
  ],
);

const ApnSettings sampleApn = ApnSettings(
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

const List<String> sampleBlockedMacs = [
  'A0:B1:C2:00:11:22',
  'AA:BB:CC:DD:EE:01',
];

const List<ConnectedDevice> sampleConnectedDevices = [
  ConnectedDevice(ipAddress: '192.168.0.101', macAddress: 'A0:B1:C2:D3:E4:01'),
  ConnectedDevice(ipAddress: '192.168.0.102', macAddress: 'B4:C5:D6:E7:F8:02'),
  // Matches a blocked MAC above so the "blocked" row styling shows.
  ConnectedDevice(ipAddress: '192.168.0.103', macAddress: 'A0:B1:C2:00:11:22'),
];

const String sampleUssdResponse =
    'Balance: 152.30 BDT\n'
    'Validity: 2026-07-15\n'
    'Data remaining: 4.8 GB\n\n'
    '1. Buy a pack\n'
    '2. Check usage\n'
    '0. Exit';
