import 'dart:math';

import 'package:flutter_mega_sena_simulator/app/modules/mega_sena/most_frequent_numbers.dart';
import 'package:flutter_mega_sena_simulator/app/modules/mega_sena/number_generator.dart';

class MegaSena implements NumberGenerator, MostFrequentNumbers {
  int maxNumber = 60;
  Map<int, int> numberWithCounter = {};

  @override
  void generateNumbers(int quantity) async {
    numberWithCounter = {};
    final numbers = <int>[];

    for (int i = 0; i < quantity; i++) {
      final number = Random().nextInt(maxNumber) + 1;
      numbers.add(number);
    }

    for (final number in numbers) {
      numberWithCounter[number] = (numberWithCounter[number] ?? 0) + 1;
    }
  }

  @override
  List<int> getMostFrequentNumbers(int quantity) {
    final sortedCounts = numberWithCounter.entries.toList(growable: false)
      ..sort((entry1, entry2) => entry2.value.compareTo(entry1.value));
    return sortedCounts.take(quantity).map((entry) => entry.key).toList()
      ..sort();
  }

  List<int> generateAndGetMostFrequentNumbers({
    int quantity = 100000,
    int mostFrequentQuantity = 6,
  }) {
    generateNumbers(quantity);
    return getMostFrequentNumbers(mostFrequentQuantity);
  }

  MegaSena setMaxNumber(int maxNumber) {
    if (maxNumber < 1) {
      throw Exception('The maximum number must be greater than zero.');
    }
    this.maxNumber = maxNumber;

    return this;
  }
}
