import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/apn_api_service.dart';
import '../../../data/network/model/state_response.dart';
import '../../../domain/entity/apn/apn_settings.dart';
import '../../../domain/result.dart';
import 'apn_state.dart';

class ApnCubit extends Cubit<ApnState> {
  ApnCubit() : super(ApnLoading()) {
    fetchApnSettings();
  }

  final _service = ApnApiService();

  void fetchApnSettings() async {
    emit(ApnLoading());
    final result = await _service.fetchApnSettings();
    if (isClosed) return;
    switch (result) {
      case Successful<ApnSettings>():
        emit(ApnSuccessful(settings: result.data));
      case Failed<ApnSettings>():
        emit(ApnFailed(errorMessage: result.message));
    }
  }

  /// Writes [apn] to the router. Returns true on success (and refreshes the
  /// stored settings); false if the request failed or the router rejected it.
  Future<bool> save(ApnSettings apn) async {
    final result = await _service.updateApn(apn);
    if (isClosed) return false;
    switch (result) {
      case Successful<StateResponse>():
        if (result.data.state != 1) return false;
        fetchApnSettings();
        return true;
      case Failed<StateResponse>():
        return false;
    }
  }
}
