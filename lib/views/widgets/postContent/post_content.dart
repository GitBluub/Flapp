import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'post_video.dart';
import 'post_img.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget to display content from post
class PostContentWidget extends StatelessWidget {
  /// Post to get content from
  final Post post;
  final bool preview;
  const PostContentWidget({Key? key, required this.post, required this.preview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContentType type = post.getContentType();

    switch (type)
    {
      case ContentType.image:
        return (PostImgWidget(post: post));
      case ContentType.video:
        return (PostVideoWidget(post: post));
      default:
        if (post.content == "") {
          return Container();
        }
        return preview ?
            Expanded(
              child: SizedBox(
                height: 200,
                  width: MediaQuery.of(context).size.width - 40,
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (notification) {return true;},
                    child: Markdown(
                        data: post.content),
                  )
              )
            )
            : Expanded(
              child:MarkdownBody(
                  data: post.content,
                  onTapLink: (text, url, title) {
                    launch(url as String);
                  },
              )
            );
        /*
        return Text(
          post.content,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
          ),
        );*/
    }
  }
}