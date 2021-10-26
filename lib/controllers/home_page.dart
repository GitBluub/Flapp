import 'package:flutter/material.dart';
import '../views/home_page.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import '../models/subreddit.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController>
{
  @override
  Widget build (BuildContext context) {
    Map<String, Future<Subreddit> Function()> subredditFetchers = {};

    for (String name in GetIt.I<RedditInterface>().loggedRedditor.subscribedSubreddits) {
      subredditFetchers[name] = () {
        return GetIt.I<RedditInterface>().getSubreddit(name, loadPosts: true);
      };
    }

    return HomePageView(
      frontPageFetcher: GetIt.I<RedditInterface>().getFrontPage, subscribedSubredditsFetcher: subredditFetchers
    );
  }
}
