import 'dart:convert';

import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/domain/type.dart';

import '../network_client.dart';

class LoginApiService {
  Future<Result<StateResponse>> callLoginAPi(
      {required String username, required String password}) async {
    const url = "http://192.168.0.1/adminLogin";
    // Set up parameters
    final param = {
      "username": username,
      "password": password,
    };
    final loginUri = Uri.parse(url);
    final loginUriWithParams =
        loginUri.replace(queryParameters: {'loginparam': jsonEncode(param)});
    var client = NetworkClient();
    var loginResult = await client.get(loginUriWithParams);
    switch (loginResult) {
      case Successful():
        final decodedJson = jsonDecode(loginResult.data) as JMap;
        final state =  StateResponse.fromJson(decodedJson);

        if(state.state==1) {
          return Successful(data: state);
        } else {
          return const Failed(message: "Invalid Credential");
        }
      case Failed():
        return  Failed(message: loginResult.message);
    }
  }
}
