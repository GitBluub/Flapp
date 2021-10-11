import 'package:flutter/material.dart';
import 'package:reddapp/models/post.dart';
import '../models/post.dart';

class PostVue extends StatelessWidget {
  const PostVue({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(post.title, style: const TextStyle(fontSize: 25)),
                Expanded(
                    child: Text(post.parent, style: const TextStyle(fontSize: 20, color: Colors.grey), textAlign: TextAlign.end)
                )
              ],
            ),
          ],
        ));
  }
}
