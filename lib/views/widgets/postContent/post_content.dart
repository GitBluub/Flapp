import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'post_video.dart';
import 'post_img.dart';

class PostContentWidget extends StatelessWidget {
  final Post post;
  const PostContentWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContentType type = getContentType(post.submission);
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