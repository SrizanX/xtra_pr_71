import 'package:flutter/material.dart';

import '../../domain/entity/operator/mobile_operator.dart';

typedef QuickCode = ({String label, String code, IconData icon});

/// Common USSD shortcuts per Bangladesh operator. Codes can change over time —
/// verify against the operator before relying on them.
const _operatorCodes = <MobileOperator, List<QuickCode>>{
  MobileOperator.grameenphone: [
    (label: 'Balance', code: '*566#', icon: Icons.account_balance_wallet),
    (label: 'My number', code: '*2#', icon: Icons.badge),
    (label: 'Internet balance', code: '*121*1*4#', icon: Icons.data_usage),
    (label: 'Minute balance', code: '*121*1*2#', icon: Icons.call),
    (label: 'Packages', code: '*121#', icon: Icons.sell),
  ],
  MobileOperator.robi: [
    (label: 'Balance', code: '*222#', icon: Icons.account_balance_wallet),
    (label: 'My number', code: '*2#', icon: Icons.badge),
    (label: 'Internet balance', code: '*8444*88#', icon: Icons.data_usage),
    (label: 'Minute balance', code: '*222*2#', icon: Icons.call),
    (label: 'Packages', code: '*123#', icon: Icons.sell),
  ],
  MobileOperator.banglalink: [
    (label: 'Balance', code: '*124#', icon: Icons.account_balance_wallet),
    (label: 'My number', code: '*511#', icon: Icons.badge),
    (label: 'Internet balance', code: '*5000*500#', icon: Icons.data_usage),
    (label: 'Minute balance', code: '*124*2#', icon: Icons.call),
    (label: 'Packages', code: '*888#', icon: Icons.sell),
  ],
  MobileOperator.teletalk: [
    (label: 'Balance', code: '*152#', icon: Icons.account_balance_wallet),
    (label: 'My number', code: '*551#', icon: Icons.badge),
    (label: 'Internet balance', code: '*152#', icon: Icons.data_usage),
    (label: 'Packages', code: '*111#', icon: Icons.sell),
  ],
  MobileOperator.airtel: [
    (label: 'Balance', code: '*778#', icon: Icons.account_balance_wallet),
    (label: 'My number', code: '*121*6*3#', icon: Icons.badge),
    (label: 'Internet balance', code: '*778*5#', icon: Icons.data_usage),
    (label: 'Minute balance', code: '*778*8#', icon: Icons.call),
    (label: 'Packages', code: '*121#', icon: Icons.sell),
  ],
};

/// Generic fallback when the operator can't be determined.
const _genericCodes = <QuickCode>[
  (label: 'Self-Service', code: '*121#', icon: Icons.support),
];
/// Mobile financial services — operator-independent, shown for any SIM.
const mfsCodes = <QuickCode>[
  (label: 'bKash', code: '*247#', icon: Icons.account_balance_wallet),
  (label: 'Nagad', code: '*167#', icon: Icons.account_balance_wallet),
  (label: 'Rocket', code: '*322#', icon: Icons.account_balance_wallet),
];

List<QuickCode> quickCodesFor(MobileOperator operator) =>
    _operatorCodes[operator] ?? _genericCodes;
