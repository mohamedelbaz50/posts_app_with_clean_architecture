import 'package:flutter/material.dart';

class CustonButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final String text;
  final Color color;
  const CustonButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(icon),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(color),
        ),
        onPressed: () {
          onPressed();
        },
        label: Text(text));
  }
}
