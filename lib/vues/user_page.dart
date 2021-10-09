import 'package:flutter/material.dart';
import '../models/redditor.dart';

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
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: ListView(children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              SizedBox(
                  height: 100,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image(
                      image: NetworkImage(widget.user.bannerUrl),
                    ),
                  )),
              Positioned(
                  top: 50,
                  left: 20,
                  child: Row(children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.user.pictureUrl)))),

                  ])),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(widget.user.name, style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center))],
          )
        ]));
  }
}
