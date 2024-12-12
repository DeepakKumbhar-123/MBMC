import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'SubmitGrievancePage.dart';
import 'assignedTask.dart';

class adminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF5D9817), // Custom green color
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
                color: Color(0xFF5D9817), // Match the AppBar color
              ),
            ),
            // Drawer menu items
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
            _buildElevatedButton('Assigned Grievance', Icons.assignment, context),
        SizedBox(height: 16),
        _buildElevatedButton('In Progress Task', Icons.timelapse, context),
        SizedBox(height: 16),
        _buildElevatedButton('Completed Task', Icons.check_circle, context),
        SizedBox(height: 16),
        _buildElevatedButton('Rejected Task', Icons.cancel, context),
          ]
      ),
      ),
    );
  }

  Widget _buildElevatedButton(String title, IconData icon, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87, backgroundColor: Colors.white, // Text color
        elevation: 4, // Shadow effect
        padding: EdgeInsets.symmetric(vertical: 20), // Button height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        side: BorderSide(color: Color(0xFF5D9817), width: 1.5), // Border color and width
      ),
      onPressed: () {
        // Implement navigation or functionality for each button
        if (title == 'Submit Grievance') {
          // Navigate to Submit Grievance Form
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminGrievancePage(),
            ),
          );
        } else {
          // Navigate to the PlaceholderPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceholderPage(title: title),
            ),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder Page for other buttons
class PlaceholderPage extends StatelessWidget {
  final String title;

  PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF5D9817),
      ),
      body: Center(
        child: Text(
          'This is the $title page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

