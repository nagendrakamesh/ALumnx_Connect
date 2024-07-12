// comment_widget.dart
import 'package:flutter/material.dart';
import 'comment.dart';

class CommentWidget extends StatelessWidget {
  final String name;
  final String course;
  final String content;
  final int likes;

  CommentWidget({
    required this.name,
    required this.course,
    required this.content,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
              ),
              title: Text(name, style: TextStyle(fontSize: 14)),
              subtitle: Text(course, style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 8),
            Text(content, style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {},
                ),
                Text('$likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
