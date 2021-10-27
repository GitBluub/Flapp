import 'package:html_unescape/html_unescape.dart';
import 'post_holder.dart';

import 'post.dart';
import 'package:get_it/get_it.dart';
import 'reddit_interface.dart';

/// Entity holding Subreddit's information
class Subreddit extends PostHolder {
  /// Display name of the subreddit
  final String displayName;
  /// Number of subscribers
  int membersCount = 0;
  /// Subreddit's description
  String description = "";
  /// Short Link to subreddit
  final String link;
  /// URL to subreddit's banner
  String bannerUrl = "";
  /// URL to subreddit's picture
  final String pictureUrl;
  /// Logged redditor relation to subreddit
  bool subscribed;


  /// Creates a Subreddit instance from DRAW's subreddit
  Subreddit.fromDRAW(var drawInterface, List<Post> posts):
      displayName = drawInterface.displayName,
      pictureUrl = drawInterface.iconImage.toString(),
      link = 'https://www.reddit.com/r/'+ drawInterface.displayName,
      subscribed = GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits.contains(drawInterface.displayName),
      super(posts: posts, drawInterface: drawInterface)
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
      description = HtmlUnescape().convert(description);
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