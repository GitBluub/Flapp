import 'package:flutter/material.dart';
import 'reddapp_drawer.dart';
import '../models/redditor.dart';

class ReddappPage extends StatelessWidget {
  final Widget body;
  final String title;
  final Redditor user;
  const ReddappPage({Key? key, required this.title, required this.user, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        drawer: ReddappDrawer(user: user),
        body: body
    );
  }
}