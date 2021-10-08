import 'post.dart';

class Subreddit {
  String displayName;

  String fullName;

  List<Post> posts;

  int membersCount;

  String description;

  String link;

  Subreddit(this.displayName, this.fullName, this.posts, this.membersCount,
      this.description, this.link);
}