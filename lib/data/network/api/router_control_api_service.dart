import '../../../domain/result.dart';
import '../network_client.dart';

class RouterControlApiService {
  Future<Result<dynamic>> restart() async {
    const url = "http://192.168.0.1/jsonp_reset";
    return NetworkClient().get(Uri.parse(url));
  }

  Future<Result<dynamic>> powerOff() async {
    const url = "http://192.168.0.1/jsonp_power_off?callback=";
    return NetworkClient().get(Uri.parse(url));
  }
}
