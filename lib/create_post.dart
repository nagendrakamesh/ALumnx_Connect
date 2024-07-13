import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedImagePath;
  String _selectedAccessLevel = 'college'; // Default access level

  Future<void> createPost(String content, String accessLevel) async {
    final response = await http.post(
      Uri.parse('https://your-server-url.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'postedBy': 'Aditi Sharma', // Replace with actual author
        'message': content,
        'image': _selectedImagePath ?? '', // Add image path here
        'accesslevel': accessLevel,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }

  void _showPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Access Level'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text('College'),
                    value: 'college',
                    groupValue: _selectedAccessLevel,
                    onChanged: (value) {
                      setState(() {
                        _selectedAccessLevel = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Batch'),
                    value: 'batch',
                    groupValue: _selectedAccessLevel,
                    onChanged: (value) {
                      setState(() {
                        _selectedAccessLevel = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Branch'),
                    value: 'branch',
                    groupValue: _selectedAccessLevel,
                    onChanged: (value) {
                      setState(() {
                        _selectedAccessLevel = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Post'),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      createPost(_controller.text, _selectedAccessLevel).then((_) {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.pop(context); // Go back to the previous screen
                      }).catchError((error) {
                        Navigator.of(context).pop(); // Close the dialog
                        print("Error: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create post')),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter some content')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _selectedImagePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _showPostDialog(context);
              }
            },
            child: Text('Post', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Type here...',
                border: InputBorder.none,
              ),
              maxLines: 8,
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _showPostDialog(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
