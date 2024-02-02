//import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorDetailScreen extends StatefulWidget {
  @override
  _SensorDetailScreenState createState() => _SensorDetailScreenState();
    String getDetectionCounter() {
    return _SensorDetailScreenState().detectionCounter;
  }
}

class _SensorDetailScreenState extends State<SensorDetailScreen> {
  late DatabaseReference _databaseReference;
  String detectionCounter = '';
  String sensorValue = '';

  @override
  void initState() {
    super.initState();
    // Initialize the database reference
    _databaseReference = FirebaseDatabase.instance.reference();

    // Register a listener to listen for changes in the database
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          // Use null-aware operators to safely access the values
          detectionCounter = (event.snapshot.value as Map<String, dynamic>?)?['detectionCounter']?.toString() ?? '';
          sensorValue = (event.snapshot.value as Map<String, dynamic>?)?['sensorValue']?.toString() ?? '';
        });
      } else {
        // Handle the case when sensor values cannot be obtained
        setState(() {
          detectionCounter = 'Gagal mendapatkan nilai';
          sensorValue = 'Gagal mendapatkan nilai';
        });
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Sensor Detail'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Panggil Navigator.pop untuk kembali ke halaman sebelumnya
          Navigator.pop(context);
        },
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detection Counter: $detectionCounter',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Sensor Value: $sensorValue',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}

}
