/// A SIM/phonebook contact from the router's `ContactList` endpoint.
///
/// The router is inconsistent: the read response uses `smsName` (name) and
/// `phoneNumber` (phone), while the add request uses `content`/`pnumber`. Both
/// read shapes are tolerated here. [page] records which page it was loaded from
/// — the delete endpoint needs it as `curpage`.
class Contact {
  final int id;
  final String name;
  final String phone;
  int page;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.page = 0,
  });

  /// Display label: the name, falling back to the number when unnamed.
  String get displayName => name.trim().isEmpty ? phone : name;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: _int(json['contactid']),
        name: (json['smsName'] ?? json['content'] ?? '').toString(),
        phone: (json['phoneNumber'] ?? json['pnumber'] ?? '').toString(),
      );
}

/// One page of the paginated contacts response (mirrors the SMS `PageList`).
class ContactListPage {
  final int curPage;
  final int totalPage;
  final int totalRecords;
  final List<Contact> data;

  ContactListPage({
    required this.curPage,
    required this.totalPage,
    required this.totalRecords,
    required this.data,
  });

  factory ContactListPage.fromJson(Map<String, dynamic> json) =>
      ContactListPage(
        curPage: _int(json['curPage'], 1),
        totalPage: _int(json['totalPage'], 1),
        totalRecords: _int(json['totalRecords']),
        data: ((json['data'] as List?) ?? const [])
            .map((e) => Contact.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}

int _int(Object? value, [int fallback = 0]) =>
    value is int ? value : int.tryParse('$value') ?? fallback;
