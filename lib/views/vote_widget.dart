import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

class VoteWidget extends StatefulWidget {
  Post post;
  VoteWidget({Key? key, required this.post})
      : super(key: key);

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  @override
  Widget build(BuildContext context) {
    bool liked = false;
    bool disliked = false;

    if (widget.post.vote != null) {
      liked = widget.post.vote as bool;
      disliked = !(widget.post.vote as bool);
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
              widget.post.score += 1;
              widget.post.setVote(true);
            } else if (liked) {
              widget.post.score -= 1;
              widget.post.setVote(null);
            }
          });
        },
        icon: likeIcon,
      ),
      Text((NumberFormat.compact().format(widget.post.score)).toString()),
      IconButton(
          onPressed: () {
            setState(() {
              if (!disliked) {
                if (liked) {
                  widget.post.score -= 1;
                }
                widget.post.setVote(false);
              } else if (disliked) {
                widget.post.setVote(null);
              }
            });
          },
          icon: dislikeIcon)
    ]);
  }
}
