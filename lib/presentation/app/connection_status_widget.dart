import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/app/connection_status_cubit.dart';

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.phone_android),
            BlocBuilder<ConnectionStatusCubit, ConnectionStatusState>(
              builder: (context, state) {
                switch (state) {
                  case Connected():
                    return const Icon(
                      Icons.wifi,
                      color: Colors.green,
                    );
                  case Disconnected():
                    return const Icon(
                      Icons.wifi,
                      color: Colors.red,
                    );
                }
              },
            ),
            const Icon(Icons.router),
          ],
        ),
      ),
    );
  }
}
