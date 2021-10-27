import 'package:flutter/material.dart';
import 'package:flapp/src/views/search_page.dart';

/// Controller for Search Page, where the user can search for subreddits
class SearchPageController extends StatelessWidget {
  const SearchPageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchPageView();
  }
}
