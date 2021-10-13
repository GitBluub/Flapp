import 'package:flutter/material.dart';
import 'package:flapp/models/post.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:share/share.dart';

class PostPreview extends StatelessWidget {
  const PostPreview({Key? key, required this.post}) : super(key: key);
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
                    child: Text(post.parent,
                        style:
                            const TextStyle(fontSize: 20),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.access_time_outlined),
                Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TimeElapsed.fromDateTime(post.createdTime),
                        style: const TextStyle(fontSize: 15))),
                Expanded(
                    child: Text(post.authorName,
                        style:
                            const TextStyle(fontSize: 20),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Row(children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                  ),
                  Text(post.upVotes.toString())
                ])),
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_down),
                )),
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  //label: user.comment
                  icon: const Icon(Icons.mode_comment),
                )),
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    Share.share(post.link);
                  },
                  icon: const Icon(Icons.share),
                )),
              ],
            ),
          ],
        ));
  }
}
