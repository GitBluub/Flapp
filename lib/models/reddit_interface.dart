import 'package:draw/draw.dart' show Reddit;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'redditor.dart';
import 'subreddit.dart';

class RedditInterface {

  var _reddit;

  Future<Redditor> getLoggedRedditor() async {
    var user = _reddit.user;
    var loggedUser = await user.me();
    return Redditor(
        description: user.subreddit.title(),
        bannerUrl: user.subreddit.bannerImage(),
        pictureUrl: user.subreddit.iconImage(),
        displayName: loggedUser.displayName,
        name: loggedUser.fullName,
        ancientness: loggedUser.createdUtc,
        karma: loggedUser.awardeeKarma + loggedUser.awarderKarma + loggedUser.commentKarma,
        subscribedSubreddits: user.subreddits(),
        posts: []
    );
  }

  Future<List<Subreddit>> searchSubreddits(String name) async {
    var searchRes = _reddit.subreddits.search(name);
    List<Subreddit> sublist = [];
    for (var sub in searchRes) {
      sublist.add(Subreddit(
        description: sub.title,
        displayName: sub.displayName,
        fullName: sub.fullName,
        posts: [],
        bannerUrl: sub.bannerImage(),
        pictureUrl: sub.iconImage(),
        membersCount: sub.traffic().subscribtion,
        link: 'troll',
      ));
    }
    return sublist;
  }

  Future<Subreddit?> getSubreddit(String name) async {
    List<Subreddit> subs = await searchSubreddits(name);

    if (subs == []) {
      return null;
    }
    return subs[0];
  }

  Future<void> createAPIConnection() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];

    if (clientId == null) {
      throw Exception("No FLAPP_API_KEY env var found...");
    }
    _reddit = Reddit.createInstalledFlowInstance(
        clientId: clientId,
        userAgent: "flapp",
        redirectUri: Uri.parse("flapp://home"));
    // Present the dialog to the user
    final result = await FlutterWebAuth.authenticate(
      url: _reddit.auth.url(["*"], "flapp", compactLogin: true).toString(),
      callbackUrlScheme: "flapp",
    );

    // Extract token from resulting url
    final code = Uri.parse(result).queryParameters['code'];
    await _reddit.auth.authorize(code.toString());
  }
}
