import 'package:flutter/material.dart';
import '../views/subreddit_page.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class SubredditPageArguments {
  final String subredditName;

  SubredditPageArguments(this.subredditName);
}

class ExtractArgumentsSubredditPage extends StatelessWidget {
  const ExtractArgumentsSubredditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubredditPageArguments subredditPageArguments = ModalRoute.of(context)!.settings.arguments as SubredditPageArguments;
    return SubredditPageController(subredditName: subredditPageArguments.subredditName);
  }
}

class SubredditPageController extends StatefulWidget {
  final String subredditName;
  const SubredditPageController({Key? key, required this.subredditName}) : super(key: key);

  @override
  State<SubredditPageController> createState() => _SubredditPageControllerState();
}

class _SubredditPageControllerState extends State<SubredditPageController> {
  Subreddit? subreddit;
  bool? subscribed;

  @override
  void initState() {
    super.initState();
    setState(() => subreddit = null);
    GetIt.I<RedditInterface>().getSubreddit(widget.subredditName).then((subreddit) {
      setState(() {
        this.subreddit = subreddit;
        subscribed = GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.contains(widget.subredditName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubredditPageView(subreddit: subreddit, subscribed: subscribed);
  }
}
