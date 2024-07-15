// connect_page.dart
import 'package:flutter/material.dart';
import 'package:alumnx_connect/post_widget.dart';
import 'package:alumnx_connect/filter_chip_widget.dart';
import 'package:alumnx_connect/comment.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  String selectedFilter = 'all';
  List<Comment> comments = [
    Comment(
      name: 'Akuleep J',
      course: 'CSE, 2022 - 2026',
      content: 'Another nice post from Akul',
      profilepic : 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
    ),
    Comment(
      name: 'Rohan J',
      course: 'IT, 2019 - 2023',
      content: 'Cool comment from Rohan.',
      profilepic : 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
    ),
  ];

  void handleFilterSelection(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterChipWidget(
                    label: 'All',
                    isSelected: selectedFilter == 'all',
                    onSelected: () => handleFilterSelection('all'),
                  ),
                  FilterChipWidget(
                    label: 'College',
                    isSelected: selectedFilter == 'college',
                    onSelected: () => handleFilterSelection('college'),
                  ),
                  FilterChipWidget(
                    label: 'Batch',
                    isSelected: selectedFilter == 'batch',
                    onSelected: () => handleFilterSelection('batch'),
                  ),
                  FilterChipWidget(
                    label: 'Branch',
                    isSelected: selectedFilter == 'branch',
                    onSelected: () => handleFilterSelection('branch'),
                  ),
                ],
              ),
            ),
            PostWidget(
              name: 'Aditi Sharma',
              course: 'CSE, 2020 - 2024',
              content:
              'KMIT encourages overall development, students are encouraged and appreciated for their achievements whether it be co-curricular or extra-curricular.\n\nWe have a Students\' Council which works relentlessly to provide a voice for the students giving them good opportunities.',
              likes: 18,
              commentsData: comments,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, 'post');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
