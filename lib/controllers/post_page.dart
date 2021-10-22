import 'package:flutter/material.dart';
import '../models/post.dart';
import '../views/post_page.dart';

class PostPageArguments {
  final Post post;

  PostPageArguments(this.post);
}

class ExtractArgumentsPostPage extends StatelessWidget {
  const ExtractArgumentsPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostPageArguments postPageArguments = ModalRoute.of(context)!.settings.arguments as PostPageArguments;
    return PostPageController(post: postPageArguments.post);
  }
}

class PostPageController extends StatelessWidget {
  final Post post;

  const PostPageController({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostPageView(post: post);
  }


}