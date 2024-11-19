import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/internet/allowance/allowance_cubit.dart';
import 'package:xtra_pr_71/presentation/home/internet/connection/connection_card.dart';
import 'package:xtra_pr_71/presentation/home/internet/internet_cubit.dart';

import 'allowance/allowance_card.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (BuildContext context) => InternetCubit()..fetchConStat()),
        BlocProvider<AllowanceCubit>(
            create: (BuildContext context) => AllowanceCubit()..fetchConStat()),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Internet"),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.network_cell)),
              Tab(icon: Icon(Icons.bar_chart)),
              Tab(icon: Icon(Icons.settings)),
            ]),
          ),
          body: const TabBarView(children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(children: [ConnectionCard()]),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(children: [AllowanceCard()]),
                )),
            Padding(padding: EdgeInsets.all(16), child: Text("Apn Settings")),
          ]),
        ),
      ),
    );
  }
}
