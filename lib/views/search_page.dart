import 'package:flutter/material.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<StatefulWidget> createState() => _SearchPageViewWidget();

}

class _SearchPageViewWidget extends State<SearchPageView>
{
  @override
  Widget build(BuildContext context) {
    return FlappPage(body: Container(), title: "Search");
  }
}