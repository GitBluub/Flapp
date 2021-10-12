import 'package:draw/draw.dart' show Reddit;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'redditor.dart';

class RedditInterface {

  var _reddit;

  RedditInterface() {
  }

  Future<Redditor> getLoggedRedditor() async {
    var loggedUser = await _reddit.user.me();
    return Redditor(
        description: "Hi! I'm Bluub, and I think Binding o Isaac is the ebst game ever. I hate other video games",
        bannerUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/bannerBackgroundImage_xg901qmo8no61.png',
        pictureUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/communityIcon_ic8kuvspll861.png?width=256&s=2eeaea442bb635fd6d70ebd62de259580eff1050',
        displayName: loggedUser.displayName,
        name: loggedUser.fullName,
        ancientness: loggedUser.createdUtc,
        karma: loggedUser.awardeeKarma + loggedUser.awarderKarma + loggedUser.commentKarma,
        subscribedSubreddits: [],
        posts: []
    );
  }

  Future<void> createAPIConnection() async {
    String? clientId = dotenv.env['FLAPP_API_KEY'];

    if (clientId == null) {
      throw new Exception("No FLAPP_API_KEY env var found...");
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
