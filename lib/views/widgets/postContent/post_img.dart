import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/post.dart';
import '../../loading.dart';

class PostImgWidget extends StatefulWidget {
  final Post post;

  const PostImgWidget({Key? key, required this.post}) : super(key: key);
  @override
  State<PostImgWidget> createState() => _PostImgWidgetState();
}

class _PostImgWidgetState extends State<PostImgWidget>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: CachedNetworkImage(
        width: 300,
        imageUrl: widget.post.submission.url.toString(),
        placeholder: (context, url) {
          return LoadingWidget();
        },
        errorWidget: (context, child, stackTrace) {
          return Container();
        },
      ),
    );
  }
}
