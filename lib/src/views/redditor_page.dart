import 'package:flapp/src/views/post_widget.dart';
import 'package:flutter/material.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import 'package:flapp/src/models/redditor.dart';
import 'package:flapp/src/models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:flapp/src/models/subreddit.dart';
import 'loading.dart';
import 'subreddit_widget.dart';
import 'package:flapp/src/controllers/subreddit_page.dart';
import 'package:flapp/src/models/comment.dart';
import 'comment_widget.dart';

/// View for reddditor page
class RedditorPageView extends StatefulWidget {
  const RedditorPageView(
      {Key? key,
      required this.user,
      required this.subreddits,
      required this.posts,
      required this.comments})
      : super(key: key);

  /// Redditor's entity
  final Redditor user;

  /// List of subreddits posted
  final List<Subreddit>? subreddits;

  /// List of posted posts
  final List<Post>? posts;

  /// List of comments
  final List<Comment>? comments;

  @override
  State<RedditorPageView> createState() => _RedditorPageViewState();
}

class _RedditorPageViewState extends State<RedditorPageView> {
  @override
  Widget build(BuildContext context) {
    String ancientnessFormat = 'Redditor since ';

    if (widget.subreddits == null ||
        widget.comments == null ||
        widget.posts == null) {
      return const LoadingWidget();
    }
    Map<String, Widget> tabs = {
      'Posts': widget.posts!.isNotEmpty
          ? ListView(shrinkWrap: true, children: [
              for (var p in widget.posts!)
                PostWidget(
                  preview: true,
                  post: p,
                  displaySubName: true,
                )
            ])
          : Column(children: [
              Container(
                  padding: const EdgeInsets.all(30),
                  child: const Icon(Icons.insert_comment)),
              const Text("No post!")
            ]),
      'Comments': widget.comments!.isNotEmpty
          ? ListView(shrinkWrap: true, children: [
              for (var c in widget.comments!) CommentWidget(comment: c)
            ])
          : Column(children: [
              Container(
                  padding: const EdgeInsets.all(30),
                  child: const Icon(Icons.insert_comment)),
              const Text("No comment!")
            ]),
      'Subredddits': widget.subreddits!.isNotEmpty
          ? ListView(shrinkWrap: true, children: [
              for (var s in widget.subreddits!)
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/subreddit',
                        arguments: SubredditPageArguments(s.displayName));
                  },
                  child: SubredditWidget(subreddit: s),
                )
            ])
          : Column(children: [
              Container(
                  padding: const EdgeInsets.all(30),
                  child: const Icon(Icons.bookmark)),
              const Text("No subreddit!")
            ]),
    };

    ancientnessFormat += TimeElapsed.fromDateTime(widget.user.ancientness);
    return FlappPage(
        title: widget.user.name,
        body: ListView(children: [
          Wrap(children: [
            ImageHeader(
                bannerUrl: widget.user.bannerUrl,
                pictureUrl: widget.user.pictureUrl,
                title: widget.user.displayName)
          ]),
          Row( children: [
            Container(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Text("$ancientnessFormat - ${widget.user.karma} Karma")),
          ]),
          Container(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 30, right: 15),
              child: Wrap(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.user.description))
                ],
              )),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: DefaultTabController(
                  length: tabs.length,
                  child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 48,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        automaticallyImplyLeading: false,
                        flexibleSpace: TabBar(
                          padding: EdgeInsets.zero,
                          isScrollable: false,
                          labelColor: Theme.of(context).primaryColor,
                          tabs: [for (var t in tabs.keys) Tab(text: t)],
                        ),
                      ),
                      body: TabBarView(
                        children: [for (var t in tabs.values) t],
                      )))),
        ]));
  }
}