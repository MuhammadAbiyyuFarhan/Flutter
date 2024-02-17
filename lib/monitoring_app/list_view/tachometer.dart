import 'package:flutter/material.dart';

class TachometerDetailScreen extends StatelessWidget {
  const TachometerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tachometer Detail'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar detail tachometer.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
