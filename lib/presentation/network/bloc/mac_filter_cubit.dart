import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/mac_filter_api_service.dart';
import '../../../domain/entity/mac_filter/mac_filter.dart';
import '../../../domain/result.dart';
import '../../../data/network/model/state_response.dart';
import 'mac_filter_state.dart';

class MacFilterCubit extends Cubit<MacFilterState> {
  MacFilterCubit() : super(const MacFilterState()) {
    fetchMacFilter();
  }

  final _service = MacFilterApiService();

  void fetchMacFilter() async {
    emit(state.copyWith(isBusy: true));
    final result = await _service.fetchMacFilters();
    if (isClosed) return;
    switch (result) {
      case Successful<MacFilter>():
        emit(state.copyWith(
          isReady: true,
          isBusy: false,
          denyEnabled: result.data.denyEnabled,
          macs: result.data.macs,
          issim: result.data.issim,
        ));
      case Failed<MacFilter>():
        emit(state.copyWith(
          isReady: true,
          isBusy: false,
          message: result.message,
        ));
    }
  }

  /// Turns the deny filter on/off, keeping the current list.
  void setDenyEnabled(bool enabled) =>
      _apply(macs: state.macs, denyEnabled: enabled);

  /// Replaces the whole blocklist (from the editor screen) and enables the
  /// deny filter so it takes effect.
  void saveBlocklist(List<String> macs) =>
      _apply(macs: macs, denyEnabled: true);

  /// Adds [mac] to the blocklist and ensures the deny filter is on so it takes
  /// effect. No-op (with a message) if already listed or the list is full.
  void blockMac(String mac) {
    final normalized = mac.trim();
    if (normalized.isEmpty) return;
    if (state.contains(normalized)) {
      emit(state.copyWith(message: 'Already blocked'));
      return;
    }
    if (state.macs.length >= MacFilter.maxEntries) {
      emit(state.copyWith(
        message: 'Blocklist is full (${MacFilter.maxEntries} max)',
      ));
      return;
    }
    _apply(macs: [...state.macs, normalized], denyEnabled: true);
  }

  /// Removes [mac] from the blocklist, keeping the current mode.
  void unblockMac(String mac) {
    final next = state.macs
        .where((m) => m.toLowerCase() != mac.toLowerCase())
        .toList();
    _apply(macs: next, denyEnabled: state.denyEnabled);
  }

  void _apply({required List<String> macs, required bool denyEnabled}) async {
    final previous = state;
    // Optimistically reflect the change while the request is in flight.
    emit(state.copyWith(isBusy: true, macs: macs, denyEnabled: denyEnabled));
    final result =
        await _service.applyMacFilter(macs: macs, denyEnabled: denyEnabled);
    if (isClosed) return;
    switch (result) {
      case Successful<StateResponse>():
        emit(state.copyWith(isBusy: false));
      case Failed<StateResponse>():
        // Revert to the previous list/mode on failure.
        emit(previous.copyWith(isBusy: false, message: result.message));
    }
  }
}
