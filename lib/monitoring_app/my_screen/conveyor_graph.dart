import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChartScreen(),
    );
  }
}

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  static const Color background = Color(0xFFF2F3F8);

  late DatabaseReference _databaseReference;
  List<FlSpot> beltSpeed1Data = [];
  List<FlSpot> rpm1Data = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child('Graph');

    // Listen for any child added under "Graph"
    _databaseReference.onChildAdded.listen((event) {
      String graphId = event.snapshot.key!;
      DatabaseReference graphReference = _databaseReference.child(graphId);

      // Listen for changes in beltSpeed1 data
      graphReference.child('beltSpeed1').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString());
          setState(() {
            beltSpeed1Data.add(FlSpot(beltSpeed1Data.length.toDouble(), value));
          });
        }
      });

      // Listen for changes in RPM1 data
      graphReference.child('RPM1').onValue.listen((event) {
        if (event.snapshot.value != null) {
          double value = double.parse(event.snapshot.value.toString()) / 100;
          setState(() {
            rpm1Data.add(FlSpot(rpm1Data.length.toDouble(), value));
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('beltSpeed-RPM/100 Chart'),
      ),
      backgroundColor: background, // Set background color of the whole screen
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 300.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), // Radius untuk sudut kiri atas
                topRight:
                    Radius.circular(150.0), // Radius untuk sudut kanan atas
                bottomLeft:
                    Radius.circular(10.0), // Radius untuk sudut kiri bawah
                bottomRight:
                    Radius.circular(10.0), // Radius untuk sudut kanan bawah
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF9ADE7B),
                  const Color(0xFFFC9B),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: beltSpeed1Data,
                      isCurved: true,
                      colors: [Color(0xFF750E21)],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: rpm1Data,
                      isCurved: true,
                      colors: [Color(0xFF0766AD)],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                    ),
                  ),
                  gridData: FlGridData(
                      drawVerticalLine: true, drawHorizontalLine: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
