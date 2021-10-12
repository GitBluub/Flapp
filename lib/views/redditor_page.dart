import 'package:flutter/material.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import 'post_preview.dart';
import '../models/redditor.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'loading.dart';

class RedditorPageVue extends StatefulWidget {
  const RedditorPageVue({Key? key, required this.user}) : super(key: key);
  final Redditor? user;

  @override
  State<RedditorPageVue> createState() => _RedditorPageVueState();
}

class _RedditorPageVueState extends State<RedditorPageVue> {
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return LoadingWidget();
    }

    Redditor user = widget.user as Redditor;
    String ancientnessFormat = 'Redditor since ';

    ancientnessFormat += TimeElapsed.fromDateTime(user.ancientness);
    return FlappPage(
        title: user.name,
        user: user,
        body: ListView(children: [
          Wrap(children: [
            ImageHeader(
                bannerUrl: user.bannerUrl,
                pictureUrl: user.pictureUrl,
                title: user.displayName)
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
                  top: 15, bottom: 20, left: 15, right: 15),
              child: Wrap(
                children: [Text(user.description)],
              )),
          PostPreview(
              post: Post(
                  authorName: 'u/bluub',
                  title: 'title',
                  content: 'LOL',
                  createdTime: DateTime(1989, 10, 01),
                  link: 'trol',
                  upVotes: 1,
                  downVotes: 0,
                  parent: 's/lol')),
        ]));
  }
}
