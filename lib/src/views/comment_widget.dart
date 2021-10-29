import 'package:flapp/src/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(comment.content);
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Text(
                        "${comment.authorName} · ${TimeElapsed.fromDateTime(comment.createdTime)}",
                        style: const TextStyle(fontSize: 17)),
                    padding: const EdgeInsets.only(left: 10, bottom: 10))),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 30),
                    child: MarkdownBody(data: comment.content.trim()),
                        )),
            const Divider(),
          ],
        ));
  }
}
