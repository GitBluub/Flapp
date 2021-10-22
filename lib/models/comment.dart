import 'package:flutter/material.dart';
import 'package:draw/draw.dart' as draw;

/// Entity for a post's comment
class Comment {

  /// Name of the comment's author
  final String authorName;
  /// Content of the comment
  final String content;
  /// Comment time
  final DateTime createdTime;

  Comment.fromDraw(draw.Comment comment):
        authorName = comment.author,
        content = comment.body == null ? "" : comment.body!,
        createdTime = comment.createdUtc;

}