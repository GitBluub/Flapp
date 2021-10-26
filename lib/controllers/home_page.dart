import 'package:flutter/material.dart';
import '../views/home_page.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import '../models/post_holder.dart';
import '../models/subreddit.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController>
{
  PostHolder? frontPage;
  List<Subreddit>? subreddits;

  @override
  void initState() {
    super.initState();
    GetIt.I<RedditInterface>().getFrontPage().then((value) {
      setState((){
        frontPage = value;
      });
    });
    GetIt.I<RedditInterface>().loggedRedditor.getSubscribedSubreddits(loadPosts: true).then((value) {
      setState((){
        subreddits = value;
      });
    });
  }

  @override
  Widget build (BuildContext context) {
    return HomePageView(frontPage: frontPage, subscribedSubreddits: subreddits);
  }
}
