import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import 'package:xtra_pr_71/presentation_v2/sms/bloc/sms_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/sms/bloc/sms_state.dart';

class SmsScreen extends StatelessWidget {
  const SmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SmsCubit, SmsState>(
        builder: (context, state) {
          return state.when(
              initial: () => CircularProgressIndicator(),
              smsListSuccessful: (data) => ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    return buildSmsItem(context, data.data[index]);
                  }),
              smsListFailed: () => Text("Error"));
        },
      ),
    );
  }

  Widget buildSmsItem(BuildContext context, Sms sms) {
    return ListTile(
      leading: const Icon(Icons.sms_outlined),
      title: Text(sms.phoneNumber), // 1-based numbering
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sms.smsContent),
          SizedBox(
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
