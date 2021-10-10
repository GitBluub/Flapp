import 'package:flutter/material.dart';
import '../models/redditor.dart';
import 'image_header.dart';
import 'drawer.dart';

class UserPageVue extends StatefulWidget {
  const UserPageVue({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<UserPageVue> createState() => _UserPageVueState();
}

class _UserPageVueState extends State<UserPageVue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        drawer: ReddappDrawer(user: widget.user),
        body: ListView(children: [
          ImageHeader(bannerUrl: widget.user.bannerUrl, pictureUrl: widget.user.pictureUrl, title: widget.user.displayName),
    ]));
  }
}
