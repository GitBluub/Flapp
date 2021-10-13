import 'package:flutter/material.dart';
import '../models/redditor.dart';
import '../models/subreddit.dart';
import '../views/home_page.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<HomePageController> createState() => _HomePageControllerState();
  
}

class _HomePageControllerState extends State<HomePageController>
{
  Redditor? redditor;
  
  List<Subreddit>? subreddits;
  @override
  Widget build(BuildContext context) {
    //need user
    //need list of subscribed subs
    //for each subs, vue of posts
    return HomePageVue();
  }
}