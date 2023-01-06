import 'package:flutter/material.dart';
import 'package:flutter_mega_sena_simulator/app/pages/home_page/home_page_state.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => HomePageState();
}
