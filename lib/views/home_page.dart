import 'package:flutter/material.dart';
import '../models/redditor.dart';
import 'flapp_page.dart';
import 'subreddits_carousel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {

    return FlappPage(
      title: "Home",
      body: SubredditsCarousel(subredditsNames: widget.user.subscribedSubreddits),
    );
  }
}