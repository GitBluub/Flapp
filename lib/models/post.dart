import 'package:draw/draw.dart' show Submission, VoteState;

enum ContentType {
  self,
  image,
  video,
  gif,
}

ContentType getContentType(Submission sub)
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
      case VoteState.none:
        vote = null;
        break;
      case VoteState.upvoted:
        vote = true;
        break;
      case VoteState.downvoted:
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

  Submission submission;
}
