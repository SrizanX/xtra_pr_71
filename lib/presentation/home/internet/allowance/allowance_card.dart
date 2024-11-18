import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/internet/allowance/allowance_cubit.dart';
import 'package:xtra_pr_71/presentation/home/internet/allowance/allowance_state.dart';

class AllowanceCard extends StatelessWidget {
  const AllowanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllowanceCubit, AllowanceState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Data Usage Limit",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch(
                          value: state.isUsageLimitEnabled,
                          onChanged: (val) {
                            context
                                .read<AllowanceCubit>()
                                .updateMobileData(val);
                          }),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Text(
                        "Total Allowance",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(), gapPadding: 0),
                              hintText: "0"),
                          initialValue: "${state.allowance}",
                          onChanged: (val) {
                            context
                                .read<AllowanceCubit>()
                                .updateAllowance(int.tryParse(val) ?? 0);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      )),
                      DropdownButton<AllowanceUnit>(
                        value: state.allowanceUnit,
                        items: AllowanceUnit.values
                            .map(
                              (mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode.label),
                              ),
                            )
                            .toList(),
                        onChanged: (selected) {
                          context
                              .read<AllowanceCubit>()
                              .updateAllowanceUnit(selected);
                        },
                      ),
                    ],
                  ),
                  FilledButton(
                      onPressed: () {
                        context.read<AllowanceCubit>().apply();
                      },
                      child: const Text("Apply"))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

enum AllowanceUnit {
  mb(label: "MB", multiplier: 1024 * 1024),
  gb(label: "GB", multiplier: 1024 * 1024 * 1024);

  final String label;
  final num multiplier;

  const AllowanceUnit({required this.label, required this.multiplier});
}
