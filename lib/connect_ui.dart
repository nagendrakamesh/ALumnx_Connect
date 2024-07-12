// connect_page.dart
import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'filter_chip_widget.dart';
import 'comment.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  String selectedFilter = 'All';
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
  ];

  void handleFilterSelection(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

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
                  FilterChipWidget(
                    label: 'All',
                    isSelected: selectedFilter == 'All',
                    onSelected: () => handleFilterSelection('All'),
                  ),
                  FilterChipWidget(
                    label: 'College',
                    isSelected: selectedFilter == 'College',
                    onSelected: () => handleFilterSelection('College'),
                  ),
                  FilterChipWidget(
                    label: 'Batch',
                    isSelected: selectedFilter == 'Batch',
                    onSelected: () => handleFilterSelection('Batch'),
                  ),
                  FilterChipWidget(
                    label: 'Branch',
                    isSelected: selectedFilter == 'Branch',
                    onSelected: () => handleFilterSelection('Branch'),
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
        onPressed: () {
          Navigator.pushNamed(context, 'post');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
