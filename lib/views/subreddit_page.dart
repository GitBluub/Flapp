import 'package:flutter/material.dart';
import '../models/subreddit.dart';
import 'flapp_page.dart';
import 'loading.dart';

class SubredditPageView extends StatelessWidget{
  final Subreddit? subreddit;
  const SubredditPageView({Key? key, required this.subreddit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subreddit == null) {
      return const LoadingWidget();
    }
    return FlappPage(body: Container(), title: subreddit!.displayName);
  }
}