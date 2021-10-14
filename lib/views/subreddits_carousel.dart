import 'package:flutter/material.dart';
import '../models/subreddit.dart';
import '../models/reddit_interface.dart';
import 'package:get_it/get_it.dart';
import 'subreddit_posts_list.dart';

class SubredditsCarousel extends StatefulWidget {
  final List<String> subredditsNames;
  const SubredditsCarousel({Key? key, required this.subredditsNames})
      : super(key: key);

  @override
  State<SubredditsCarousel> createState() => _SubredditsCarouselState();
}

class _SubredditsCarouselState extends State<SubredditsCarousel> {
  Map<String, Subreddit?> subreddits = {};

  @override
  void initState() {
    super.initState();
    setState(() =>
    subreddits = {for (var name in widget.subredditsNames) name: null});
  }

  @override
  Widget build(BuildContext context) {
    for (var subredditName in widget.subredditsNames) {
      GetIt.I<RedditInterface>().getSubreddit(subredditName).then((subredditValue) {
        setState(() {
          subreddits[subredditName] = subredditValue;
        });
      });
    }

    return DefaultTabController(
        length: widget.subredditsNames.length,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: TabBar(isScrollable: true, tabs: [
                for (var name in widget.subredditsNames) Tab(text: name)
              ]),
            ),
            body: TabBarView(children:
              [for (var name in widget.subredditsNames) SubredditPostsList(subreddit: subreddits[name])]
            )
        )
    );
  }
}