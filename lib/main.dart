import 'package:alumnx_connect/connect_ui.dart';
import 'package:alumnx_connect/create_post.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'connect',
      routes: {
        'connect': (context) => ConnectPage(),
        'post' : (context) => CreatePostPage(),
      },
    );
  }
}
