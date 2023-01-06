import 'package:flutter/material.dart';
import 'package:flutter_mega_sena_simulator/app/app_module.dart';
import 'package:flutter_mega_sena_simulator/app/helpers.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(
      ModularApp(
        module: AppModule(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mega Sena Simulator',
      theme: ThemeData(
        primarySwatch:
            Helpers.buildMaterialColor(const Color.fromRGBO(0, 158, 76, 1)),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
