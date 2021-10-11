import 'post.dart';
import 'package:flutter/material.dart';

class Subreddit {
  final String displayName;

  final String fullName;

  final List<Post> posts;

  final int membersCount;

  final String description;

  final String link;

  const Subreddit({Key? key, required this.displayName, required this.fullName, required this.posts, required this.membersCount,
  required this.description, required this.link});
}