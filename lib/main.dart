import 'package:flutter/material.dart';
import 'controllers/redditor_page.dart';
import 'controllers/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const Flapp());
}

final getIt = GetIt.instance;

class Flapp extends StatelessWidget {
  const Flapp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flapp',
      theme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPageController(),
        '/user': (context) => const RedditorPageController(),
      },
    );
  }
}
