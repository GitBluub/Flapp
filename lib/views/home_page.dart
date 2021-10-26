import 'package:flutter/material.dart';
import 'flapp_page.dart';
import 'loading.dart';
import 'post_holder_carousel.dart';
import '../models/subreddit.dart';
import '../models/post_holder.dart';

/// View for Home/Main Page
class HomePageView extends StatelessWidget {
  const HomePageView({Key? key, required this.frontPageFetcher, required this.subscribedSubredditsFetcher}) : super(key: key);
  /// Fetcher for Holder for post in reddit's front page
  final Future<PostHolder> Function() frontPageFetcher;
  /// Fetcher for List of filled subreddits, associating with names
  final Map<String, Future<Subreddit> Function()> subscribedSubredditsFetcher;

  @override
  Widget build(BuildContext context) {

    Map<String, Future<PostHolder>Function()> holders = {};

    holders["Home"] = frontPageFetcher;
    subscribedSubredditsFetcher.forEach((key, value) {
      holders[key] = value;
    });
    return FlappPage(
      title: "Home",
      body: PostHolderCarousel(holdersFetcher: holders),
    );
  }
}