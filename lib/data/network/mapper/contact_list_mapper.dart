import 'dart:convert';

import '../../../domain/entity/contact/contact.dart';
import '../../../domain/type.dart';
import 'base/mapper.dart';

/// Maps the `ContactList` response (plain JSON, paginated like the SMS list).
class ContactListMapper extends Mapper<dynamic, ContactListPage> {
  @override
  ContactListPage map(input) =>
      ContactListPage.fromJson(jsonDecode(input) as JMap);
}
