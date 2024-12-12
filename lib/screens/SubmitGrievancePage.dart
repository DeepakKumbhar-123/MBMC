import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'ViewSubmittedPage.dart';

class SubmitGrievancePage extends StatefulWidget {
  @override
  _SubmitGrievancePageState createState() => _SubmitGrievancePageState();
}

class _SubmitGrievancePageState extends State<SubmitGrievancePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _description;
  XFile? _selectedImage;
  String? _location;

  final List<String> _categories = ['Road Issue', 'Water Problem', 'Electricity','Solid waste management','Air quality:'];

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  /// Fetch the user's current location
  Future<void> _fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return setState(() {
        _location = 'Location services are disabled';
      });
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return setState(() {
          _location = 'Location permissions are denied';
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return setState(() {
        _location = 'Location permissions are permanently denied';
      });
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _location = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _location = 'Failed to fetch location: $e';
      });
    }
  }

  /// Pick an image using the given source (Camera/Gallery)
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  /// Reset the form fields
  void _resetForm() {
    setState(() {
      _selectedCategory = null;
      _description = null;
      _selectedImage = null;
      _location = null;
      _fetchLocation();
    });
    _formKey.currentState?.reset();
  }

  /// Submit the grievance form
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Create a grievance data map
      final grievanceData = {
        'category': _selectedCategory,
        'description': _description,
        'image': _selectedImage?.path,
        'location': _location,
        'status': 'Pending',
      };

      // Push the data to Firebase Realtime Database
      FirebaseDatabase.instance
          .ref()
          .child('grievances')
          .push()
          .set(grievanceData)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Grievance submitted successfully!')),
        );

        // Navigate to ViewSubmittedPage and pass the grievance data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewSubmittedPage(grievanceData: grievanceData),
          ),
        );

        // Reset the form after successful submission
        _resetForm();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Grievance'),
        backgroundColor: const Color(0xFF5D9817),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Complaint Category Dropdown
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    labelText: 'Complaint Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) {
                    _selectedCategory = value as String?;
                  },
                  validator: (value) =>
                  value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 16),

                // Description Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 4,
                  onSaved: (value) => _description = value,
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Description is required' : null,
                ),
                const SizedBox(height: 16),

                // Image Upload Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Upload Image'),
                      onPressed: () => _pickImage(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Picture'),
                      onPressed: () => _pickImage(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_selectedImage!.path),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Location Display
                Text(
                  _location ?? 'Fetching location...',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
