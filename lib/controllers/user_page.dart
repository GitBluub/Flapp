import 'package:flutter/material.dart';
import '../views/user_page.dart';
import '../models/redditor.dart';

class UserPageController extends StatefulWidget {
  const UserPageController({Key? key}) : super(key: key);

  @override
  State<UserPageController> createState() => _UserPageControllerState();
}

class _UserPageControllerState extends State<UserPageController> {
  @override
  Widget build(BuildContext context) {
    return UserPageVue(user: Redditor(
      description: "Hi! I'm Bluub, and I think Binding o Isaac is the ebst game ever. I hate other video games",
      bannerUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/bannerBackgroundImage_xg901qmo8no61.png',
      pictureUrl: 'https://styles.redditmedia.com/t5_2sxpk/styles/communityIcon_ic8kuvspll861.png?width=256&s=2eeaea442bb635fd6d70ebd62de259580eff1050',
      displayName: 'Gitbluub',
      name: 'u/Gitbluub',
      ancientness: DateTime(1989),
      karma: 0,
      subscribedSubreddits: [],
      posts: []
    ));
  }
}