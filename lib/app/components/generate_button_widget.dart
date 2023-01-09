import 'package:flutter/material.dart';

class GenerateButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final double progress;

  const GenerateButtonWidget({
    super.key,
    required this.onPressed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('Gerar'),
            ),
          ],
        ));
  }
}
