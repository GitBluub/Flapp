import 'package:flapp/controllers/subreddit_page.dart';
import 'package:flapp/models/subreddit.dart';
import 'package:flapp/views/loading.dart';
import 'package:flappy_search_bar_ns/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import '../controllers/subreddit_page.dart';

/*class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key, required this.user}) : super(key: key);
  final Redditor user;

  @override
  State<StatefulWidget> createState() => _SearchPageViewWidget();
}

class _SearchPageViewWidget extends State<SearchPageView> {
*/
class SearchPageView extends StatelessWidget {

  SearchPageView({Key? key}) : super(key: key);

  Future<List<Subreddit>> _searchSubreddits(String? name) {
    print("Searching for -$name-");
    return GetIt.I<RedditInterface>().searchSubreddits(name != null ? name.trim() : "", 10);
    /*print(list.length);
    for (var subreddit in list) {
      print(subreddit.displayName);
    }
    return list;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<Subreddit>(
          searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
          headerPadding: const EdgeInsets.symmetric(horizontal: 10),
          listPadding: const EdgeInsets.symmetric(horizontal: 10),
          onSearch: _searchSubreddits,
          onError: (Error? error) {print("fucked up: ${error}, ${error!.stackTrace}"); return Container();} ,
          placeHolder: const Text("placeholder"),
          cancellationWidget: const Text("Cancel"),
          loader: const LoadingWidget(),
          emptyWidget: const Text("No matching subreddit"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Subreddit? post, int index) {
            if (post == null)
                return Container();
            Subreddit sub = post;
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(sub.displayName),
                isThreeLine: true,
                subtitle: Text(sub.description),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubredditPageController(subredditName: post.displayName)));
                },
              ),
            );
          },
        ),
      ),
    );
  }

}
