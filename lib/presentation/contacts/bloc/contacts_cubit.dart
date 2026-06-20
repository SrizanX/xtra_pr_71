import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/contacts_api_service.dart';
import '../../../data/network/model/state_response.dart';
import '../../../domain/entity/contact/contact.dart';
import '../../../domain/result.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsLoading()) {
    fetchContacts();
  }

  final _service = ContactsApiService();

  /// Loads every page of contacts (the router pages them) into one list.
  void fetchContacts() async {
    emit(ContactsLoading());
    final all = <Contact>[];
    var page = 1;
    var totalPage = 1;
    while (page <= totalPage) {
      final result = await _service.fetchContacts(page);
      if (isClosed) return;
      switch (result) {
        case Successful<ContactListPage>():
          for (final c in result.data.data) {
            c.page = result.data.curPage;
          }
          all.addAll(result.data.data);
          totalPage = result.data.totalPage;
          page++;
        case Failed<ContactListPage>():
          // Surface the error only if we have nothing; otherwise show what
          // loaded so far.
          if (all.isEmpty) {
            emit(ContactsFailed(errorMessage: result.message));
          } else {
            emit(ContactsSuccessful(contacts: all));
          }
          return;
      }
    }
    emit(ContactsSuccessful(contacts: all));
  }

  Future<bool> addContact({required String name, required String phone}) =>
      _mutate(() => _service.addContact(name: name, phone: phone));

  Future<bool> deleteContacts(List<Contact> contacts) async {
    if (contacts.isEmpty) return false;
    return _mutate(() => _service.deleteContacts(contacts));
  }

  /// Runs a write [action], reloads on success, and reports whether it stuck.
  Future<bool> _mutate(Future<Result<StateResponse>> Function() action) async {
    _setBusy(true);
    final result = await action();
    if (isClosed) return false;
    final ok = result is Successful<StateResponse> && result.data.state == 1;
    if (ok) {
      fetchContacts();
    } else {
      _setBusy(false);
    }
    return ok;
  }

  void _setBusy(bool busy) {
    final current = state;
    if (current is ContactsSuccessful) {
      emit(ContactsSuccessful(contacts: current.contacts, isBusy: busy));
    }
  }
}
