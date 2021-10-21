import 'package:flutter/material.dart';
import 'post_preview.dart';
import 'loading.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import 'loading.dart';

class SubredditPostsList extends StatefulWidget {
  static int pageSize = 15;

  late Subreddit? subreddit;
  late String? subredditName;

  SubredditPostsList({Key? key, this.subredditName, this.subreddit})  : super(key: key)
  {
    assert(subreddit != null || subredditName != null);
    assert(subreddit == null || subredditName == null);
  }

  @override
  State<StatefulWidget> createState() => _SubredditPostsListState();
}

class _SubredditPostsListState extends State<SubredditPostsList>
    with AutomaticKeepAliveClientMixin {

  bool loading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.subreddit == null) {
      GetIt.I<RedditInterface>()
          .getSubreddit(widget.subredditName!)
          .then((subredditValue) {
        setState(() {
          widget.subreddit = subredditValue;
        });
      });
      return const LoadingWidget();
    }
    Subreddit sub = widget.subreddit as Subreddit;

    ScrollController listController = ScrollController();
    Widget list = Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          padding: const EdgeInsets.only(right: 20),

          child: DropdownButton<PostSort>(
            value: sub.sortingMethod,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            onChanged: (PostSort? newValue) {
              loading = true;
              setState(() {});
              sub.sortingMethod = newValue!;
              sub.refreshPosts().then(
                      (_) => setState(() {loading = false;})
                      );
            },
            items: PostSort.values.map<DropdownMenuItem<PostSort>>((PostSort value) {
              return DropdownMenuItem<PostSort>(
                value: value,
                child: Text(value.toString().split('.').elementAt(1)),
              );
            }).toList(),
          ),
      ),
      Expanded(child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (listController.position.atEdge) {
                  loading = true;
                  setState(() {});
                  if (listController.position.pixels == 0) {
                    sub.refreshPosts().then((_) {
                      setState(() {
                        loading = false;
                      });
                    });
                  } else {
                    sub.fetchMorePosts().then((_) {
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                }
                // Return true to cancel the notification bubbling. Return false (or null) to
                // allow the notification to continue to be dispatched to further ancestors.
                return true;
              },
              child: ListView(
                controller: listController,
                children: [for (var post in sub.posts) PostPreview(post: post)],
              )))]);

    if (loading) {
      return Stack(children: [
        SizedBox.expand(
          child: Container(
            color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.5),
            ),
          ),
        const LoadingWidget(),
        list
      ]);
    } else {
      return list;
    }
  }
}
