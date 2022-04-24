import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String value;
  final VoidCallback pressedAction;
  const Button({required this.value, required this.pressedAction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: ElevatedButton(
          onPressed: pressedAction,
          child: Text(value),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => Colors.blue.shade800),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
              fixedSize: MaterialStateProperty.resolveWith<Size>(
                  (states) => const Size(20, 20))),
        ));
  }
}
