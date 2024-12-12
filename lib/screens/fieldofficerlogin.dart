import 'package:flutter/material.dart';
import 'package:mbmc/screens/fieldOfficerDashboard.dart'; // Ensure this path is correct

class FieldOfficerLoginPage extends StatefulWidget {
  @override
  _FieldOfficerLoginPageState createState() => _FieldOfficerLoginPageState();
}

class _FieldOfficerLoginPageState extends State<FieldOfficerLoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false; // Flag to track OTP sent status
  String _errorMessage = ''; // To show error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field Officer Login'),
        backgroundColor: Color(0xFF5D9817), // Custom green color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text
            Center(
              child: Text(
                'Field Officer Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Display error message (if any)
            if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 10),

            // Mobile Number Input (Only shown before OTP is sent)
            if (!_isOtpSent) ...[
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter your mobile number',
                  prefixIcon: Icon(Icons.phone, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],

            // OTP Input (Only shown after OTP is sent)
            if (_isOtpSent) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  prefixIcon: Icon(Icons.lock, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],

            // Send OTP Button (Only shown before OTP is sent)
            if (!_isOtpSent)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_mobileController.text.isEmpty ||
                        _mobileController.text.length != 10) {
                      setState(() {
                        _errorMessage =
                        'Please enter a valid 10-digit mobile number.';
                      });
                    } else {
                      setState(() {
                        _isOtpSent = true;
                        _errorMessage = ''; // Clear error message
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Send OTP'),
                ),
              ),

            // Verify OTP Button (Only shown after OTP is sent)
            if (_isOtpSent)
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the Field Officer Dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fieldofficerdashboard(),
                      ),
                    );
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Fieldofficerdashboard()),
                      );
                    }, // Empty function here for button
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Verify OTP'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
