import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewSubmittedPage extends StatelessWidget {
  final Map<String, dynamic> grievanceData;

  // Constructor to receive the data
  const ViewSubmittedPage({required this.grievanceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grievance Details'),
        backgroundColor: const Color(0xFF5D9817),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Grievance Category
            Text(
              'Category: ${grievanceData['category']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Display Grievance Description
            Text(
              'Description: ${grievanceData['description']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Display Grievance Location
            Text(
              'Location: ${grievanceData['location']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Display Image if it exists
            if (grievanceData['image'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(grievanceData['image']),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Display Grievance Status
            Text(
              'Status: ${grievanceData['status']}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
