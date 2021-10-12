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
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    setState(() => redditor = null);
  }
  @override
  Widget build(BuildContext context) {
    if (fetched)
      return RedditorPageVue(user: redditor);
    GetIt.I<RedditInterface>().getLoggedRedditor().then((redditorValue) {
      setState(() {
        redditor = redditorValue;
        fetched = true;
      });
    });
    return RedditorPageVue(user: redditor);
  }
}