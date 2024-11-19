import 'dart:convert';

import '../../../domain/type.dart';
import '../model/state_response.dart';
import 'base/mapper.dart';

class StateApiMapper extends Mapper<dynamic, StateResponse> {
  @override
  StateResponse map(input) {
    return StateResponse.fromJson(jsonDecode(input) as JMap);
  }
}
