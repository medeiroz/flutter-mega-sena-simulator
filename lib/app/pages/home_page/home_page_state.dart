import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_mega_sena_simulator/app/components/generate_button_widget.dart';
import 'package:flutter_mega_sena_simulator/app/components/result_number_widget.dart';
import 'package:flutter_mega_sena_simulator/app/modules/mega_sena/mega_sena.dart';
import 'package:flutter_mega_sena_simulator/app/pages/home_page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePageState extends State<HomePage> {
  double _gameRounds = 100000;

  List<int> _game = [];
  int _interation = 0;
  double _progress = 0.0;
  String _gameStatus = 'not_started';
  Isolate? _isolate;
  final ReceivePort _receivePort = ReceivePort();
  late StreamSubscription _subscription;

  final MegaSena _megaSena = Modular.get();

  Future<void> _generateNewNumbers() async {
    _isolate = await Isolate.spawn(
      _megaSena.asyncGenerateGames,
      [
        _receivePort.sendPort,
        _gameRounds.round(),
      ],
    );
  }

  void _handlerGame(dynamic payload) {
    _interation++;

    final String type = payload['type'];
    final String status = payload['status'];
    final List<int> value = payload['value'];
    final double progress = payload['progress'];

    if (type == 'update_status') {
      _gameStatus = status;
    }

    final bool interationMultiple = _interation % 5 != 0;
    final bool shouldBeUpdateValue =
        interationMultiple || _gameStatus == 'finished';

    if (type == 'update_result' || shouldBeUpdateValue) {
      setState(() {
        _game = value;
        _progress = progress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _subscription = _receivePort.listen(_handlerGame);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _isolate?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Selecione o número de jogos a serem gerados'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Text(_gameRounds.round().toString()),
              ),
              Slider(
                value: _gameRounds,
                max: 500000,
                divisions: 1000,
                label: _gameRounds.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _gameRounds = value;
                  });
                },
              ),
              Expanded(
                child: ResultNumberWidget(numbers: _game),
              )
            ],
          ),
        ),
      ),
      bottomSheet: GenerateButtonWidget(
        progress: _progress,
        onPressed: () async {
          _generateNewNumbers();
        },
      ),
    );
  }
}
