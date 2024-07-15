import 'package:flutter/material.dart';
import 'package:alumnx_connect/comment.dart';

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

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  // Implement delete action
                  Navigator.pop(context); // Close the modal after action
                },
              ),
              ListTile(
                leading: Icon(Icons.report),
                title: Text('Report'),
                onTap: () {
                  // Implement report action
                  Navigator.pop(context); // Close the modal after action
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilepic),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(course, style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  _showOptionsModal(context);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            color: Color(0xFFE0E0E0),
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(content, style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
