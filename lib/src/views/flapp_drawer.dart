import 'package:flutter/material.dart';
import 'package:flapp/src/models/redditor.dart';
import 'package:flapp/src/models/reddit_interface.dart';
import 'package:get_it/get_it.dart';
import 'image_header.dart';

/// Widget for button in Drawer
class DrawerButton extends StatelessWidget
{
  /// Leading IconData
  final IconData icon;
  /// Button's label 
  final String title;
  /// Route to redirect onto, when button click
  final String route;
  /// Custom callback on button click
  /// If none, update navigator's route
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

/// App Drawer
class FlappDrawer extends StatelessWidget {
  /// Logged user, to display name and profile picture
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
              SizedBox(
                  height: 100,
                  child: CircularCachedNetworkImage(url: user.pictureUrl, size: 80),),
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
              Navigator.of(context).popAndPushNamed("/login");
            }),
          ],
    ));
  }
}
