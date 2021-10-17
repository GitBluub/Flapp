import 'package:draw/draw.dart' show Submission, VoteState;

class Post {
  Post.fromSubmission(this.submission)
      : authorName = submission.author,
        parent = submission.subreddit.displayName,
        createdTime = submission.createdUtc,
        title = submission.title,
        content = submission.body == null ? "" : submission.body as String,
        score = submission.upvotes,
        link = submission.shortlink.toString() {
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

  String authorName;

  String parent;

  DateTime createdTime;

  String title;

  String content;

  int score;

  bool? vote;

  String link;

  Submission submission;
}
