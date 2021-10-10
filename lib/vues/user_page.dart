import 'package:flutter/material.dart';
import '../models/redditor.dart';
import 'image_header.dart';
import 'drawer.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        drawer: const ReddappDrawer(),
        body: ListView(children: const [
          ImageHeader(bannerUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/bannerBackgroundImage_xg901qmo8no61.png', pictureUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/communityIcon_ic8kuvspll861.png?width=256&s=2eeaea442bb635fd6d70ebd62de259580eff1050', title: 'lol'),
    ]));
  }
}
