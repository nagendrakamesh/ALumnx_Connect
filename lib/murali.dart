import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadExample extends StatefulWidget {
  @override
  _ImageUploadExampleState createState() => _ImageUploadExampleState();
}

class _ImageUploadExampleState extends State<ImageUploadExample> {
  final ImagePicker _picker = ImagePicker();
  File? selectedFile; // Variable to hold the selected file

  Future<void> selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedFile = File(pickedFile.path); // Store the selected file
      });
    }
  }

  Future<void> handleImageUpload() async {
    if (selectedFile == null) {
      print('No file selected for upload.');
      return; // No file selected
    }

    String fileName = selectedFile!.path.split('/').last; // Get the original file name
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newFileName = '$timestamp$fileName';

    try {
      final request = http.Request(
        'PUT',
        Uri.parse('https://61tffq7a0k.execute-api.us-east-1.amazonaws.com/v1/$newFileName'),
      );
      request.headers['Content-Type'] = 'image/jpeg'; // Adjust based on your file type
      request.bodyBytes = await selectedFile!.readAsBytes(); // Use the selected file

      final response = await request.send();

      if (response.statusCode != 200) {
        final errorData = await response.stream.bytesToString();
        print('Upload failed: $errorData');
        throw Exception('Upload failed: $errorData');
      }

      print('File uploaded successfully: $newFileName');
    } catch (error) {
      print('Error uploading file: $error');
      // Handle your error accordingly (e.g., show a toast)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Upload Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleImageUpload,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
