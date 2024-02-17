import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

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
      home: const HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DatabaseReference _databaseReference;
  List<Map<String, dynamic>> statusHistory = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child("Status");
    _loadStatusHistory();
  }

  void _loadStatusHistory() {
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var snapshots = event.snapshot.children;
        var statusMessages = snapshots.map((snapshot) {
          final key = snapshot.key;
          final value = snapshot.value as Map<String, dynamic>;

          return {
            'id': key ?? '',
            'message': value['message'] ?? '',
            'acknowledged': value['acknowledge'] == 1,
            'timestamp': value['timestamp'] ??
                '', // Use the timestamp from the database or current time
          };
        });
        setState(() {
          statusHistory = statusMessages.toList();
        });
      } else {
        setState(() {
          statusHistory.add({
            'id': '',
            'message': 'No status messages found',
            'acknowledged': false,
            'timestamp': ''
          });
        });
      }
    });
  }

  Future<void> _addNewStatus(String message) async {
    String newId = _databaseReference.push().key ?? '';
    Map<String, dynamic> statusData = {
      'message': message,
      'acknowledge': 0,
      'timestamp':
          DateTime.now().millisecondsSinceEpoch, // Current Unix timestamp
    };
    await _databaseReference.child(newId).set(statusData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: statusHistory.length,
        itemBuilder: (context, index) {
          final status = statusHistory.reversed.toList()[index];
          bool acknowledged = status['acknowledged'];
          return Container(
            margin: const EdgeInsets.all(6.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey[200],
            ),
            child: ListTile(
              leading: status['acknowledged']
                  ? Icon(Icons.check_circle,
                      color: Color.fromARGB(246, 211, 208, 37))
                  : Icon(Icons.warning, color: Colors.red),
              title: Text(
                status['message'] ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                'Timestamp: ${status['timestamp']}', // Directly use the timestamp string
                style: const TextStyle(fontSize:  14),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Warning Details'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status ID: ${status['id']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Message: ${status['message']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Timestamp: ${status['timestamp']}', // Directly use the timestamp string
                            style: const TextStyle(fontSize:  14),
                          ),
                          const SizedBox(height: 8),
                          Switch(
                            value: acknowledged,
                            onChanged: (value) {
                              setState(() {
                                statusHistory[index]['acknowledged'] = value;
                              });

                              // Perform the Firebase update operation
                              _databaseReference.child(status['id']).update(
                                  {'acknowledge': value ? 1 : 0}).then((_) {
                                print('Update successful');
                              }).catchError((error) {
                                print('Update failed: $error');
                              });

                              Navigator.of(context).pop();
                            },
                          ),
                          const Text('Acknowledged'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
