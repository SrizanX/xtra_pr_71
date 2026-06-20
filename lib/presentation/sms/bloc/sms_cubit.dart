import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_state.dart';
import '../../../data/network/api/sms_api_service.dart';

class SmsCubit extends Cubit<SmsState> {
  SmsCubit() : super(const SmsState.initial()) {
    fetchAllSms();
  }

  /// Ensures only one background loader runs at a time.
  bool _isLoadingPages = false;

  /// Bumped on every fresh load so an in-flight background loader from a
  /// previous load (e.g. before a pull-to-refresh) knows to stop.
  int _epoch = 0;

  /// When true, the background page loader stops after its current request.
  /// Set while the Messages screen is off-screen so we don't keep hammering
  /// the router for pages the user has navigated away from.
  bool _paused = false;

  /// Stops the background loader (it resumes from where it left off later).
  void pauseLoading() => _paused = true;

  /// Resumes loading any remaining pages once the screen is visible again.
  void resumeLoading() {
    if (!_paused) return;
    _paused = false;
    _loadRemainingPages(_epoch);
  }

  /// Loads the first page and shows it immediately, then loads every remaining
  /// page in the background.
  ///
  /// Background loading (rather than waiting for scroll) is deliberate: the
  /// Messages UI groups messages into conversations by phone number, and the
  /// router pages globally, so a single conversation's messages are spread
  /// across pages. A conversation is only complete once all pages are loaded —
  /// so we keep loading them without blocking the first render.
  void fetchAllSms() async {
    final epoch = ++_epoch;
    _isLoadingPages = false;
    _paused = false;
    emit(const SmsState.initial());

    final first = await SmsApiService().fetchSms(1);
    if (isClosed || epoch != _epoch) return; // closed or superseded
    if (first is! Successful<SmsApiEntity>) {
      emit(SmsState.smsListFailed(
          message: (first as Failed<SmsApiEntity>).message));
      return;
    }

    _tagPage(first.data);
    emit(
      SmsState.smsListSuccessful(
        sms: first.data,
        loadedPage: 1,
        totalPage: first.data.totalPage,
      ),
    );

    _loadRemainingPages(epoch);
  }

  /// Nudges the background loader along; the list's scroll handler can call
  /// this, but completeness no longer depends on scrolling.
  Future<void> loadMore() => _loadRemainingPages(_epoch);

  /// Loads a single page in isolation (used by the legacy paged SMS screen).
  void fetchSms(int page) async {
    ++_epoch; // cancel any background loader
    _isLoadingPages = false;
    emit(const SmsState.initial());
    final result = await SmsApiService().fetchSms(page);
    switch (result) {
      case Successful<SmsApiEntity>():
        emit(
          SmsState.smsListSuccessful(
            sms: result.data,
            loadedPage: result.data.curPage,
            totalPage: result.data.totalPage,
          ),
        );
      case Failed<SmsApiEntity>():
        emit(SmsState.smsListFailed(message: result.message));
    }
  }

  /// Records the source page on each message so the delete endpoint can send
  /// the right `curpage` (the merged list otherwise loses page boundaries).
  void _tagPage(SmsApiEntity entity) {
    for (final message in entity.data) {
      message.page = entity.curPage;
    }
  }

  /// Deletes [messages] (e.g. a whole conversation), then reloads — pages
  /// re-index after a deletion, so a fresh fetch keeps `page` accurate.
  /// Returns true when the router confirms the deletion.
  Future<bool> deleteMessages(List<Sms> messages) async {
    if (messages.isEmpty) return false;
    final result = await SmsApiService().deleteMessages(messages);
    if (isClosed) return false;
    switch (result) {
      case Successful<StateResponse>():
        if (result.data.state != 1) return false;
        fetchAllSms();
        return true;
      case Failed<StateResponse>():
        return false;
    }
  }

  /// Sequentially fetches and appends every page after the one already loaded,
  /// stopping if a newer load supersedes this [epoch] or a page fails.
  Future<void> _loadRemainingPages(int epoch) async {
    if (_isLoadingPages) return;
    _isLoadingPages = true;
    try {
      // Stops when superseded by a newer load, or paused (screen hidden).
      while (epoch == _epoch && !_paused) {
        final current = state;
        if (current is! SmsListSuccessful ||
            current.loadedPage >= current.totalPage) {
          break;
        }

        final nextPage = current.loadedPage + 1;
        final result = await SmsApiService().fetchSms(nextPage);
        if (isClosed || epoch != _epoch) break;

        final latest = state;
        if (latest is! SmsListSuccessful) break;
        if (result is! Successful<SmsApiEntity>) break; // stop on error

        _tagPage(result.data);
        latest.sms.data.addAll(result.data.data);
        emit(
          SmsState.smsListSuccessful(
            sms: latest.sms,
            loadedPage: nextPage,
            totalPage: latest.totalPage,
          ),
        );
      }
    } finally {
      _isLoadingPages = false;
    }
  }
}
