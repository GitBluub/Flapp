import 'package:flutter/material.dart';
import '../views/search_page.dart';
import '../models/reddit_interface.dart';
import 'package:get_it/get_it.dart';

class SearchPageController extends StatelessWidget {
  const SearchPageController({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return SearchPageView(/*user: GetIt.I<RedditInterface>().loggedRedditor*/);
  }
}
