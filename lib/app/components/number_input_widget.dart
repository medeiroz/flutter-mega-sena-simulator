import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NumberInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final MaskTextInputFormatter maskFormatter;

  const NumberInputWidget({
    super.key,
    required this.controller,
    required this.maskFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [maskFormatter],
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.numbers),
        ),
        labelText: 'Quantidade de jogos a serem gerados',
      ),
    );
  }
}
