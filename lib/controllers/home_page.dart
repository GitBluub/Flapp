import 'package:flutter/material.dart';
import '../models/redditor.dart';
import '../views/home_page.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  Redditor? redditor;
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    setState(() => redditor = null);
  }

  @override
  Widget build(BuildContext context) {
    if (fetched) {
      return HomePageView(user: redditor);
    }
    GetIt.I<RedditInterface>().getLoggedRedditor().then((redditorValue) {
      setState(() {
        redditor = redditorValue;
        fetched = true;
      });
    });
    return HomePageView(user: redditor);
  }
}
