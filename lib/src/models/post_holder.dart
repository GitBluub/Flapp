import 'package:draw/draw.dart' as draw;
import 'post.dart';
import 'package:flutter/material.dart';
import 'package:flapp/src/views/posts_list.dart';

/// Enumeration of possible sorting method for posts
enum PostSort {
  hot,
  top,
  newest,
  rising,
  random
}

/// Enumeration of possible top sorting method for posts
enum PostTopSort {
  hour,
  day,
  week,
  month,
  year,
  all
}

/// Entity that holds posts and a draw object to fetch them
class PostHolder
{
  /// Current sorting method for posts
  PostSort sortingMethod = PostSort.hot;
  /// Current top sorting method for posts
  PostTopSort? topSortingMethod;
  /// Subreddit instance from DRAW
  var drawInterface;
  /// List of posts
  List<Post> posts;

  PostHolder({Key? key, required this.posts, required this.drawInterface});

  ///Refresh all stored posts using sorting method
  Future<void>refreshPosts() async
  {
    var refreshedPosts = fetch(limit: posts.length);

    posts = [await for (var post in refreshedPosts) Post.fromSubmission(post as draw.Submission)];
  }
  /// Get more posts
  Future<void>fetchMorePosts() async
  {
    String? lastPage = posts.isNotEmpty ? posts.last.fullName : null;
    var fetchedPosts = fetch(after: lastPage);

    posts.addAll([await for (var post in fetchedPosts) Post.fromSubmission(post as draw.Submission)]);
  }
  /// Post Fetcher
  Stream fetch({int limit = PostsList.pageSize, String? after})
  {
    switch (sortingMethod) {
      case PostSort.hot:
        return drawInterface.hot(limit: limit, after: after);
      case PostSort.top:
        switch (topSortingMethod) {
          case PostTopSort.hour:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.hour);
          case PostTopSort.day:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.day);
          case PostTopSort.week:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.week);
          case PostTopSort.month:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.month);
          case PostTopSort.year:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.year);
          case PostTopSort.all:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.all);
          case null:
            return drawInterface.top(limit: limit, after: after, timeFilter: draw.TimeFilter.all);
        }
      case PostSort.newest:
        return drawInterface.newest(limit: limit, after: after);
      case PostSort.random:
        return drawInterface.randomRising(limit: limit, after: after);
      case PostSort.rising:
        return drawInterface.rising(limit: limit, after: after);
    }
  }
}