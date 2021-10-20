import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/subreddit.dart';
import 'flapp_page.dart';
import 'loading.dart';
import 'image_header.dart';

class SubredditPageView extends StatelessWidget{
  final Subreddit? subreddit;
  const SubredditPageView({Key? key, required this.subreddit}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (subreddit == null) {
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
                title: sub.displayName)
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
                child: Text(NumberFormat.compact().format(sub.membersCount).toString()))
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