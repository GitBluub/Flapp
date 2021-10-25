import 'package:flutter/material.dart';
import 'posts_list.dart';
import '../models/post_holder.dart';

/// Carousel for subreddits (used on home page)
class PostHolderCarousel extends StatefulWidget {
  /// A map associating a name to a holder;
  final Map<String, PostHolder> holders;
  const PostHolderCarousel({Key? key, required this.holders})
      : super(key: key);

  @override
  State<PostHolderCarousel> createState() => _PostHolderCarouselState();
}

class _PostHolderCarouselState extends State<PostHolderCarousel> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [for (var name in widget.holders.keys) Tab(text: name)];
    List<Widget> postLists = [for (var holder in widget.holders.values) PostsList(holder: holder)];
    return DefaultTabController(
        length: widget.holders.length,
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