import 'package:draw/draw.dart' as draw;
import 'comment.dart';

enum ContentType {
  self,
  image,
  video,
  gif,
}

ContentType getContentType(draw.Submission sub)
{
  if (sub.isVideo)
    return ContentType.video;
  if (sub.isSelf)
    return ContentType.self;
  if (RegExp(r"\.(gif|jpe?g|bmp|png)$").hasMatch(sub.url.toString()))
    return ContentType.image;
  return ContentType.self;
}

class Post {
  Post.fromSubmission(this.submission)
  {
    _refreshFromSubmission();
  }

  // If vote is null, cancels any vote from the user on this post
  // If vote is true, up votes
  // Else, down votes
  void setVote(bool? vote) {
    if (vote == null) {
      submission.clearVote();
    } else {
      bool liked = vote;
      if (liked) {
        submission.upvote();
      } else {
        submission.downvote();
      }
    }
    this.vote = vote;
  }

  Future<void> refresh() async {
    submission.refresh();

    _refreshFromSubmission();
  }

  Future<List<draw.Comment>> _expandedMoreComments(draw.MoreComments more) async {

    List<draw.Comment> expanded = [];
    var list = await more.comments();

    if (list == null) {
      return expanded;
    }
    for (var v in list) {
      if (v is draw.MoreComments) {
        expanded += await _expandedMoreComments(v);
      } else {
        expanded.add(v);
      }
    }
    return expanded;
  }

  Future<void> fetchComments() async
  {
    await submission.refreshComments();
    if (submission.comments == null) {
      return;
    }
    comments = [];
    for (var comment in submission.comments!.comments) {
      if (comment is draw.MoreComments) {
        var r = await _expandedMoreComments(comment);
        comments += [for (draw.Comment scomment in r) Comment.fromDraw(scomment)];
      } else {
        comments.add(Comment.fromDraw(comment));
      }
    }
  }

  void _refreshFromSubmission()
  {
    authorName = submission.author;
    parent = submission.subreddit.displayName;
    createdTime = submission.createdUtc;
    title = submission.title;
    content = submission.selftext == null ? "" : submission.selftext as String;
    score = submission.upvotes;
    link = submission.shortlink.toString();
    fullName = submission.fullname!;
    switch (submission.vote) {
      case draw.VoteState.none:
        vote = null;
        break;
      case draw.VoteState.upvoted:
        vote = true;
        break;
      case draw.VoteState.downvoted:
        vote = false;
        break;
    }
  }

  late String authorName;

  late String parent;

  late DateTime createdTime;

  late String title;

  late String content;

  late int score;

  late String fullName;

  late bool? vote;

  late String link;

  List<Comment> comments = [];

  draw.Submission submission;
}
