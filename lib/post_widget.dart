import 'package:flutter/material.dart';
import 'comment.dart';
import 'comment_widget.dart';

class PostWidget extends StatefulWidget {
  final String name;
  final String course;
  final String content;
  final int likes;
  final List<Comment> commentsData;

  PostWidget({
    required this.name,
    required this.course,
    required this.content,
    required this.likes,
    required this.commentsData,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  TextEditingController _commentController = TextEditingController();
  bool isLiked = false; // Add this boolean variable to track the like status

  void _postComment() {
    String commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      // Create a new comment object
      Comment newComment = Comment(
        name: 'User', // Replace with actual user's name or identifier
        course: 'Course', // Replace with actual course info if needed
        content: commentText,
        profilepic: 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg', // Replace with actual profile pic URL
      );

      // Add the new comment to the list
      setState(() {
        widget.commentsData.add(newComment);
        _commentController.clear(); // Clear the comment text field
      });
    }
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

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
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'), // Replace with actual image URL
              ),
              title: Text(widget.name),
              subtitle: Text(widget.course),
            ),
            SizedBox(height: 8),
            Text(widget.content),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                    color: isLiked ? Colors.blue : null,
                  ),
                  onPressed: _toggleLike,
                ),
                SizedBox(width: 4),
                Text('${widget.likes + (isLiked ? 1 : 0)}'), // Update like count dynamically
                Spacer(),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Show comments in modal bottom sheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.9,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Comments:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: widget.commentsData.map((comment) {
                                        return CommentWidget(
                                          name: comment.name,
                                          course: comment.course,
                                          content: comment.content,
                                          profilepic: comment.profilepic,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Divider(),
                                SizedBox(height: 8),
                                AnimatedPadding(
                                  duration: const Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _commentController,
                                          decoration: InputDecoration(
                                            hintText: 'Add a comment...',
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: _postComment,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 4),
                Text('${widget.commentsData.length}  '),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
