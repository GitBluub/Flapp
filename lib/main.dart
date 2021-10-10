import 'package:flutter/material.dart';
import 'controllers/user_page.dart';

void main() {
  runApp(const ReddApp());
}

class ReddApp extends StatelessWidget {
  const ReddApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddapp',
      theme: ThemeData.dark(),
      initialRoute: '/user',
      routes: {
        '/user': (context) => const UserPageController(),
      },
    );
  }
}
