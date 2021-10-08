import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddapp',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyUserPage(title: 'u/gitbluub'),
    );
  }
}

class MyUserPage extends StatefulWidget {
  const MyUserPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
            color: Colors.white
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
