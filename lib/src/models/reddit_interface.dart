import 'dart:convert';
import 'dart:typed_data';
import 'package:draw/draw.dart' as draw;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'redditor.dart';
import 'subreddit.dart';
import 'post_holder.dart';
import 'post.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flapp/src/views/posts_list.dart';

/// Object that allow simple call to API, Singleton
class RedditInterface {
  /// Boolean to know if user is authenticated
  bool connected = false;

  /// Allows quick access to logged user.
  /// This allows not having to fetch it at every page
  late Redditor loggedRedditor;

  /// Reddit object from DRAW
  late draw.Reddit reddit;

  /// Fetch logged Redditor using API
  Future<Redditor> _fetchLoggedRedditor() async {
    var loggedUser = await reddit.user.me();
    final subredditsstream = reddit.user.subreddits();
    List<String> subredditSubscribed = [];
    Map<String, dynamic> prefs = {};

    await for (var sub in subredditsstream) {
      subredditSubscribed.add(sub.displayName);
    }
    prefs = Map<String, dynamic>.from(await reddit.get('/api/v1/me/prefs', params: {"raw_json": "1"}, objectify: false));
    loggedRedditor = Redditor.fromDRAW(drawInterface: loggedUser as draw.Redditor, subscribedSubreddits: subredditSubscribed, prefs: prefs);
    return loggedRedditor;
  }

  /// Get list of subreddits matching name
  /// The subreddits don't hold posts
  Future<List<Subreddit>> searchSubreddits(String name) async {
    var searchRes = await reddit.subreddits.searchByName(name);
    List<Subreddit> sublist = [];

    for (var sub in searchRes) {
      var populated = await sub.populate();
      sublist.add(Subreddit.fromDRAW(populated, []));
    }
    return sublist;
  }

  /// Get a subreddit with name
  /// The subreddit get a certain number of posts
  Future<Subreddit> getSubreddit(String name, {bool loadPosts = true}) async {
    draw.SubredditRef subRef = reddit.subreddit(name);
    draw.Subreddit sub = await subRef.populate();
    List<Post> posts = [];

    if (loadPosts) {
      await for (var post in sub.hot(limit: PostsList.pageSize)) {
        posts.add(Post.fromSubmission(post as draw.Submission));
      }
    }
    return Subreddit.fromDRAW(sub, posts);
  }

  /// Create an API connection using previously created credentials
  Future<void> restoreAPIConnection() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path/credentials.json');
      final cred = await file.readAsString();
      if (cred == "") {
        throw Exception("Empty creds");
      }
      reddit = draw.Reddit.restoreInstalledAuthenticatedInstance(cred,
          clientId: clientId, userAgent: "flapp_application");
      await _fetchLoggedRedditor();
      connected = true;
    } catch (e) {
      return;
    }
  }

  /// Create an API connection using previously created credentials
  Future<void> restoreAPIConnectionTest() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];

    try {
      final file = File('./credentials.json');
      final cred = await file.readAsString();
      if (cred == "") {
        throw Exception("Empty creds");
      }
      reddit = draw.Reddit.restoreInstalledAuthenticatedInstance(cred,
          clientId: clientId, userAgent: "flapp_application");
      await _fetchLoggedRedditor();
      connected = true;
    } catch (e) {
      return;
    }
  }

  /// Get the file that holds the log credentials
  Future<File> getCredentialsFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return File('$path/credentials.json');
  }

  Future<PostHolder> getFrontPage() async {
    List<Post> posts = [];
    await for (var post in draw.FrontPage(reddit).hot(limit: PostsList.pageSize)) {
      posts.add(Post.fromSubmission(post as draw.Submission));
    }

    return PostHolder(posts: posts, drawInterface: draw.FrontPage(reddit));
  }

  /// Creates an API connection and save credentials to a file
  Future<void> createAPIConnection() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];
    final file = await getCredentialsFile();

    if (clientId == null) {
      throw Exception("No FLAPP_API_KEY env var found...");
    }
    reddit = draw.Reddit.createInstalledFlowInstance(
        clientId: clientId,
        userAgent: "flapp",
        redirectUri: Uri.parse("flapp://home"));
    // Present the dialog to the user
    final result = await FlutterWebAuth.authenticate(
      url: reddit.auth.url(["*"], "flapp", compactLogin: true).toString(),
      callbackUrlScheme: "flapp",
    );

    // Extract token from resulting url
    final code = Uri.parse(result).queryParameters['code'];

    await reddit.auth.authorize(code.toString());
    await file.writeAsString(reddit.auth.credentials.toJson());
    await _fetchLoggedRedditor();
    connected = true;
  }

  /// Close API connection and delete credentials
  Future<void> stopAPIConnection() async {
    File credentials = await getCredentialsFile();

    if (credentials.existsSync()) {
      await credentials.delete();
    }
    connected = false;
  }

  Future get(String api, {Map<String, String?>? params, bool objectify = true, bool followRedirects = false})
  {
    return reddit.get(api, params: params, objectify: objectify, followRedirects: followRedirects);
  }

  Future post(String api, Map<String, String> body, {Map<String, Uint8List?>? files, Map? params, bool discardResponse = false, bool objectify = true})
  {
    return reddit.post(api, body, files: files, params: params, discardResponse: discardResponse, objectify: objectify);
  }

  Future put(String api, {Map<String, String>? body})
  {
    return reddit.put(api, body: body);
  }

  Future patch(String api, Map<String, String> out)
  {
    return http.patch(Uri.parse("https://oauth.reddit.com$api"), body: json.encode(out), headers:
        {
        "Authorization": "Bearer " + reddit.auth.credentials.accessToken,
        }
    );
  }
}
