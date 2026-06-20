import '../../constants.dart';

/// A client currently attached to the router's hotspot.
///
/// The `jsonp_device_management_all` endpoint only exposes the IP and MAC per
/// client — there is no friendly name, band or per-device usage in the payload.
class ConnectedDevice {
  final String ipAddress;
  final String macAddress;

  const ConnectedDevice({required this.ipAddress, required this.macAddress});

  factory ConnectedDevice.fromJson(Map<String, dynamic> json) =>
      ConnectedDevice(
        ipAddress: json['m__ip'] ?? cUnknownStr,
        macAddress: json['mac__address'] ?? cUnknownStr,
      );
}
