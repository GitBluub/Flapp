import 'package:flutter/material.dart';


class SearchPageController extends StatefulWidget {
  const SearchPageController({Key? key}) : super(key: key);

  @override
  State<SearchPageController> createState() => _SearchPageControllerState();
}

class _SearchPageControllerState extends State<SearchPageController> {
  Redditor? redditor;
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    setState(() => redditor = null);
  }
  @override
  Widget build(BuildContext context) {
    if (fetched) {
      return RedditorPageView(user: redditor);
    }
    GetIt.I<RedditInterface>().getLoggedRedditor().then((redditorValue) {
      setState(() {
        redditor = redditorValue;
        fetched = true;
      });
    });
    return RedditorPageView(user: redditor);
  }
}