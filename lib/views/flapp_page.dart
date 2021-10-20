import 'package:flutter/material.dart';
import 'flapp_drawer.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class FlappPage extends StatelessWidget {
  final Widget body;
  final String title;
  const FlappPage({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        drawer: FlappDrawer(user: GetIt.I<RedditInterface>().loggedRedditor),
        body: body
    );
  }
}