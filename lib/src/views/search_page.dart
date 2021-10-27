import 'package:flapp/src/controllers/subreddit_page.dart';
import 'package:flapp/src/models/subreddit.dart';
import 'package:flapp/src/views/loading.dart';
import 'package:flutter/material.dart';
import 'flapp_page.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:get_it/get_it.dart';
import 'package:flapp/src/models/reddit_interface.dart';
import 'subreddit_widget.dart';

/// View for Search page
class SearchPageView extends StatelessWidget {

  const SearchPageView({Key? key}) : super(key: key);

  /// Get list of subreddit's matching name
  Future<List<Subreddit>> _searchSubreddits(String? name) {
    return GetIt.I<RedditInterface>().searchSubreddits(name != null ? name.trim() : "");
  }

  @override
  Widget build(BuildContext context) {
    return FlappPage(
      title: "Search Subreddits",
      body: SafeArea(
        child: SearchBar<Subreddit>(
          searchBarPadding: const EdgeInsets.symmetric(horizontal: 20),
          onSearch: _searchSubreddits,
          textStyle: const TextStyle(),
          onError: (Error? error) {
            return Row(
                children: const [Text("Oops... An error occured", style: TextStyle(fontSize: 20), textAlign: TextAlign.center)],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center
            );
            } ,
          cancellationWidget: const Text("Cancel"),
          loader: const LoadingWidget(),
          emptyWidget: Row(
              children: const [Text("No matching subreddit...", style: TextStyle(fontSize: 20), textAlign: TextAlign.center)],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center
          ),
          onCancelled: () {},
          onItemFound: (Subreddit? subreddit, int index) {
            if (subreddit == null) {
              return Container();
            }
            Subreddit sub = subreddit;
            return TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              onPressed: () {
                  Navigator.pushNamed(context, '/subreddit', arguments: SubredditPageArguments(sub.displayName));
              },
              child: SubredditWidget(subreddit: sub),
            );
          },
        ),
      ),
    );
  }

}
