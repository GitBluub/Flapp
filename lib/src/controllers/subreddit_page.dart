import 'package:flutter/material.dart';
import 'package:flapp/src/views/subreddit_page.dart';
import 'package:flapp/src/models/subreddit.dart';
import 'package:get_it/get_it.dart';
import 'package:flapp/src/models/reddit_interface.dart';


/// Class to get the subreddit's name in route's arguments
class SubredditPageArguments {
  final String subredditName;

  SubredditPageArguments(this.subredditName);
}

/// Controller associated to '/subreddit' route, to get name of subreddit in route parameter
class ExtractArgumentsSubredditPage extends StatelessWidget {
  const ExtractArgumentsSubredditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubredditPageArguments subredditPageArguments = ModalRoute.of(context)!.settings.arguments as SubredditPageArguments;
    return SubredditPageController(subredditName: subredditPageArguments.subredditName);
  }
}

/// Controller for Subreddit Page, where the subreddit's posts, and more info are displayed
class SubredditPageController extends StatefulWidget {
  final String subredditName;
  const SubredditPageController({Key? key, required this.subredditName}) : super(key: key);

  @override
  State<SubredditPageController> createState() => _SubredditPageControllerState();
}

class _SubredditPageControllerState extends State<SubredditPageController> {
  Subreddit? subreddit;

  @override
  void initState() {
    super.initState();
    setState(() => subreddit = null);
    GetIt.I<RedditInterface>().getSubreddit(widget.subredditName).then((subreddit) {
      setState(() {
        this.subreddit = subreddit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubredditPageView(subreddit: subreddit);
  }
}
