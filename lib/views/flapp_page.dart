import 'package:flutter/material.dart';
import 'flapp_drawer.dart';
import '../models/redditor.dart';

class FlappPage extends StatelessWidget {
  final Widget body;
  final String title;
  final Redditor user;
  const FlappPage({Key? key, required this.title, required this.user, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
        drawer: FlappDrawer(user: user),
        body: body
    );
  }
}