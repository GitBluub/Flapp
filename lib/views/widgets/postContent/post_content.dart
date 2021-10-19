import '../../../models/post.dart';
import 'package:flutter/material.dart';
import 'post_video.dart';
import 'post_img.dart';

class PostContentWidget extends StatelessWidget {
  final Post post;
  const PostContentWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.submission.isVideo) {
      return (
          PostVideoWidget(post: post)
      );
    }
    if (RegExp(r"\.(gif|jpe?g|bmp|png)$").hasMatch(post.submission.url.toString())) {
      return (
        PostImgWidget(post: post)
      );
    }
    return Container();
  }
}