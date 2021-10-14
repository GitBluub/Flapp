import 'package:flutter/material.dart';
import '../models/redditor.dart';
import '../views/loading.dart';
import 'flapp_page.dart';
import 'subreddits_carousel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key, required this.user}) : super(key: key);
  final Redditor? user;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return const LoadingWidget();
    }

    Redditor user = widget.user as Redditor;

    return FlappPage(
      user: user,
      title: "Home",
      body: SubredditsCarousel(subredditsNames: user.subscribedSubreddits),
    );
  }
}