import 'dart:convert';

import 'package:xtra_pr_71/data/network/mapper/base/result_mapper.dart';
import 'package:xtra_pr_71/data/network/mapper/state_response_mapper.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';

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

    var result = await NetworkClient().get(loginUriWithParams);
    var loginResult =
        ResultMapper().map(result: result, mapper: StateApiMapper());

    switch (loginResult) {
      case Successful<StateResponse>():
        if (loginResult.data.state == 1) {
          return Successful(data: loginResult.data);
        } else {
          return const Failed(message: "Invalid Credential");
        }
      case Failed<StateResponse>():
        return Failed(message: loginResult.message);
    }
  }
}
