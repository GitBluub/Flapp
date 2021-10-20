import 'package:flutter/material.dart';
import '../models/subreddit.dart';
import 'flapp_page.dart';

class SubredditPageView extends StatelessWidget{
  final Subreddit? subreddit;
  const SubredditPageView({Key? key, required this.subreddit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlappPage(body: Container(), title: subreddit!.displayName);
  }
}