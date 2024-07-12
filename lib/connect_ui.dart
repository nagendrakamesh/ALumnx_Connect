import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  // Sample list of comments
  List<Comment> comments = [
    Comment(
      name: 'Akuleep J',
      course: 'CSE, 2022 - 2026',
      content: 'Another nice post from Akul',
    ),
    Comment(
      name: 'Rohan J',
      course: 'IT, 2019 - 2023',
      content: 'Cool comment from Rohan.',
    ),
    // Add more comments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterChipWidget(label: 'All'),
                  FilterChipWidget(label: 'College'),
                  FilterChipWidget(label: 'Batch'),
                  FilterChipWidget(label: 'Branch'),
                ],
              ),
            ),
            PostWidget(
              name: 'Aditi Sharma',
              course: 'CSE, 2020 - 2024',
              content:
              'KMIT encourages overall development, students are encouraged and appreciated for their achievements whether it be co-curricular or extra-curricular.\n\nWe have a Students\' Council which works relentlessly to provide a voice for the students giving them good opportunities.',
              likes: 18,
              comments: 117,
              // Example of passing comments to the PostWidget
              commentsData: comments,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushNamed(context, 'post');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: (bool value) {},
    );
  }
}

class PostWidget extends StatelessWidget {
  final String name;
  final String course;
  final String content;
  final int likes;
  final int comments;
  final List<Comment> commentsData; // List of comments data

  PostWidget({
    required this.name,
    required this.course,
    required this.content,
    required this.likes,
    required this.comments,
    required this.commentsData, // Receive comments data
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
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'), // Replace with actual image URL
              ),
              title: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                course,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {},
                ),
                Text('$likes'),
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
                                    itemCount: commentsData.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'), // Replace with actual image URL
                                        ),
                                        title: Text(
                                          commentsData[index].name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        subtitle: Text(
                                          commentsData[index].content,
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
                Text('$comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Comment {
  final String name;
  final String course;
  final String content;

  Comment({
    required this.name,
    required this.course,
    required this.content,
  });
}
