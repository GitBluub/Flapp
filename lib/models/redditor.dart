import 'package:flutter/material.dart';
import 'post.dart';

class Redditor {
  final String bannerUrl;

  final String pictureUrl;

  final String displayName;

  final String name;

  final String description;

  final int karma;

  final DateTime ancientness;

  final List<String> subscribedSubreddits;

  final List<Post> posts;

  const Redditor({Key? key,
      required this.bannerUrl, required this.pictureUrl,
      required this.displayName, required this.name,
      required this.karma, required this.ancientness,
      required this.subscribedSubreddits, required this.posts,
      required this.description
  });
}