import 'package:flutter/material.dart';
import 'post.dart';
import 'package:html_unescape/html_unescape.dart';
import '../models/subreddit.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import '../models/comment.dart';
import 'package:draw/draw.dart' as draw;

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
  String description;
  /// Karma of the user
  final int karma;
  /// Timestamp of the redditor's creation
  final DateTime ancientness;
  ///List of names of subscribed subreddits
  final List<String> subscribedSubreddits;

  draw.Redditor drawInterface;


  /// Redditor const constructor
  /*Redditor({Key? key,
      required this.bannerUrl, required this.pictureUrl,
      required this.displayName, required this.name,
      required this.karma, required this.ancientness,
      required this.subscribedSubreddits,
      required this.description
  }) {
    var unescape = HtmlUnescape();
    description = unescape.convert(description);
  }*/

  Redditor.fromDRAW({Key? key, required this.drawInterface, required this.subscribedSubreddits}):
        description = HtmlUnescape().convert(drawInterface.data!["subreddit"]["public_description"]),
        bannerUrl = HtmlUnescape().convert(drawInterface.data!["subreddit"]["banner_img"]),
        pictureUrl = HtmlUnescape().convert(drawInterface.data!["subreddit"]["icon_img"]),
        displayName = drawInterface.displayName,
        name = "u/" + drawInterface.fullname!,
        ancientness = drawInterface.createdUtc!,
        karma = drawInterface.awardeeKarma! + drawInterface.awarderKarma! + drawInterface.commentKarma!;
  /// Get a list of loaded Subreddits the user is subscribed to
  Future<List<Subreddit>> getSubscribedSubreddits({required bool loadPosts}) async {
    List<Subreddit> subs = [];
    for (var name in subscribedSubreddits) {
      subs.add(await GetIt.I<RedditInterface>().getSubreddit(name, loadPosts: loadPosts));
    }
    return subs;
  }


  /// Get the posts from the user
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];

    await for (var submission in drawInterface.submissions.hot()) {
      posts.add(Post.fromSubmission(submission as draw.Submission));
    }
    return posts;
  }

  /// Get the comments from the user
  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    await for (var comment in drawInterface.comments.hot()) {
      comments.add(Comment.fromDraw(comment as draw.Comment));
    }
    return comments;
  }
}