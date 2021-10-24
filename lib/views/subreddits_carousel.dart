import 'package:flutter/material.dart';
import 'subreddit_posts_list.dart';
import 'frontpage_post_list.dart';

/// Carousel for subreddits (used on home page)
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
    List<Widget> tabs = [Tab(text: "Home")] + [for (var name in widget.subredditsNames) Tab(text: name)];
    List<Widget> postLists = [FrontPagePostList() as Widget] + [for (var name in widget.subredditsNames) SubredditPostsList(subredditName: name) as Widget];
    return DefaultTabController(
        length: widget.subredditsNames.length + 1,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              automaticallyImplyLeading: false,
              flexibleSpace: TabBar(
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  labelColor: Theme.of(context).primaryColor,
                  tabs: tabs),
            ),
            body: TabBarView(
                children: postLists)
        )
    );
  }
}