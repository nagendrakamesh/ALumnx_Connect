import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePostPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Future<void> createPost(String content) async {
    final response = await http.post(
      Uri.parse('https://your-server-url.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'author': 'Aditi Sharma', // Replace with actual author
        'content': content,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
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
                createPost(_controller.text).then((_) {
                  Navigator.pop(context);
                });
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
              decoration: InputDecoration(
                hintText: 'Type here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            Spacer(),
            Row(
              children: [
                IconButton(icon: Icon(Icons.image), onPressed: () {}),
                IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                Spacer(),
                IconButton(icon: Icon(Icons.send), onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    createPost(_controller.text).then((_) {
                      Navigator.pop(context);
                    });
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}