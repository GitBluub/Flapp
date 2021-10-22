import 'package:flutter/material.dart';
import 'post.dart';
import 'package:html_unescape/html_unescape.dart';

class Redditor {
  final String bannerUrl;

  final String pictureUrl;

  final String displayName;

  final String name;

  String description;

  final int karma;

  final DateTime ancientness;

  final List<String> subscribedSubreddits;

  final List<Post> posts;

  Redditor({Key? key,
      required this.bannerUrl, required this.pictureUrl,
      required this.displayName, required this.name,
      required this.karma, required this.ancientness,
      required this.subscribedSubreddits, required this.posts,
      required this.description
  }) {
    var unescape = HtmlUnescape();
    description = unescape.convert(description);
  }
}