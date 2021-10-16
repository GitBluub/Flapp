import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoteWidget extends StatefulWidget {
  int likeCount;
  bool? liked;
  VoteWidget({Key? key, required this.likeCount, required this.liked})
      : super(key: key);

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  @override
  Widget build(BuildContext context) {
    bool liked = false;
    bool disliked = false;

    if (widget.liked != null) {
      liked = widget.liked as bool;
      disliked = !(widget.liked as bool);
    }
    Widget likeIcon = Icon(liked
        ? Icons.thumb_up
        : Icons.thumb_up_outlined);
    Widget dislikeIcon = Icon(disliked
        ? Icons.thumb_down
        : Icons.thumb_down_outlined);

    return Row(children: [
      IconButton(
        onPressed: () {
          setState(() {
            if (!liked) {
              widget.likeCount += 1;
              widget.liked = true;
              //TODO Tell API
            } else if (liked) {
              widget.likeCount -= 1;
              widget.liked = null;
              //TODO Tell API
            }
          });
        },
        icon: likeIcon,
      ),
      Text((NumberFormat.compact().format(widget.likeCount)).toString()),
      IconButton(
          onPressed: () {
            setState(() {
              if (!disliked) {
                if (liked) {
                  widget.likeCount -= 1;
                }
                widget.liked = false;
                //TODO Tell API
              } else if (disliked) {
                widget.liked = null;
                //TODO Tell API
              }
            });
          },
          icon: dislikeIcon)
    ]);
  }
}
