import 'package:flutter/material.dart';
import 'post.dart';

/// Entity holding a Redditor's info
class Redditor {
  /// URL to Redditor's banner
  final String bannerUrl;
  /// URL to Redditor's profile picture
  final String pictureUrl;
  /// Display Name of the user
  final String displayName;
  /// Name of the user
  final String name;
  /// Profile's bio
  final String description;
  /// Karma of the user
  final int karma;
  /// Timestamp of the redditor's creation
  final DateTime ancientness;
  ///List of names of subscribed subreddits
  final List<String> subscribedSubreddits;
  ///List of posted possts
  final List<Post> posts;

  /// Redditor const constructor
  const Redditor({Key? key,
      required this.bannerUrl, required this.pictureUrl,
      required this.displayName, required this.name,
      required this.karma, required this.ancientness,
      required this.subscribedSubreddits, required this.posts,
      required this.description
  });
}