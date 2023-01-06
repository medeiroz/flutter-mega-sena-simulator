import 'package:flutter/material.dart';
import 'package:flutter_mega_sena_simulator/app/components/generate_button_widget.dart';
import 'package:flutter_mega_sena_simulator/app/components/number_input_widget.dart';
import 'package:flutter_mega_sena_simulator/app/components/result_number_widget.dart';
import 'package:flutter_mega_sena_simulator/app/modules/mega_sena/mega_sena.dart';
import 'package:flutter_mega_sena_simulator/app/pages/home_page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController(text: '1.000.000');
  final _numberMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###.###.###.###.###.###.###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
    initialText: '1.000.000',
  );

  List<int> _numbers = [];

  final MegaSena _megaSena = Modular.get();

  int _getNumber() {
    return int.parse(_numberMaskFormatter.getUnmaskedText());
  }

  void _generateNewNumbers() {
    setState(() {
      _numbers =
          _megaSena.generateAndGetMostFrequentNumbers(quantity: _getNumber());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: NumberInputWidget(
                  controller: _numberController,
                  maskFormatter: _numberMaskFormatter,
                ),
              ),
              Expanded(
                flex: 1,
                child: ResultNumberWidget(numbers: _numbers),
              )
            ],
          ),
        ),
      ),
      bottomSheet: GenerateButtonWidget(
        formKey: _formKey,
        onPressed: () async {
          if (_formKey.currentState?.validate() == true) {
            _generateNewNumbers();
          }
        },
      ),
    );
  }
}
