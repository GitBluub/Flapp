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
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: widget.subredditsNames.length,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              automaticallyImplyLeading: false,
              flexibleSpace: TabBar(
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  tabs: [
                for (var name in widget.subredditsNames) Tab(text: name)
              ]),
            ),
            body: TabBarView(children:
              [for (var name in widget.subredditsNames) SubredditPostsList(subredditName: name)]
            )
        )
    );
  }
}