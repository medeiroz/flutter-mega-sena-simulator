import 'package:flutter_mega_sena_simulator/app/modules/mega_sena/mega_sena.dart';
import 'package:flutter_mega_sena_simulator/app/pages/home_page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => MegaSena()),
      ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(title: 'Simulador Mega Sena'),
    )
  ];
}
