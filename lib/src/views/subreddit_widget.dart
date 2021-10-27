import 'package:flutter/material.dart';
import 'package:flapp/src/models/subreddit.dart';
import 'package:intl/intl.dart';
class SubredditWidget extends StatelessWidget {
  final Subreddit subreddit;

  const SubredditWidget({Key? key, required this.subreddit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            padding: const EdgeInsets.all(15),
            child: CircleAvatar(
              foregroundImage: subreddit.pictureUrl != "" ? Image.network(subreddit.pictureUrl, errorBuilder: (_,__,___) => Container(),).image : null,
              child: Text(subreddit.displayName[0]),
            )),
        Expanded(
            child: Text(subreddit.displayName)
        ),

        Container(
            padding: const EdgeInsets.all(20),
            child: Text(NumberFormat.compact().format(subreddit.membersCount).toString() + " Members")
        ),
      ],
    );
  }

}