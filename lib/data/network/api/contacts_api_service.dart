import 'dart:convert';

import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/contact/contact.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/contact_list_mapper.dart';
import '../mapper/state_response_mapper.dart';
import '../model/state_response.dart';
import 'api_config.dart';

class ContactsApiService {
  Future<Result<ContactListPage>> fetchContacts(int page) async {
    if (DemoMode.enabled) return Successful(data: DemoData.contacts);
    final url = "${ApiConfig.baseUrl}/ContactList?pageIndex=$page";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: ContactListMapper());
  }

  /// Adds a contact via `AddContactList?MessageList={"pnumber":…,"content":…}`
  /// where `content` is the contact name.
  Future<Result<StateResponse>> addContact({
    required String name,
    required String phone,
  }) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final body = {"pnumber": phone, "content": name};
    const url = "${ApiConfig.baseUrl}/AddContactList";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"MessageList": jsonEncode(body)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }

  /// Deletes contacts via `DeleteContactList?deleList=[{"id":…,"curpage":…}]`.
  Future<Result<StateResponse>> deleteContacts(List<Contact> contacts) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final param = [
      for (final c in contacts) {"id": c.id, "curpage": c.page},
    ];
    const url = "${ApiConfig.baseUrl}/DeleteContactList";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"deleList": jsonEncode(param)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
