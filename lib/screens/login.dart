import 'package:flutter/material.dart';
import 'package:mbmc/screens/fieldOfficerDashboard.dart';  // Make sure the correct import for FieldOfficerDashboard is here
import 'adminDashboard.dart';
class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        backgroundColor: Color(0xFF5D9817),  // Custom green color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Title Text
            Text(
              'Admin Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),

            // Username Text Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Enter your username',
                prefixIcon: Icon(Icons.person, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password Text Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your password',
                prefixIcon: Icon(Icons.lock, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            SizedBox(height: 40),

            // Login Button
            ElevatedButton(
              onPressed: () {
                // Perform your login validation here
                if (_usernameController.text == 'admin' && _passwordController.text == 'password') {
                  // Navigate to FieldOfficerDashboard if login is successful
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => adminDashboard()),
                  );
                } else {
                  // Show error message if login fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid username or password')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
