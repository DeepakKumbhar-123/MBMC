import 'package:flutter/material.dart';
import 'InProgressTaskPage.dart';
import 'RejectedTask.dart';
import 'SubmitGrievancePage.dart';
import 'assignedTask.dart';

class adminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF5D9817),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Deepak Kumbhar'),
              accountEmail: Text('deepakkumbhar@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xFF5D9817)),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF5D9817),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Update Profile'),
              onTap: () {
                // Navigate to Update Profile Page
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Change Theme'),
              onTap: () {
                // Implement Change Theme Logic
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildElevatedButton('Assigned Grievance', Icons.assignment, context, AdminGrievancePage()),
            SizedBox(height: 16),
            _buildElevatedButton('In Progress Task', Icons.timelapse, context, InProgressTaskPage()),
            SizedBox(height: 16),
            _buildElevatedButton('Completed Task', Icons.check_circle, context, null),
            SizedBox(height: 16),
            _buildElevatedButton('Rejected Task', Icons.cancel, context, RejectedTaskPage()),
            SizedBox(height: 16),
            _buildElevatedButton('Submit Grievance', Icons.add, context, SubmitGrievancePage()),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton(String title, IconData icon, BuildContext context, Widget? destinationPage) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87, backgroundColor: Colors.white,
        elevation: 4, padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Color(0xFF5D9817), width: 1.5),
      ),
      onPressed: () {
        if (destinationPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Color(0xFF5D9817)),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
