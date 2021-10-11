import 'package:flutter/material.dart';
import 'package:reddapp/models/post.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key, required this.post}) : super(key: key);
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
            Row(
              children: [
                const Icon(Icons.access_time_outlined, color: Colors.grey),
                Container(padding: const EdgeInsets.only(left: 5), child:
                  Text(TimeElapsed.fromDateTime(post.createdTime), style: const TextStyle(fontSize: 15))
                ),
                Expanded(
                    child: Text(post.authorName, style: const TextStyle(fontSize: 20, color: Colors.grey), textAlign: TextAlign.end)
                )
              ],
            ),
          ],
        ));
  }
}
