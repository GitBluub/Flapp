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

  @override
  Widget build(BuildContext context) {
    return HomePageView(user: GetIt.I<RedditInterface>().loggedRedditor);
  }
}
