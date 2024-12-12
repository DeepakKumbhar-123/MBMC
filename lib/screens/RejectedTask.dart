import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RejectedTaskPage extends StatefulWidget {
  @override
  _RejectedTaskPageState createState() => _RejectedTaskPageState();
}

class _RejectedTaskPageState extends State<RejectedTaskPage> {
  final DatabaseReference _rejectedRef = FirebaseDatabase.instance.ref().child('rejected');
  List<Map<String, dynamic>> _rejectedTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchRejectedTasks();
  }

  // Fetch Rejected tasks from Firebase
  void _fetchRejectedTasks() {
    _rejectedRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _rejectedTasks = data.entries.map((entry) {
            return {
              'key': entry.key,
              ...Map<String, dynamic>.from(entry.value as Map),
            };
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejected Tasks'),
      ),
      body: _rejectedTasks.isEmpty
          ? Center(child: Text('No rejected tasks.'))
          : ListView.builder(
        itemCount: _rejectedTasks.length,
        itemBuilder: (context, index) {
          final task = _rejectedTasks[index];
          return ListTile(
            title: Text(task['category'] ?? 'No Category'),
            subtitle: Text(task['description'] ?? ''),
          );
        },
      ),
    );
  }
}
