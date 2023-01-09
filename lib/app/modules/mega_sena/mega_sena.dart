import 'dart:isolate';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mega_sena_simulator/app/pages/home_page/home_page_state.dart';

class MegaSena {
  final Map<int, int> _numberFrequency = {};
  final gameDisplayKey = GlobalKey<HomePageState>();

  void generateGame() {
    var random = Random();
    var game = <int>{};
    for (int i = 0; i < 6; i++) {
      int number = random.nextInt(60) + 1;
      game.add(number);
      _numberFrequency[number] = (_numberFrequency[number] ?? 0) + 1;
    }
  }

  List<int> getMostGeneratedNumbers({int quantity = 6}) {
    final counts = _numberFrequency.entries.toList(growable: false)
      ..sort((entry1, entry2) => entry2.value.compareTo(entry1.value));
    return counts.take(quantity).map((entry) => entry.key).toList()..sort();
  }

  void reset() {
    _numberFrequency.clear();
  }

  Future<void> asyncGenerateGames(List<dynamic> arguments) async {
    final SendPort sendPort = arguments.first;
    final int quantity = arguments.last;

    sendPort.send({
      'type': 'update_status',
      'status': 'started',
      'value': [0],
      'progress': 0,
    });

    reset();

    for (int i = 0; i < quantity; i++) {
      generateGame();
      sendPort.send({
        'type': 'update_result',
        'status': 'running',
        'value': getMostGeneratedNumbers(),
        'progress': _calculateProgress(value: i, total: quantity)
      });
    }

    sendPort.send({
      'type': 'update_status',
      'status': 'finished',
      'value': getMostGeneratedNumbers(),
      'progress': 1.0,
    });
  }

  double _calculateProgress({
    required int value,
    required int total,
  }) {
    return value / total;
  }
}
