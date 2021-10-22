import 'package:html_unescape/html_unescape.dart';

import 'post.dart';
import 'package:draw/draw.dart' as draw;
import '../views/subreddit_posts_list.dart';
import 'package:get_it/get_it.dart';
import 'reddit_interface.dart';
import 'package:http_parser/http_parser.dart';
import 'package:html_unescape/html_unescape.dart';

/// Enumeration of possible sorting method for posts
enum PostSort {
  hot,
  top,
  newest,
  rising
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

/// Entity holding Subreddit's information
class Subreddit {
  /// Display name of the subreddit
  final String displayName;
  /// List of posts
  List<Post> posts;
  /// Number of subscribers
  int membersCount = 0;
  /// Subreddit's description
  final String description = "";
  /// Short Link to subreddit
  final String link;
  /// URL to subreddit's banner
  final String bannerUrl = "";
  /// URL to subreddit's picture
  final String pictureUrl;
  /// Current sorting method for posts
  PostSort sortingMethod;
  /// Current top sorting method for posts
  PostTopSort? topSortingMethod;
  /// Logged reditor relation to subreddit
  bool subscribed;
  /// Subreddit instance from DRAW
  draw.Subreddit drawInterface;

  /// Creates a Subreddit instance from DRAW's subreddit
  Subreddit.fromDRAW(this.drawInterface, this.posts):
      displayName = drawInterface.displayName,
      pictureUrl = drawInterface.iconImage.toString(),
      link = 'https://www.reddit.com/r/'+ drawInterface.displayName,
      sortingMethod = PostSort.hot,
      subscribed = GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.contains(drawInterface.displayName),
      topSortingMethod = null
  {
      var unescape = HtmlUnescape();
      if (drawInterface.data == null) {
        return;
      }
      membersCount = drawInterface.data!['subscribers'];
      description = unescape.convert(drawInterface.data!['public_description'].toString());
      if (drawInterface.data!['mobile_banner_image'].toString() != "") {
        bannerUrl =  unescape.convert(drawInterface.data!['mobile_banner_image'].toString());
      } else {
        bannerUrl =  unescape.convert(drawInterface.data!['banner_background_image'].toString());
      }
  }

    description = HtmlUnescape().convert(description);
  }
  ///Refresh all stored posts using sorting method
  Future<void>refreshPosts() async
  {
    var refreshedPosts = fetch(posts.length, null);

    posts = [await for (var post in refreshedPosts) Post.fromSubmission(post as draw.Submission)];
  }
  /// Get more posts
  Future<void>fetchMorePosts() async
  {
    String? lastPage = posts.isNotEmpty ? posts.last.fullName : null;
    var fetchedPosts = fetch(1, lastPage);

    /*'''await for (var post in fetchedPosts) {
      var posted = Post.fromSubmission(post as draw.Submission);
      print("Fetched ${posted.submission.data}");
      posts.add(posted);
    }*/
    posts.addAll([await for (var post in fetchedPosts) Post.fromSubmission(post as draw.Submission)]);
  }
  /// Post Fetcher
  Stream fetch(int? limit, String? after)
  {
    switch (sortingMethod) {
      case PostSort.hot:
        return drawInterface.hot(limit: SubredditPostsList.pageSize, after: after);
      case PostSort.top:
        switch (topSortingMethod) {
          case PostTopSort.hour:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.hour);
          case PostTopSort.day:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.day);
          case PostTopSort.week:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.week);
          case PostTopSort.month:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.month);
          case PostTopSort.year:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.year);
          case PostTopSort.all:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.all);
          case null:
            return drawInterface.top(limit: SubredditPostsList.pageSize, after: after, timeFilter: draw.TimeFilter.all);
        }
      case PostSort.newest:
        return drawInterface.newest(limit: SubredditPostsList.pageSize, after: after);
      case PostSort.rising:
        return drawInterface.rising(limit: SubredditPostsList.pageSize, after: after);
    }
  }
  /// Call API to notify subscribtion, add name of the subreddit in redditor's subscribtion list
  Future<void> subscribe() async
  {
    await drawInterface.subscribe();
    GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.add(displayName);
  }
  /// Call API to notify unsubscribtion, remove name of the subreddit in redditor's subscribtion list
  Future<void> unsubscribe() async
  {
    await drawInterface.unsubscribe();
    GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.remove(displayName);
  }
}