import 'package:flapp/src/controllers/subreddit_page.dart';
import 'package:flutter/material.dart';
import 'package:flapp/src/controllers/redditor_page.dart';
import 'package:flapp/src/controllers/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flapp/src/controllers/home_page.dart';
import 'package:flapp/src/models/reddit_interface.dart';
import 'package:flapp/src/controllers/search_page.dart';
import 'package:flapp/src/controllers/post_page.dart';
import 'package:flapp/src/controllers/settings_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  RedditInterface interface = RedditInterface();
  GetIt.I.registerSingleton<RedditInterface>(interface);
  await interface.restoreAPIConnection();
  runApp(Flapp(connected: interface.connected));
}

class Flapp extends StatelessWidget {
  final bool connected;
  const Flapp({Key? key, required this.connected}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flapp',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.white),
      initialRoute: connected ? "/home" : "/login",
      routes: {
        '/login': (context) => const LoginPageController(),
        '/user': (context) => const RedditorPageController(),
        '/home': (context) => const HomePageController(),
        '/search': (context) => const SearchPageController(),
        '/subreddit': (context) => const ExtractArgumentsSubredditPage(),
        '/post': (context) => const ExtractArgumentsPostPage(),
        '/settings': (context) => const SettingsPageController(),
      },
    );
  }
}