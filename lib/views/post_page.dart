import 'package:flapp/views/loading.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'post_widget.dart';
import 'flapp_page.dart';
import '../models/comment.dart';
import 'comment_widget.dart';

/// View for Post page view (with comments)
class PostPageView extends StatefulWidget
{
  final Post? post;

  const PostPageView({Key? key, required this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView>
{
  @override
  Widget build(BuildContext context) {
    if (widget.post == null) {
      return const FlappPage(title: "", body: LoadingWidget());
    }
    Post post = widget.post as Post;
    return FlappPage(title: post.title, body: ListView(children: <Widget>[
      PostWidget(post: post, preview: false, displaySubName: true)
    ] + [for (Comment comment in post.comments) CommentWidget(comment: comment)]));
  }
}