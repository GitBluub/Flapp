import 'package:flutter/material.dart';
import '../views/redditor_page.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

/// Controller for Redditor Page, where the user's information will be displayed
class RedditorPageController extends StatefulWidget {
  const RedditorPageController({Key? key}) : super(key: key);

  @override
  State<RedditorPageController> createState() => _RedditorPageControllerState();
}

class _RedditorPageControllerState extends State<RedditorPageController> {

  @override
  Widget build(BuildContext context) {
    return RedditorPageView(user: GetIt.I<RedditInterface>().loggedRedditor);
  }
}