import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import 'post_preview.dart';
import '../models/redditor.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';

class UserPageVue extends StatefulWidget {
  const UserPageVue({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<UserPageVue> createState() => _UserPageVueState();
}

class _UserPageVueState extends State<UserPageVue> {
  @override
  Widget build(BuildContext context) {
    String ancientnessFormat = 'Redditor since ';

    ancientnessFormat += TimeElapsed.fromDateTime(widget.user.ancientness);
    return FlappPage(
        title: widget.user.name,
        user: widget.user,
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
                child: Text(ancientnessFormat, style: const TextStyle(color: Colors.grey)))
    ]),
            Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20, left: 15, right: 15),
            child: Wrap(children: [
              Text(widget.user.description)
            ],)
          ),
          PostPreview(post: Post(authorName: 'u/bluub', title: 'title', content: 'LOL', createdTime: DateTime(1989, 10, 01), link: 'trol', upVotes: 1, downVotes: 0, parent: 's/lol')),
        ]));
  }
}