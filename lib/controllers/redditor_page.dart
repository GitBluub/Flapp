import 'package:flutter/material.dart';
import '../views/redditor_page.dart';
import '../models/redditor.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class RedditorPageController extends StatefulWidget {
  const RedditorPageController({Key? key}) : super(key: key);

  @override
  State<RedditorPageController> createState() => _RedditorPageControllerState();
}

class _RedditorPageControllerState extends State<RedditorPageController> {
  Redditor? redditor;

  @override
  void initState() {
    super.initState();
    setState(() => redditor = null);
  }
  @override
  Widget build(BuildContext context) {
    setState(() async => redditor = await GetIt.I<RedditInterface>().getLoggedRedditor());
    return RedditorPageVue(user: redditor);
  }
}