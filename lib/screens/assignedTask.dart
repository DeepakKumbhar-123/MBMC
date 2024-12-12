import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminGrievancePage extends StatefulWidget {
  @override
  _AdminGrievancePageState createState() => _AdminGrievancePageState();
}

class _AdminGrievancePageState extends State<AdminGrievancePage> {
  final DatabaseReference _grievancesRef = FirebaseDatabase.instance.ref().child('grievances');
  List<Map<String, dynamic>> _grievances = [];

  @override
  void initState() {
    super.initState();
    _fetchGrievances();
  }

  void _fetchGrievances() {
    _grievancesRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _grievances = data.entries.map((entry) {
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
        title: Text('Admin Grievances'),
      ),
      body: _grievances.isEmpty
          ? Center(child: Text('No grievances submitted yet.'))
          : ListView.builder(
        itemCount: _grievances.length,
        itemBuilder: (context, index) {
          final grievance = _grievances[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(grievance['category'] ?? 'No Category'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: ${grievance['description'] ?? ''}'),
                  Text('Location: ${grievance['location'] ?? ''}'),
                  Text('Status: ${grievance['status'] ?? ''}'),
                  if (grievance['image'] != null)
                    Image.network(
                      grievance['image'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Text('Image not available'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
