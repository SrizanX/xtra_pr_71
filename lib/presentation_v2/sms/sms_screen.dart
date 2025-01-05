import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import 'package:xtra_pr_71/presentation_v2/components/centered_progress_indicator.dart';
import 'package:xtra_pr_71/presentation_v2/sms/bloc/sms_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/sms/bloc/sms_state.dart';

class SmsScreen extends StatelessWidget {
  const SmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: BlocBuilder<SmsCubit, SmsState>(
        builder: (context, state) {
          return state.when(
              initial: () => const CenteredProgressIndicator(),
              smsListSuccessful: (data) => _buildScreen(context, data),
              smsListFailed: () => const Text("Error"));
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context, SmsApiEntity smsEntity) {
    return Column(
      children: [
        Expanded(
          child: _buildSmsList(context, smsEntity.data),
        )
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

  Widget _buildPaginatedSmsList(BuildContext context, List<Sms> smsList) {


    return ListView.builder(
      itemCount: smsList.length,
      itemBuilder: (context, index) {
        return _buildSmsItem(context, smsList[index]);
      },
    );
  }

  Widget _buildSmsItem(BuildContext context, Sms sms) {
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
            child: Text(sms.smsDate),
          )
        ],
      ),
    );
  }
}
