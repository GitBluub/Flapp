import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/redditor.dart';
import 'loading.dart';
import '../models/reddit_interface.dart';
import 'package:get_it/get_it.dart';

class FlappDrawer extends StatelessWidget {
  final Redditor user;
  const FlappDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(context) {
    String currentRoute = "";

    currentRoute = ModalRoute.of(context)!.settings.name!;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              height: 200.0,
              child: DrawerHeader(
                  child: Column(children: [
                Container(
                    height: 100,
                    child: CachedNetworkImage(
                      width: 80,
                      imageUrl: user.pictureUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: imageProvider)),
                      ),
                      placeholder: (context, url) => const LoadingWidget(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                Text(user.name, style: const TextStyle(fontSize: 20))
              ]))),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              if (currentRoute == '/home') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              if (currentRoute == '/user') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/user');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sensor_door_outlined),
            title: const Text('Log out'),
            onTap: () {
              GetIt.I<RedditInterface>().stopAPIConnection();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
