import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:io' show Platform;

class RedditInterface {

  var _reddit;

  RedditInterface() {
    _createAPIConnection();
  }

  void _createAPIConnection() async {
    String? clientId = Platform.environment['FLAPP_API_KEY'];

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
