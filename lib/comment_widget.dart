// comment_widget.dart
import 'package:flutter/material.dart';
import 'comment.dart';

class CommentWidget extends StatelessWidget {
  final String name;
  final String course;
  final String content;
  final String profilepic;

  CommentWidget({
    required this.name,
    required this.course,
    required this.content,
    required this.profilepic,
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
                backgroundImage: NetworkImage(profilepic),
              ),
              title: Text(name, style: TextStyle(fontSize: 14)),
              subtitle: Text(course, style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 8),
            Text(content, style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.thumb_up_alt_outlined),
            //       onPressed: () {},
            //     ),
            //     // Text('$likes'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
