import 'package:flutter/material.dart';
import '../views/search_page.dart';
import '../models/reddit_interface.dart';
import 'package:get_it/get_it.dart';

/// Controller for Search Page, where the user can search for subreddits
class SearchPageController extends StatelessWidget {
  const SearchPageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchPageView(/*user: GetIt.I<RedditInterface>().loggedRedditor*/);
  }
}
