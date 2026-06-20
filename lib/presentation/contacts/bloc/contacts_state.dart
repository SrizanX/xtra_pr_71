import '../../../domain/entity/contact/contact.dart';

sealed class ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsFailed extends ContactsState {
  final String errorMessage;
  ContactsFailed({required this.errorMessage});
}

class ContactsSuccessful extends ContactsState {
  final List<Contact> contacts;

  /// True while an add/delete request is in flight.
  final bool isBusy;

  ContactsSuccessful({required this.contacts, this.isBusy = false});
}
