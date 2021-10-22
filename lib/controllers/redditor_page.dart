import 'package:flutter/material.dart';
import '../views/redditor_page.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class RedditorPageController extends StatelessWidget {
  const RedditorPageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RedditorPageView(user: GetIt.I<RedditInterface>().loggedRedditor);
  }
}