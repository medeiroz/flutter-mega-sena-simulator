import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  final int number;

  const NumberWidget({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        color: const Color.fromRGBO(0, 158, 76, 1),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
