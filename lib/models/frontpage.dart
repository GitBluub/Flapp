import 'package:draw/draw.dart' as draw;
import 'package:get_it/get_it.dart';
import 'subreddit.dart';
import 'reddit_interface.dart';
import 'post.dart';

class FrontPage {

  /// Current sorting method for posts
  PostSort sortingMethod;
  /// Current top sorting method for posts
  PostTopSort? topSortingMethod;

  /// List of posts
  List<Post> posts;

  // frontpage of draw
  final draw.FrontPage frontPage;

  FrontPage(this.posts)
  : frontPage = draw.FrontPage(GetIt.I<RedditInterface>().reddit),
    sortingMethod = PostSort.hot,
    topSortingMethod = null
  {
  }

  ///Refresh all stored posts using sorting method
  Future<void>refreshPosts() async
  {
    var refreshedPosts = fetch(limit: this.posts.length, after: null);

    this.posts = [await for (var post in refreshedPosts) Post.fromSubmission(post as draw.Submission)];
  }
  /// Get more posts
  Future<void>fetchMorePosts() async
  {
    String? lastPage = posts.isNotEmpty ? posts.last.fullName : null;
    var fetchedPosts = fetch(limit: 1, after: lastPage);
    posts.addAll([await for (var post in fetchedPosts) Post.fromSubmission(post as draw.Submission)]);
  }

  Stream fetch({int? limit = 15, String? after})
  {
    switch (sortingMethod) {
      case PostSort.hot:
        return frontPage.hot(limit: limit, after: after);
      case PostSort.top:
        switch (topSortingMethod) {
          case PostTopSort.hour:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.hour);
          case PostTopSort.day:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.day);
          case PostTopSort.week:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.week);
          case PostTopSort.month:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.month);
          case PostTopSort.year:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.year);
          case PostTopSort.all:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.all);
          case null:
            return frontPage.top(limit: limit, after: after, timeFilter: draw.TimeFilter.all);
        }
      case PostSort.newest:
        return frontPage.newest(limit: limit, after: after);
      case PostSort.rising:
        return frontPage.rising(limit: limit, after: after);
    }
  }
}