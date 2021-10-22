import 'package:flapp/views/loading.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'post_view.dart';
import 'flapp_page.dart';
import '../models/comment.dart';
import 'comment_view.dart';

/// View for Post page view (with comments)
class PostPageView extends StatefulWidget
{
  final Post post;

  const PostPageView({Key? key, required this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView>
{
  @override
  Widget build(BuildContext context) {
    return FlappPage(title: widget.post.title, body: ListView(children: <Widget>[
      PostView(post: widget.post, preview: false, displaySubName: true)
    ] + [for (Comment comment in widget.post.comments) CommentView(comment: comment)]));
  }
}