import 'package:flutter/material.dart';
import 'image_header.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'loading.dart';

class RedditorPageView extends StatefulWidget {
  const RedditorPageView({Key? key, required this.user}) : super(key: key);
  final Redditor? user;

  @override
  State<RedditorPageView> createState() => _RedditorPageViewState();
}

class _RedditorPageViewState extends State<RedditorPageView> {
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return const LoadingWidget();
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
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
              children: [
                Wrap(children: [Text(user.description)]),
            ]
          )),
        ]));
  }
}
