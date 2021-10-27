import 'package:draw/draw.dart' as draw;
import 'package:html_unescape/html_unescape.dart';

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
        content = comment.body == null ? "" : HtmlUnescape().convert(comment.body!.trim()),
        createdTime = comment.createdUtc;

}