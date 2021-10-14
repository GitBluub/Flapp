import 'package:flutter/material.dart';
import '../views/subreddit_page.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class SubredditPageController extends StatefulWidget {
  final String subredditName;
  const SubredditPageController({Key? key, required this.subredditName}) : super(key: key);

  @override
  State<SubredditPageController> createState() => _SubredditPageControllerState();
}

class _SubredditPageControllerState extends State<SubredditPageController> {
  Subreddit? subreddit;
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    setState(() => subreddit = null);
  }

  @override
  Widget build(BuildContext context) {
    if (fetched)
        return SubredditPageVue(subreddit: subreddit);
    GetIt.I<RedditInterface>().getLoggedRedditor().then((redditorValue) {
      setState(() {
        subreddit = subreddit;
        fetched = true;
      });
    });
    return SubredditPageVue(subreddit: subreddit);
  }
}
