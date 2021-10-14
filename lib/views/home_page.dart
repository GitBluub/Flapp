import 'package:flutter/material.dart';
import '../models/redditor.dart';
import '../views/loading.dart';
import 'flapp_page.dart';
import 'subreddits_carousel.dart';

class HomePageVue extends StatefulWidget {
  const HomePageVue({Key? key, required this.user}) : super(key: key);
  final Redditor? user;

  @override
  State<HomePageVue> createState() => _HomePageVueState();
}

class _HomePageVueState extends State<HomePageVue> {
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return const LoadingWidget();
    }

    Redditor user = widget.user as Redditor;

    return FlappPage(
      user: user,
      title: user.name,
      body: SubredditsCarousel(subredditsNames: user.subscribedSubreddits),
    );
  }
}