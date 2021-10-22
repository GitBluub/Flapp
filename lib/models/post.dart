import 'package:draw/draw.dart' show Submission, VoteState;

/// Enumeration of possible post content
enum ContentType {
  /// Text only
  self,
  /// Image
  image,
  /// Video
  video,
  /// Animated image
  gif,
}


/// Post entity
class Post {
  /// Creates a Post entity from a populated DRAW Submission
  Post.fromSubmission(this.submission)
  {
    _refreshFromSubmission();
  }

  /// Apply vote on post and call API to update
  /// If vote is null, cancels any vote from the user on this post
  /// If vote is true, up votes
  /// Else, down votes
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

  /// Get ContentType from Submission
  ContentType getContentType()
  {
    if (submission.isVideo)
      return ContentType.video;
    if (submission.isSelf)
      return ContentType.self;
    if (RegExp(r"\.(gif|jpe?g|bmp|png)$").hasMatch(submission.url.toString()))
      return ContentType.image;
    return ContentType.self;
  }

  /// Refresh submission and update Post values
  Future<void> refresh() async {
    submission.refresh();

    _refreshFromSubmission();
  }

  /// Apply Submission's field's values on Post's values
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

  /// Name of the Post's author 
  late String authorName;

  /// Name of the subreddit the post belongs to
  late String parent;

  /// Timestamp of the post's publication
  late DateTime createdTime;

  /// Title of the post
  late String title;

  /// Content of the post
  late String content;

  /// Number of upvotes
  late int score;

  /// Full name of the post
  late String fullName;

  /// User's reaction to post
  /// If vote is null, no reaction
  /// If vote is true, the post is liked
  /// Else, the post is disliked
  late bool? vote;

  /// Short link to post (useful to share) 
  late String link;

  /// DRAW Submission entity, allows easy communication between object and API
  Submission submission;
}
