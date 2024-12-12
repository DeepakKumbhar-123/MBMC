import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InProgressTaskPage extends StatefulWidget {
  @override
  _InProgressTaskPageState createState() => _InProgressTaskPageState();
}

class _InProgressTaskPageState extends State<InProgressTaskPage> {
  final DatabaseReference _inProgressRef = FirebaseDatabase.instance.ref().child('inProgress');
  List<Map<String, dynamic>> _inProgressTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchInProgressTasks();
  }

  // Fetch In Progress tasks from Firebase
  void _fetchInProgressTasks() {
    _inProgressRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _inProgressTasks = data.entries.map((entry) {
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
        title: Text('In Progress Tasks'),
      ),
      body: _inProgressTasks.isEmpty
          ? Center(child: Text('No tasks in progress.'))
          : ListView.builder(
        itemCount: _inProgressTasks.length,
        itemBuilder: (context, index) {
          final task = _inProgressTasks[index];
          return ListTile(
            title: Text(task['category'] ?? 'No Category'),
            subtitle: Text(task['description'] ?? ''),
          );
        },
      ),
    );
  }
}
