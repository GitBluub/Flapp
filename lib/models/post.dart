import 'package:flutter/material.dart';

class Post {
  final String authorName;

  final String parent;

  final DateTime createdTime;

  final String title;

  final String content;

  final int upVotes;

  final int downVotes;

  final String link;

  const Post({Key? key, required this.authorName, required this.parent, required this.createdTime, required this.title, required this.content,
    required this.upVotes, required this.downVotes, required this.link});
}