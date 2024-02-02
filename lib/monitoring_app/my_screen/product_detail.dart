import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Center(
        child: Text(
          'Ini adalah layar detail product.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
