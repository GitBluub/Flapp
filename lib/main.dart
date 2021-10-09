import 'package:flutter/material.dart';
import 'vues/user_page.dart';
import 'models/redditor.dart';

void main() {
  runApp(const ReddApp());
}

class ReddApp extends StatelessWidget {
  const ReddApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Redditor user = Redditor(
        bannerUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/bannerBackgroundImage_xg901qmo8no61.png',
        pictureUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/communityIcon_ic8kuvspll861.png',
        displayName: 'u/GitBluub', name: 'Gitbluub', karma: 0, subscribedSubreddits: [], posts: [], ancientness: DateTime(1989));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddapp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/user',
      routes: {
        '/user': (context) => UserPage(user: user),
      },
    );
  }
}
