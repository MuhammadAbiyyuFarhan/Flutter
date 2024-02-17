import 'package:flutter/material.dart';

class ConveyorDetailScreen extends StatelessWidget {
  const ConveyorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conveyor Detail'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar detail Conveyor.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
