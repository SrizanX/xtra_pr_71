import '../../../domain/result.dart';
import '../network_client.dart';
import 'api_config.dart';

class RouterControlApiService {
  Future<Result<dynamic>> restart() async {
    const url = "${ApiConfig.baseUrl}/jsonp_reset";
    return NetworkClient().get(Uri.parse(url));
  }

  Future<Result<dynamic>> powerOff() async {
    const url = "${ApiConfig.baseUrl}/jsonp_power_off?callback=";
    return NetworkClient().get(Uri.parse(url));
  }
}
