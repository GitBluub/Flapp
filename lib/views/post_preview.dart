import 'package:flapp/views/widgets/postContent/post_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flapp/models/post.dart';
import '../models/post.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:share/share.dart';
import 'vote_widget.dart';
import 'widgets/postContent/post_content.dart';

class PostPreview extends StatelessWidget {
  const PostPreview({Key? key, required this.post, required this.displaySubName}) : super(key: key);
  final Post post;
  final bool displaySubName;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    post.title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                displaySubName
                    ? Expanded(
                      flex: 1,
                      child: Text("r/" + post.parent,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.end
                      ))
            : Container()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child:
                    Text(
                      post.content,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10
                      ),
                    )
                ),
              ],
            ),
            Row(
              children: [
                PostContentWidget(post: post)
              ]
            ),
            Container(
              padding: const EdgeInsets.all(10),
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
                    child: VoteWidget(post: post)),
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
            Divider(),
          ],
        ));
  }
}
