import 'dart:ui';

import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'loading.dart';
import '../models/subreddit.dart';
import '../models/post_holder.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import 'loading.dart';

/// Widget for a subreddit's post list
class PostsList extends StatefulWidget {
  static const int pageSize = 15;

  late PostHolder? holder;

  PostsList({Key? key, this.holder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PostHolder sub = widget.holder as PostHolder;

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
                if (newValue! != PostSort.top) {
                  sub.topSortingMethod = null;
                }
                sub.sortingMethod = newValue;
                sub.refreshPosts().then((_) => setState(() {
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
                            value: sub.topSortingMethod,
                            elevation: 16,
                            onChanged: (PostTopSort? newValue) {
                              sub.topSortingMethod = newValue!;
                              sub.sortingMethod = PostSort.top;
                              sub.refreshPosts().then((_) => setState(() {}));
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
              child: Scrollbar(child: ListView(
                shrinkWrap: true,
                controller: listController,
                children: [
                  for (var post in sub.posts)
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
    /*if (loading) {
      return list;
      /*return Stack(children: [
        list,
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(height: 125, color: Theme.of(context).scaffoldBackgroundColor)),
        const LoadingWidget(),
      ])*/
    } else {
      return list;
    }*/
  }
}
