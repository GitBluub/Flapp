import 'package:flutter/material.dart';
import 'posts_list.dart';
import '../models/post_holder.dart';

/// Carousel for subreddits (used on home page)
class PostHolderCarousel extends StatelessWidget {
  /// A map associating a name to a holder;
  final Map<String, PostHolder> holders;
  const PostHolderCarousel({Key? key, required this.holders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    List<Widget> postLists = [];
    holders.forEach((name, holder) {
      tabs.add(Tab(text: name));
      postLists.add(PostsList(holder: holder, displaySubredditName: name == "Home",));
    });
    return DefaultTabController(
        length: holders.length,
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
