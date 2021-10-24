import 'package:flapp/views/loading.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart' as draw;
import '../models/frontpage.dart';
import '../models/reddit_interface.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import 'post_widget.dart';
import 'dart:ui';

class FrontPagePostList extends StatefulWidget {
  FrontPage? frontpage;
  @override
  State<FrontPagePostList> createState() => _FrontPagePostListState();
}

class _FrontPagePostListState extends State<FrontPagePostList> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.frontpage == null) {
      GetIt.I<RedditInterface>()
          .getFrontPage()
          .then((fp) {
        setState(() {
          widget.frontpage = fp;
        });
      });
      return const LoadingWidget();
    }
    FrontPage fp = widget.frontpage as FrontPage;
    ScrollController listController = ScrollController();
    Widget list = Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          padding: const EdgeInsets.only(right: 20),
          child: DropdownButton<PostSort>(
              value: fp.sortingMethod,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              onChanged: (PostSort? newValue) {
                loading = true;
                setState(() {});
                if (newValue! != PostSort.top) {
                  fp.topSortingMethod = null;
                }
                fp.sortingMethod = newValue;
                fp.refreshPosts().then((_) => setState(() {
                  loading = false;
                }));
              },
              items: PostSort.values
                  .map<DropdownMenuItem<PostSort>>((PostSort value) {
                return DropdownMenuItem<PostSort>(
                  value: value,
                  child: value != PostSort.top
                      ? Text(value.toString().split('.').elementAt(1))
                      : Row(children: [
                    Text(value.toString().split('.').elementAt(1) + " "),
                    DropdownButton<PostTopSort>(
                      value: fp.topSortingMethod,
                      elevation: 16,
                      onChanged: (PostTopSort? newValue) {
                        fp.topSortingMethod = newValue!;
                        fp.sortingMethod = PostSort.top;
                        fp.refreshPosts().then((_) => setState(() {}));
                      },
                      items: PostTopSort.values
                          .map<DropdownMenuItem<PostTopSort>>(
                              (PostTopSort value) {
                            return DropdownMenuItem<PostTopSort>(
                                value: value,
                                child: Text(value
                                    .toString()
                                    .split('.')
                                    .elementAt(1)));
                          }).toList(),
                    )
                  ]),
                );
              }).toList())),
      Expanded(
          child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (listController.position.atEdge) {
                  loading = true;
                  setState(() {});
                  if (listController.position.pixels == 0) {
                    fp.refreshPosts().then((_) {
                      setState(() {
                        loading = false;
                      });
                    });
                  } else {
                    fp.fetchMorePosts().then((_) {
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
              child: Scrollbar(child: ListView(
                shrinkWrap: true,
                controller: listController,
                children: [
                  for (var post in fp.posts)
                    PostWidget(post: post, displaySubName: false, preview: true)
                ],
              ))))
    ]);
    return Stack(children: [
      list,
      loading ? BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container()) : Container(),
      loading ? const LoadingWidget() : Container()
    ]);
  }
}