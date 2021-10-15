import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/redditor.dart';

class FlappDrawer extends StatelessWidget {
  final Redditor user;
  const FlappDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              height: 175.0,
              child: DrawerHeader(
                  child: Row(children: [
                CachedNetworkImage(
                  width: 75,
                  imageUrl: user.pictureUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider)),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Container(
                  child: Text(user.name, style: const TextStyle(fontSize: 20)),
                  padding: const EdgeInsets.only(left: 20),
                )
              ]))),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/user');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
