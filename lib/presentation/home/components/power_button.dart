import 'package:flutter/material.dart';

class PowerButton extends StatelessWidget {
  final void Function()? onPressed;

  const PowerButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        height: 80,
        width: 80,
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
          child: const Icon(
            Icons.power_settings_new,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
