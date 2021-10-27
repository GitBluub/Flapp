import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/post.dart';
import '../../loading.dart';

/// Widget to display Image from post
class PostImgWidget extends StatefulWidget {
  /// Post to get content from
  final Post post;

  const PostImgWidget({Key? key, required this.post}) : super(key: key);
  @override
  State<PostImgWidget> createState() => _PostImgWidgetState();
}

class _PostImgWidgetState extends State<PostImgWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return SizedBox(
        width: width,
        child: Image.network(
          widget.post.submission.url.toString(),
          fit: BoxFit.fitHeight,
          errorBuilder: (_,__,___) => Container(),
          loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Center(child: LoadingWidget());
          }

        ),
    );
  }
}
