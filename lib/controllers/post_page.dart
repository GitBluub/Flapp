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

class PostPageController extends StatefulWidget {
  final Post post;

  const PostPageController({Key? key, required this.post}) : super(key: key);

  @override
  State<PostPageController> createState() => _PostPageControllerState();
}

class _PostPageControllerState extends State<PostPageController> {
  Post? post;

  @override
  void initState() {
    super.initState();
    setState(() => post = null);
    widget.post.fetchComments().then((_) {
      setState(() {
        post = widget.post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PostPageView(post: post);
  }


}