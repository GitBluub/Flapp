import 'package:flutter/material.dart';
import 'package:flapp/src/views/settings_page.dart';
import 'package:get_it/get_it.dart';
import 'package:flapp/src/models/reddit_interface.dart';

/// Controller for Settings Page, where the user can change settings
class SettingsPageController extends StatelessWidget {
  const SettingsPageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map <String, String> settings = {
      'email_post_reply': "Get an email when your post receives a reply",
      'email_username_mention': "Get an email when a redditor mentions you",
      'email_comment_reply': "Get an email when your comment receives a reply",
      'over_18': "Allow NSFW content",
      'video_autoplay': "Autoplay videos",
      'search_include_over_18': "Display NSFW subreddits in searches",
    };
    return SettingsPageView(user: GetIt.I<RedditInterface>().loggedRedditor, settings: settings);
  }
}