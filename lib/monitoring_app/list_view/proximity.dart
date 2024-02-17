import 'package:flutter/material.dart';

class ProximityDetailScreen extends StatelessWidget {
  const ProximityDetailScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proximity Detail'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar detail proximity.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
