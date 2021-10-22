import 'post.dart';
import 'package:draw/draw.dart' as draw;
import '../views/subreddit_posts_list.dart';
import 'package:get_it/get_it.dart';
import 'reddit_interface.dart';
import 'package:html_unescape/html_unescape.dart';

enum PostSort {
  hot,
  top,
  newest,
  rising
}

enum PostTopSort {
  hour,
  day,
  week,
  month,
  year,
  all
}

class Subreddit {
  final String displayName;

  List<Post> posts;

  int membersCount;

  String description;

  final String link;

  final String bannerUrl;

  final String pictureUrl;

  PostSort sortingMethod;

  PostTopSort? topSortingMethod;

  bool subscribed;

  draw.Subreddit drawInterface;

  Subreddit.fromDRAW(this.drawInterface, this.posts):
      displayName = drawInterface.displayName,
      description = drawInterface.data!['public_description'].toString(),
      bannerUrl = drawInterface.mobileHeaderImage.toString(),
      pictureUrl = drawInterface.iconImage.toString(),
      membersCount = drawInterface.data!['subscribers'],
      link = 'https://www.reddit.com/r/'+ drawInterface.displayName,
      sortingMethod = PostSort.hot,
      subscribed = GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.contains(drawInterface.displayName),
      topSortingMethod = null
  {
    description = HtmlUnescape().convert(description);
  }

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

  Future<void> subscribe() async
  {
    await drawInterface.subscribe();
    GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.add(displayName);
  }

  Future<void> unsubscribe() async
  {
    await drawInterface.unsubscribe();
    GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.remove(displayName);
  }

}