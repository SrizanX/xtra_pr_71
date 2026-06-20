/// Network configuration for the router's local HTTP API.
///
/// The PR71 exposes its JSONP-style endpoints on a fixed LAN address; keeping it
/// in one place means the base URL isn't duplicated across every service.
abstract final class ApiConfig {
  static const String baseUrl = "http://192.168.0.1";
}
