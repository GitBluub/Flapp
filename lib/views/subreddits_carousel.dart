import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/subreddit.dart';

class SubredditsCarousel extends StatefulWidget {
  final List<String> subredditsNames;
  const SubredditsCarousel({Key? key, required this.subredditsNames})
      : super(key: key);

  @override
  State<SubredditsCarousel> createState() => _SubredditsCarouselState();
}

class _SubredditsCarouselState extends State<SubredditsCarousel> {
  Map<String, Subreddit?> subreddits = {};

  @override
  void initState() {
    super.initState();
    setState(() => {for (var name in widget.subredditsNames) name: null});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.subredditsNames.length,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: TabBar(isScrollable: true, tabs: [
                for (var name in widget.subredditsNames) Tab(text: name)
              ]),
            ),
            body: TabBarView(children: [
              // TODO Post Preview
              for (var name in widget.subredditsNames) Tab(text: name)
            ]
            )
        )
    );
  }
}
