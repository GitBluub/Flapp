import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'post_video.dart';
import 'post_img.dart';

/// Widget to display content from post
class PostContentWidget extends StatelessWidget {
  /// Post to get content from
  final Post post;
  const PostContentWidget({Key? key, required this.post}) : super(key: key);

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
        return Container();
    }
  }
}