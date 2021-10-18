import 'package:draw/draw.dart' show Submission, VoteState;

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

  late bool? vote;

  late String link;

  Submission submission;
}
