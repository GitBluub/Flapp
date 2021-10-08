import 'package:flutter/material.dart';
import 'post.dart';

class Redditor {
  String bannerUrl;

  String pictureUrl;

  String displayName;

  String name;

  int karma;

  DateTime ancientness;

  List<String> subscribedSubreddits;

  List<Post> posts;

  Redditor(this.bannerUrl, this.pictureUrl, this.displayName, this.name,
      this.karma, this.ancientness, this.subscribedSubreddits, this.posts);
}