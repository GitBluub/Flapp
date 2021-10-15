import 'package:flutter/material.dart';
import 'package:flapp/models/post.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';

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
                Expanded(
                  flex: 2,
                  child: Text(
                    post.title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text("r/" + post.parent,
                        style: const TextStyle(fontSize: 10),
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
                    child: Text("u/" + post.authorName,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                    child: Row(children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                  ),
                  Text((NumberFormat.compact().format(post.score)).toString()),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.thumb_down))
                ])),
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
