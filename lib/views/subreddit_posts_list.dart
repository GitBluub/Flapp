import 'package:flutter/material.dart';
import 'post_preview.dart';
import 'loading.dart';
import '../models/subreddit.dart';

class SubredditPostsList extends StatefulWidget {
  final Subreddit? subreddit;

  const SubredditPostsList({Key? key, required this.subreddit}): super(key: key);

  @override
  State<StatefulWidget> createState() => _SubredditPostsListState();
}

class _SubredditPostsListState extends State<SubredditPostsList>
{
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

    return ListView(
      children: [for (var post in sub.posts) PostPreview(post: post)],
    );
  }
}