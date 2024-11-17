import '../../../domain/type.dart';

class StateResponse {
  int state;

  StateResponse({required this.state});

  factory StateResponse.fromJson(JMap json) =>
      StateResponse(state: json['state']);
}
