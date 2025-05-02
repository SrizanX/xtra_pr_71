import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:xtra_pr_71/design/color_seleection.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import '../components/centered_progress_indicator.dart';
import 'bloc/sms_cubit.dart';
import 'bloc/sms_state.dart';

class SmsScreen extends StatelessWidget {
  const SmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize date formatting for Bengali locale
    initializeDateFormatting('bn', null);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: BlocBuilder<SmsCubit, SmsState>(
        builder: (context, state) {
          return state.when(
              initial: () => const CenteredProgressIndicator(),
              smsListSuccessful: (data) => _buildScreen(context, data),
              smsListFailed: () =>
                  const Center(child: Text("Error loading messages")));
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context, SmsApiEntity smsEntity) {
    return Column(
      children: [
        Expanded(
          child: _buildPaginatedSmsList(context, smsEntity),
        ),
        // Pagination controls at the bottom
        _buildPaginationControls(context, smsEntity),
      ],
    );
  }

  Widget _buildSmsList(BuildContext context, List<Sms> smsList) {
    return ListView.builder(
      itemCount: smsList.length,
      itemBuilder: (context, index) {
        return _buildSmsItem(context, smsList[index]);
      },
    );
  }

  Widget _buildPaginatedSmsList(BuildContext context, SmsApiEntity smsEntity) {
    if (smsEntity.data.isEmpty) {
      return const Center(child: Text("No messages found"));
    }

    return ListView.builder(
      itemCount: smsEntity.data.length,
      itemBuilder: (context, index) {
        return _buildSmsItem(context, smsEntity.data[index]);
      },
    );
  }

  Widget _buildPaginationControls(
      BuildContext context, SmsApiEntity smsEntity) {
    final currentPage = smsEntity.curPage;
    final totalPages = smsEntity.totalPage;

    // Don't show pagination controls if there's only one page
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorSelection.darkBlue.color,
        border: Border(
          top: BorderSide(
            color: ColorSelection.darkBlueTransparent.color,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicator text
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Page $currentPage of $totalPages',
              style: TextStyle(
                color: ColorSelection.white.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Navigation row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First page button
              if (currentPage > 2)
                _navIconButton(
                  context,
                  Icons.first_page,
                  () => context.read<SmsCubit>().fetchSms(1),
                  ColorSelection.blue_500.color,
                ),

              // Previous page button
              _navIconButton(
                context,
                Icons.arrow_back,
                currentPage > 1
                    ? () => context.read<SmsCubit>().fetchSms(currentPage - 1)
                    : null,
                currentPage > 1
                    ? ColorSelection.blue_500.color
                    : ColorSelection.darkBlueTransparent.color,
              ),

              // Compact pagination display for large page counts
              Expanded(
                child: Center(
                  child: _buildCompactPageNavigator(
                    context,
                    currentPage,
                    totalPages,
                    (page) => context.read<SmsCubit>().fetchSms(page),
                  ),
                ),
              ),

              // Next page button
              _navIconButton(
                context,
                Icons.arrow_forward,
                currentPage < totalPages
                    ? () => context.read<SmsCubit>().fetchSms(currentPage + 1)
                    : null,
                currentPage < totalPages
                    ? ColorSelection.blue_500.color
                    : ColorSelection.darkBlueTransparent.color,
              ),

              // Last page button
              if (currentPage < totalPages - 1)
                _navIconButton(
                  context,
                  Icons.last_page,
                  () => context.read<SmsCubit>().fetchSms(totalPages),
                  ColorSelection.blue_500.color,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navIconButton(
    BuildContext context,
    IconData icon,
    VoidCallback? onPressed,
    Color color,
  ) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildCompactPageNavigator(
    BuildContext context,
    int currentPage,
    int totalPages,
    Function(int) onPageSelected,
  ) {
    // For extremely large page counts, show a more compact UI
    List<Widget> pageButtons = [];

    // Calculate visible page range
    int startPage, endPage;

    if (totalPages <= 5) {
      // Show all pages if 5 or fewer
      startPage = 1;
      endPage = totalPages;
    } else {
      // On early pages
      if (currentPage <= 3) {
        startPage = 1;
        endPage = 5;
      }
      // On late pages
      else if (currentPage >= totalPages - 2) {
        startPage = math.max(1, totalPages - 4);
        endPage = totalPages;
      }
      // On middle pages
      else {
        startPage = currentPage - 2;
        endPage = currentPage + 2;
      }
    }

    // Build page buttons
    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(_pageButton(context, i, currentPage, onPageSelected));
    }

    return Container(
      height: 36,
      constraints: const BoxConstraints(maxWidth: 200),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: pageButtons,
        ),
      ),
    );
  }

  Widget _pageButton(
    BuildContext context,
    int pageNumber,
    int currentPage,
    Function(int) onPageSelected,
  ) {
    final bool isActive = pageNumber == currentPage;

    return InkWell(
      onTap: () => onPageSelected(pageNumber),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive
              ? ColorSelection.blue_500.color.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color:
                isActive ? ColorSelection.blue_500.color : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            color: isActive
                ? ColorSelection.white.color
                : ColorSelection.white.color.withOpacity(0.6),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _ellipsis() {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(
          color: ColorSelection.white.color.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildSmsItem(BuildContext context, Sms sms) {
    final DateFormat formatter = DateFormat('EEEE, d MMMM, h:mm a', 'en');
    final String formattedDate = formatter.format(DateTime.parse(sms.smsDate));

    return ListTile(
      leading: const Icon(Icons.sms_outlined),
      title: Text(sms.phoneNumber), // 1-based numbering
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sms.smsContent),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(formattedDate),
          )
        ],
      ),
    );
  }
}
