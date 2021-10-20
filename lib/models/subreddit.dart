import 'post.dart';
import 'sort.dart';
import 'package:draw/draw.dart' as draw;

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
      displayName = 'r/' + drawInterface.displayName,
      description = drawInterface.data!['public_description'],
      bannerUrl = drawInterface.mobileHeaderImage.toString(),
      pictureUrl = drawInterface.iconImage.toString(),
      membersCount = drawInterface.data!['subscribers'],
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

}