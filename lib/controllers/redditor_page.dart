import 'package:flapp/views/post_widget.dart';
import 'package:flapp/views/redditor_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/redditor.dart';
import '../models/post.dart';
import '../models/reddit_interface.dart';
import '../models/subreddit.dart';
import '../models/comment.dart';

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
      user.getSubscribedSubreddits().then((subs) {
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