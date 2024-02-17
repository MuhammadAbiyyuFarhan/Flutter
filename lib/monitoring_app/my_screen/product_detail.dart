import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar detail product.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
