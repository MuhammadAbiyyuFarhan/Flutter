import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';
//import 'package:best_flutter_ui_templates/monitoring_app/monitoring_app_theme.dart';

class HistoryScreen extends StatelessWidget {
  // Function to show the popup.
  void _showHistoryItemPopup(BuildContext context, HistoryItem historyItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("History Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${historyItem.title}"),
              Text("Description: ${historyItem.description}"),
              Text("Timestamp: ${historyItem.timestamp}"),
              //Text("Is Warning: ${historyItem.isWarning}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: Text(
              "History",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          centerTitle: false,
          backgroundColor: AppTheme.chipBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.chipBackground,
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final historyItem = historyData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                onTap: () {
                  _showHistoryItemPopup(context, historyItem);
                },
                leading: CircleAvatar(
                  backgroundColor:
                      historyItem.isWarning ? Colors.yellow : Colors.red,
                  child: Icon(
                    historyItem.isWarning ? Icons.warning : Icons.error,
                    color: Colors.white,
                  ),
                ),
                title: Text(historyItem.title),
                subtitle: Text(historyItem.description),
                trailing: Text(
                  historyItem.timestamp,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HistoryItem {
  final String title;
  final String description;
  final String timestamp;
  final bool isWarning;

  HistoryItem({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isWarning = false,
  });
}

final List<HistoryItem> historyData = [
  HistoryItem(
    title: "Warning: Overheating",
    description: "The conveyor system is experiencing overheating.",
    timestamp: "2024-01-27 10:30 AM",
    isWarning: true,
  ),
  HistoryItem(
    title: "Error: Motor Failure",
    description: "Motor failure detected in the conveyor system.",
    timestamp: "2024-01-26 03:45 PM",
    isWarning: false,
  ),
  HistoryItem(
    title: "Info: System Restart",
    description: "The conveyor system has been restarted.",
    timestamp: "2024-01-25 02:15 PM",
    isWarning: false,
  ),
  HistoryItem(
    title: "Warning: Voltage Drop",
    description: "Voltage drop detected in the power supply.",
    timestamp: "2024-01-25 11:00 AM",
    isWarning: true,
  ),
  HistoryItem(
    title: "Info: System Restart",
    description: "The conveyor system has been restarted.",
    timestamp: "2024-01-25 02:15 PM",
    isWarning: false,
  ),
  HistoryItem(
    title: "Info: System Restart",
    description: "The conveyor system has been restarted.",
    timestamp: "2024-01-25 02:15 PM",
    isWarning: false,
  ),
];
