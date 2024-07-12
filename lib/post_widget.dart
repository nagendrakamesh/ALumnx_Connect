// post_widget.dart
import 'package:flutter/material.dart';
import 'comment_widget.dart';
import 'comment.dart';

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
  int commentCount = 0;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    commentCount = widget.commentsData.length;
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
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
              ),
              title: Text(
                widget.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.course,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.content,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.thumb_up_alt_outlined,
                    color: isLiked ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                Text('${widget.likes}'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8,
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
                                  child: ListView.builder(
                                    itemCount: widget.commentsData.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
                                        ),
                                        title: Text(
                                          widget.commentsData[index].name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        subtitle: Text(
                                          widget.commentsData[index].content,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      );
                                    },
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
                Text('$commentCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
