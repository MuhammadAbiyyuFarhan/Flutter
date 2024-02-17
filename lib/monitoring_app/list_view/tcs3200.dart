import 'package:flutter/material.dart';

class TCS3200DetailScreen extends StatelessWidget {
  const TCS3200DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCS3200 Detail'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar detail TCS3200.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
