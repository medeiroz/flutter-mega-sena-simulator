import 'package:flutter/material.dart';

class GenerateButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function() onPressed;

  const GenerateButtonWidget(
      {super.key, required this.formKey, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const Text('Gerar'),
      ),
    );
  }
}
