import 'package:flutter/material.dart';
import '../models/redditor.dart';
import 'image_header.dart';
import 'reddapp_drawer.dart';
import 'reddapp_page.dart';

class UserPageVue extends StatefulWidget {
  const UserPageVue({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<UserPageVue> createState() => _UserPageVueState();
}

class _UserPageVueState extends State<UserPageVue> {
  @override
  Widget build(BuildContext context) {
    return ReddappPage(title: widget.user.name, user: widget.user, body: ListView(children: [
          ImageHeader(bannerUrl: widget.user.bannerUrl, pictureUrl: widget.user.pictureUrl, title: widget.user.displayName),
    ]));
  }
}
