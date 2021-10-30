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

  Widget _getEmptySectionWidget(IconData icon, String message) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(30),
          child: Icon(icon)),
      Text(message)
    ]);
  }

  Widget _getPostsWidget() {
    if (widget.posts == null) {
      return const LoadingWidget();
    }
    List<Post> posts = widget.posts as List<Post>;
    if (posts.isEmpty) {
      return _getEmptySectionWidget(Icons.insert_comment, "No post!");
    }
    return ListView(shrinkWrap: true, children: [
      for (var p in widget.posts!)
        PostWidget(
          preview: true,
          post: p,
          displaySubName: true,
        )
    ]);
  }

  Widget _getCommentsWidget() {
    if (widget.comments == null) {
      return const LoadingWidget();
    }
    if (widget.comments!.isEmpty) {
      return _getEmptySectionWidget(Icons.insert_comment, "No comment!");
    }
    return ListView(shrinkWrap: true, children: [
      for (var c in widget.comments!) CommentWidget(comment: c)
    ]);
  }

  Widget _getSubredditsWidget() {
    if (widget.subreddits == null) {
      return const LoadingWidget();
    }
    if (widget.subreddits!.isEmpty) {
      return _getEmptySectionWidget(Icons.bookmark, "No subreddit!");
    }
    return ListView(shrinkWrap: true, children: [
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String ancientnessFormat = 'Redditor since ';

    Map<String, Widget> tabs = {
      'Posts': _getPostsWidget(),
      'Comments': _getCommentsWidget(),
      'Subredddits': _getSubredditsWidget()
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
          Row(children: [
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
