import 'subreddit.dart';

class Post {
  String authorName;

  Subreddit parent;

  DateTime createdTime;

  String title;

  String content;

  int upVotes;

  int downVotes;

  Post(this.authorName, this.parent, this.createdTime, this.title, this.content,
      this.upVotes, this.downVotes);
}