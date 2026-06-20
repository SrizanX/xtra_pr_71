import 'package:flutter/material.dart';

import '../../../design/design_system.dart';

class PowerButton extends StatelessWidget {
  final void Function()? onPressed;

  /// Diameter of the button. Defaults to the responsive size for the current
  /// device when not provided.
  final double? size;

  const PowerButton({
    super.key,
    this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimensions.of(context);
    final diameter = size ?? dimens.powerButtonSize;
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        height: diameter,
        width: diameter,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff5492f7),
                  Color(0xffa7e1ec),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey,
                    spreadRadius: 30,
                    blurRadius: 100,
                    offset: Offset(0, 80)),
              ]),
          child: Icon(
            Icons.power_settings_new,
            color: Colors.white,
            size: dimens.powerIconSize,
          ),
        ),
      ),
    );
  }
}
