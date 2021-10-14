import 'package:flutter/material.dart';
import 'package:draw/draw.dart' show Submission;

class Post {
  Post(
      {Key? key,
      required this.authorName,
      required this.parent,
      required this.createdTime,
      required this.title,
      required this.content,
      required this.score,
      required this.link});

  Post.fromSubmission(Submission submission)
      : authorName = submission.author,
        parent = submission.subreddit.displayName,
        createdTime = submission.createdUtc,
        title = submission.title,
        content = submission.body == null ? "" : submission.body as String,
        score = submission.upvotes,
        link = submission.shortlink.toString();

  String authorName;

  String parent;

  DateTime createdTime;

  String title;

  String content;

  int score;

  String link;
}
