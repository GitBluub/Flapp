import 'post.dart';
import 'package:flutter/material.dart';
import 'sort.dart';
import 'package:draw/draw.dart' as draw;
import '../views/subreddit_posts_list.dart';

class Subreddit {
  final String displayName;

  List<Post> posts;

  int membersCount;

  final String description;

  final String link;

  final String bannerUrl;

  final String pictureUrl;

  final PostSort sortingMethod;

  final PostTopSort? topSortingMethod;

  draw.Subreddit drawInterface;

  Subreddit.fromDRAW(this.drawInterface, this.posts):
      displayName = drawInterface.displayName,
      description = drawInterface.title,
      bannerUrl = drawInterface.headerImage.toString(),
      pictureUrl = drawInterface.iconImage.toString(),
      membersCount = 0, // TODO
      link = 'https://www.reddit.com/r/'+ drawInterface.displayName,
      sortingMethod = PostSort.hot,
      topSortingMethod = null;

  Future<void>refreshPosts() async
  {
    int postsCount = posts.length;
    posts = [];

    var refreshedPosts;

    switch (sortingMethod) {
      case PostSort.hot:
        refreshedPosts = drawInterface.hot(limit: postsCount);
        break;
      case PostSort.top:
        refreshedPosts = drawInterface.top(limit: postsCount);
        break;
      case PostSort.newest:
        refreshedPosts = drawInterface.newest(limit: postsCount);
        break;
      case PostSort.rising:
        refreshedPosts = drawInterface.rising(limit: postsCount);
        break;
    }
    posts = [await for (var post in refreshedPosts) Post.fromSubmission(post as draw.Submission)];
  }

  Future<void>fetchMorePosts() async
  {
    // TODO: Find what parameter to pass fetcher
    String? lastPage = posts.isNotEmpty ? null : null;
    var fetchedPosts;

    switch (sortingMethod) {
      case PostSort.hot:
        fetchedPosts = drawInterface.hot(limit: SubredditPostsList.pageSize, after: lastPage);
        break;
      case PostSort.top:
        fetchedPosts = drawInterface.top(limit: SubredditPostsList.pageSize, after: lastPage);
        break;
      case PostSort.newest:
        fetchedPosts = drawInterface.newest(limit: SubredditPostsList.pageSize, after: lastPage);
        break;
      case PostSort.rising:
        fetchedPosts = drawInterface.rising(limit: SubredditPostsList.pageSize, after: lastPage);
        break;
    }
    await for (var post in fetchedPosts) {
      var posted = Post.fromSubmission(post as draw.Submission);
      print("Fetched ${posted.title}");
      posts.add(posted);
    }
    //posts += [await for (var post in fetchedPosts) Post.fromSubmission(post as draw.Submission)];
  }

}