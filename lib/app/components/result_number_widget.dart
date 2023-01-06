import 'package:flutter/cupertino.dart';
import 'package:flutter_mega_sena_simulator/app/components/number_widget.dart';

class ResultNumberWidget extends StatelessWidget {
  final List<int> numbers;

  const ResultNumberWidget({super.key, required this.numbers});

  @override
  Widget build(BuildContext context) {
    final numbersWidgets =
        numbers.map((number) => NumberWidget(number: number)).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...numbersWidgets],
    );
  }
}
