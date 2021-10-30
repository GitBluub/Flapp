import 'package:flapp/src/views/redditor_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flapp/src/models/redditor.dart';
import 'package:flapp/src/models/post.dart';
import 'package:flapp/src/models/reddit_interface.dart';
import 'package:flapp/src/models/subreddit.dart';
import 'package:flapp/src/models/comment.dart';

/// Controller for a redditor's page
class RedditorPageController extends StatefulWidget {
  const RedditorPageController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RedditorPageControllerState();
}

class _RedditorPageControllerState extends State<RedditorPageController>
{
  Redditor user = GetIt.I<RedditInterface>().loggedRedditor;
  List<Subreddit>? subreddits;
  List<Post>? posts;
  List<Comment>? comments;

  @override
  void initState() {
      super.initState();
      user.getSubscribedSubreddits(loadPosts: false).then((subs) {
      subreddits = subs;
      setState(() {});
    });
      user.getPosts().then((p) {
      posts = p;
      setState(() {});
    });
      user.getComments().then((c) {
      comments = c;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return RedditorPageView(user: user, subreddits: subreddits, posts: posts, comments: comments);
  }
}