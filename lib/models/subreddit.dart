import 'post.dart';
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
    var refreshedPosts = fetch(posts.length, null);

    posts = [await for (var post in refreshedPosts) Post.fromSubmission(post as draw.Submission)];
  }

  Future<void>fetchMorePosts() async
  {
    // TODO: Find what parameter to pass fetcher
    String? lastPage = posts.isNotEmpty ? posts.last.fullName : null;
    var fetchedPosts = fetch(1, lastPage);

    /*'''await for (var post in fetchedPosts) {
      var posted = Post.fromSubmission(post as draw.Submission);
      print("Fetched ${posted.submission.data}");
      posts.add(posted);
    }*/
    posts.addAll([await for (var post in fetchedPosts) Post.fromSubmission(post as draw.Submission)]);
  }

  Stream fetch(int? limit, String? after)
  {
    switch (sortingMethod) {
      case PostSort.hot:
        return drawInterface.hot(limit: SubredditPostsList.pageSize, after: after);
      case PostSort.top:
        return drawInterface.top(limit: SubredditPostsList.pageSize, after: after);
      case PostSort.newest:
        return drawInterface.newest(limit: SubredditPostsList.pageSize, after: after);
      case PostSort.rising:
        return drawInterface.rising(limit: SubredditPostsList.pageSize, after: after);
    }
  }

}