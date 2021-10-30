import 'package:flutter/material.dart';
import 'posts_list.dart';
import 'package:flapp/src/models/post_holder.dart';

/// Carousel for subreddits (used on home page)
class PostHolderCarousel extends StatelessWidget {
  /// A map associating a name to a holder;
  final Map<String, Future<PostHolder> Function()> holdersFetcher;
  const PostHolderCarousel({Key? key, required this.holdersFetcher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    List<Widget> postLists = [];
    holdersFetcher.forEach((name, holderFetcher) {
      tabs.add(Tab(text: name));
      postLists.add(PostsList(holderFetcher: holderFetcher, displaySubredditName: name == "Home",));
    });
    return DefaultTabController(
        length: holdersFetcher.length,
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
