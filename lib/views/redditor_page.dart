import 'package:flutter/material.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';
import 'package:time_elapsed/time_elapsed.dart';

class RedditorPageView extends StatefulWidget {
  const RedditorPageView({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<RedditorPageView> createState() => _RedditorPageViewState();
}

class _RedditorPageViewState extends State<RedditorPageView> {
  @override
  Widget build(BuildContext context) {
    String ancientnessFormat = 'Redditor since ';

    ancientnessFormat += TimeElapsed.fromDateTime(widget.user.ancientness);
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
                  top: 15, bottom: 20, left: 15, right: 15),
              child: Wrap(
                children: [Text(widget.user.description)],
              )),
        ]));
  }
}
