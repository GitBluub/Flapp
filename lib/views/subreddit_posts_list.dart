import 'package:flutter/material.dart';
import 'post_preview.dart';
import 'loading.dart';
import '../models/subreddit.dart';

class SubredditPostsList extends StatefulWidget {
  final Subreddit? subreddit;

  const SubredditPostsList({Key? key, required this.subreddit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubredditPostsListState();
}

class _SubredditPostsListState extends State<SubredditPostsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subreddit == null) {
      return const LoadingWidget();
    }

    Subreddit sub = widget.subreddit as Subreddit;

    return Stack(children: [
      NotificationListener<ScrollEndNotification>(
        child: ListView(children: [for (var post in sub.posts) PostPreview(post: post)], ),
        onNotification: (notification) {
          print(_scrollController.position.pixels);
          // Return true to cancel the notification bubbling. Return false (or null) to
          // allow the notification to continue to be dispatched to further ancestors.
          return true;
        },
      ),
      FloatingActionButton(
        onPressed: () {},
        child: Row(children: const [Icon(Icons.arrow_downward_sharp), Icon(Icons.arrow_upward_sharp)])
      )
    ]);
  }
}
