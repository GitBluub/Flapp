import 'package:flutter/material.dart';
import '../models/redditor.dart';
import 'flapp_page.dart';
import 'subreddits_carousel.dart';

/// View for Home/Main Page
class HomePageView extends StatelessWidget {
  const HomePageView({Key? key, required this.user}) : super(key: key);
  /// Logged redditor 
  final Redditor user;

  @override
  Widget build(BuildContext context) {

    return FlappPage(
      title: "Home",
      body: SubredditsCarousel(subredditsNames: user.subscribedSubreddits),
    );
  }
}