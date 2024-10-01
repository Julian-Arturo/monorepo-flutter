import 'package:flutter/material.dart';
///
class PlanetsButton extends StatelessWidget {
  ///
  const PlanetsButton({required this.text, required this.onPressed, super.key});
  ///
  final String text;
  ///
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
