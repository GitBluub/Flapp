import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/redditor.dart';
import 'loading.dart';
import '../models/reddit_interface.dart';
import 'package:get_it/get_it.dart';

class DrawerButton extends StatelessWidget
{
  final IconData icon;
  final String title;
  final String route;
  final void Function()? callback;

  const DrawerButton({Key? key, required this.icon, required this.title, required this.route, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentRoute = "";

    currentRoute = ModalRoute.of(context)!.settings.name!;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: callback ?? () {
        if (currentRoute == route) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}

class FlappDrawer extends StatelessWidget {
  final Redditor user;
  const FlappDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(context) {

    return Drawer(
        child: Column(
      // Important: Remove any padding from the ListView.
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
            const DrawerButton(icon: Icons.home, route: '/home', title: 'Home'),
            const DrawerButton(icon: Icons.account_circle, route: '/user', title: 'Profile'),
            const DrawerButton(icon: Icons.manage_search, route: '/search', title: 'Search'),
            const DrawerButton(icon: Icons.settings, route: '/settings', title: 'Settings'),
            Expanded(child: Container()),
            DrawerButton(icon: Icons.sensor_door_outlined, route: '/settings', title: 'Log out', callback: () {
              GetIt.I<RedditInterface>().stopAPIConnection();
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
          ],
    ));
  }
}
