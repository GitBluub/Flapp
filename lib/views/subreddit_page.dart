import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/subreddit.dart';
import 'flapp_page.dart';
import 'loading.dart';
import 'image_header.dart';

class SubredditPageView extends StatelessWidget{
  final Subreddit? subreddit;
  final bool? subscribed;
  const SubredditPageView({Key? key, required this.subreddit, required this.subscribed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (subreddit == null || subscribed == null) {
      return const LoadingWidget();
    }
    Subreddit sub = subreddit as Subreddit;
    return FlappPage(
        title: sub.displayName,
        body: ListView(children: [
          Wrap(children: [
            ImageHeader(
                bannerUrl: sub.bannerUrl,
                pictureUrl: sub.pictureUrl,
                title: 'r/' + sub.displayName)
          ]),
          Row(children: [
            Container(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      onPrimary: subscribed! == false ? Theme.of(context).primaryColor : Colors.grey,
                      primary: subscribed! == false ? Colors.grey : Theme.of(context).scaffoldBackgroundColor,
                      side: subscribed! ? BorderSide(width: 2.0, color: Colors.grey) : null),
                  child: Row(
                      children: [subscribed! ? Text('JOINED') : Text('JOIN')]),
                )),
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(NumberFormat.compact().format(sub.membersCount).toString() + " Members"))
          ]),
          Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 15, right: 15),
              child: Wrap(
                children: [Text(sub.description)],
              )),
        ]));
  }
}