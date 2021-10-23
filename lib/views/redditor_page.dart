import 'package:flutter/material.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';
import 'package:time_elapsed/time_elapsed.dart';
import '../models/subreddit.dart';
import 'loading.dart';
import 'subreddit_widget.dart';
import '../controllers/subreddit_page.dart';

/// View for reddditor page
class RedditorPageView extends StatefulWidget {
  const RedditorPageView({Key? key, required this.user}) : super(key: key);

  /// Redditor's entity
  final Redditor user;

  @override
  State<RedditorPageView> createState() => _RedditorPageViewState();
}

class _RedditorPageViewState extends State<RedditorPageView> {
  bool loading = true;
  List<Subreddit> subreddits = [];

  @override
  void initState() {
    super.initState();
    widget.user.getSubscribedSubreddits().then((subs) {
      subreddits = subs;
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String ancientnessFormat = 'Redditor since ';
    Map<String, Widget> tabs = {
      'Posts': Container(),
      'Comments': Container(),
      'Subredddits': ListView(children: [
        for (var s in subreddits)
          TextButton(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/subreddit',
                  arguments: SubredditPageArguments(s.displayName));
            },
            child: SubredditWidget(subreddit: s),
          )
      ]),
    };

    ancientnessFormat += TimeElapsed.fromDateTime(widget.user.ancientness);
    if (loading) {
      return const LoadingWidget();
    }
    return FlappPage(
        title: widget.user.name,
        body: ListView(children: [
          Wrap(children: [
            ImageHeader(
                bannerUrl: widget.user.bannerUrl,
                pictureUrl: widget.user.pictureUrl,
                title: widget.user.displayName)
          ]),
          Row(children: [
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: Colors.grey),
                  child: Row(
                      children: const [Icon(Icons.edit), Text('Edit profile')]),
                )),
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(ancientnessFormat))
          ]),
          Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 30, right: 15),
              child: Wrap(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.user.description))
                ],
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.8,
              child: DefaultTabController(
                  length: tabs.length,
                  child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 48,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        automaticallyImplyLeading: false,
                        flexibleSpace: TabBar(
                          padding: EdgeInsets.zero,
                          isScrollable: false,
                          labelColor: Theme.of(context).primaryColor,
                          tabs: [for (var t in tabs.keys) Tab(text: t)],
                        ),
                      ),
                      body: TabBarView(
                        children: [for (var t in tabs.values) t],
                      )))),
        ]));
  }
}
