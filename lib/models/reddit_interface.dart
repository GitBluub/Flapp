import 'package:draw/draw.dart' as draw;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'redditor.dart';
import 'subreddit.dart';
import 'post.dart';

class RedditInterface {

  var _reddit;

  Future<Redditor> getLoggedRedditor() async {
    var loggedUser = await _reddit.user.me();
    final subredditsstream = _reddit.user.subreddits();
    List<String> subredditSubscribed = [];

    await for (var sub in subredditsstream) {
      subredditSubscribed.add(sub.displayName as String);
    }
    return Redditor(
        description: loggedUser.data["subreddit"]["description"],
        bannerUrl: loggedUser.data["subreddit"]["banner_img"].replaceAll("&amp;", "&"),
        pictureUrl: loggedUser.data["subreddit"]["icon_img"].replaceAll("&amp;", "&"),
        displayName: loggedUser.displayName,
        name: "u/" + loggedUser.fullname,
        ancientness: loggedUser.createdUtc,
        karma: loggedUser.awardeeKarma + loggedUser.awarderKarma + loggedUser.commentKarma,
        subscribedSubreddits: subredditSubscribed,
        posts: []
    );
  }

  Future<List<Subreddit>> searchSubreddits(String name) async {
    var searchRes = _reddit.subreddits.search(name);
    List<Subreddit> sublist = [];

    await for (var sub in searchRes) {
      List<Post> posts = [];
      await for (var post in sub.hot(limit: 10)) {
        posts.add(Post.fromSubmission(post));
      }
      sublist.add(Subreddit(
        description: sub.title,
        displayName: sub.displayName,
        fullName: sub.fullName,
        posts: posts,
        bannerUrl: sub.bannerImage(),
        pictureUrl: sub.iconImage(),
        membersCount: sub.traffic().subscribtion,
        link: 'https://www.reddit.com/r/'+ sub.displayName,
      ));
    }
    return sublist;
  }

  Future<Subreddit> getSubreddit(String name) async {
    draw.SubredditRef subRef = _reddit.subreddit(name);
    draw.Subreddit sub = await subRef.populate();
    List<Post> posts = [];

    await for (var post in sub.hot(limit: 10)) {
      posts.add(Post.fromSubmission(post as draw.Submission));
    }
    return Subreddit(
        description: sub.title,
        displayName: sub.displayName,
        fullName: sub.fullname == null ? "" : sub.fullname as String,
        posts: posts,
        bannerUrl: sub.headerImage.toString(),
        pictureUrl: sub.iconImage.toString(),
        membersCount: 0,
    link: 'https://www.reddit.com/r/'+ sub.displayName,);
  }

  Future<void> createAPIConnection() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];

    /*
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/credentials.json');

    try {
      final cred = await file.readAsString();
      print("cred: $cred");
      _reddit = Reddit.restoreInstalledAuthenticatedInstance(cred);
      return;
    } catch (e) {
      print("didnt find cred");
    }*/

    if (clientId == null) {
      throw Exception("No FLAPP_API_KEY env var found...");
    }
    _reddit = draw.Reddit.createInstalledFlowInstance(
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
    //Lawait file.writeAsString(_reddit.auth.credentials.toJson());
    await _reddit.auth.authorize(code.toString());
  }
}
