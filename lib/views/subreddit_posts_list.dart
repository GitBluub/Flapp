import 'package:flutter/material.dart';
import 'post_preview.dart';
import 'loading.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class SubredditPostsList extends StatefulWidget {

  static int pageSize = 15;

  final String subredditName;

  const SubredditPostsList({Key? key, required this.subredditName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubredditPostsListState();
}

class _SubredditPostsListState extends State<SubredditPostsList> with AutomaticKeepAliveClientMixin {
  Subreddit? subreddit;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (subreddit == null) {
      GetIt.I<RedditInterface>().getSubreddit(widget.subredditName).then((subredditValue) {
        setState(() {
          subreddit = subredditValue;
        });
      });
      return const LoadingWidget();
    }
    Subreddit sub = subreddit as Subreddit;
    ScrollController listController = ScrollController();

    return Stack(children: [
      NotificationListener<ScrollEndNotification>(
        child: ListView(
          controller: listController,
          children: [for (var post in sub.posts) PostPreview(post: post)]
        ),
        onNotification: (notification) {
          if (listController.position.atEdge) {
            if (listController.position.pixels == 0) {
              sub.refreshPosts();
            } else {
              sub.fetchMorePosts();
            }
            setState(() {});
          }
          // Return true to cancel the notification bubbling. Return false (or null) to
          // allow the notification to continue to be dispatched to further ancestors.
          return true;
        },
      ),
      ]);
  }
}
