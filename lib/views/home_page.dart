import 'package:flutter/material.dart';
import 'flapp_page.dart';
import 'loading.dart';
import 'post_holder_carousel.dart';
import '../models/subreddit.dart';
import '../models/post_holder.dart';

/// View for Home/Main Page
class HomePageView extends StatelessWidget {
  HomePageView({Key? key, required this.frontPage, required this.subscribedSubreddits}) : super(key: key);
  /// Holder for post in reddit's front page
  PostHolder? frontPage;
  /// List of filled subreddits
  List<Subreddit>? subscribedSubreddits;

  @override
  Widget build(BuildContext context) {
    
    if (frontPage == null || subscribedSubreddits == null) {
      return const LoadingWidget();
    }
    Map<String, PostHolder> holders = {};
    holders["Home"] = frontPage!;
    for (Subreddit s in subscribedSubreddits!) {
      holders[s.displayName] = s;
    }
    return FlappPage(
      title: "Home",
      body: PostHolderCarousel(holders: holders),
    );
  }
}