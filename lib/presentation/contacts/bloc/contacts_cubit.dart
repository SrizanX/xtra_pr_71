import 'package:flutter_bloc/flutter_bloc.dart';
import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsState());
}
