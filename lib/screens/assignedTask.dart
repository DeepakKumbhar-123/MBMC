import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'InProgressTaskPage.dart';  // Import the InProgressTaskPage
import 'RejectedTask.dart';
   // Import the RejectedTaskPage

class AdminGrievancePage extends StatefulWidget {
  @override
  _AdminGrievancePageState createState() => _AdminGrievancePageState();
}

class _AdminGrievancePageState extends State<AdminGrievancePage> {
  final DatabaseReference _grievancesRef = FirebaseDatabase.instance.ref().child('grievances');
  final DatabaseReference _inProgressRef = FirebaseDatabase.instance.ref().child('inProgress');
  final DatabaseReference _rejectedRef = FirebaseDatabase.instance.ref().child('rejected');
  List<Map<String, dynamic>> _grievances = [];

  @override
  void initState() {
    super.initState();
    _fetchGrievances();
  }

  // Fetch grievances from Firebase
  void _fetchGrievances() {
    _grievancesRef.onValue.listen((DatabaseEvent event) {
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

  // Move grievance to InProgress or Rejected based on the status
  void _moveGrievance(String key, String status) {
    _grievancesRef.child(key).once().then((DatabaseEvent snapshot) {
      if (snapshot.snapshot.exists) {
        final grievance = snapshot.snapshot.value as Map<dynamic, dynamic>;
        if (status == 'Approved') {
          // Move to InProgress
          _inProgressRef.child(key).set(grievance);
          _grievancesRef.child(key).remove();  // Remove from grievances list
        } else if (status == 'Rejected') {
          // Move to Rejected
          _rejectedRef.child(key).set(grievance);
          _grievancesRef.child(key).remove();  // Remove from grievances list
        }
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      _moveGrievance(grievance['key'], 'Approved');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      _moveGrievance(grievance['key'], 'Rejected');
                    },
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
