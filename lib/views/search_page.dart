import 'package:cached_network_image/cached_network_image.dart';
import 'package:flapp/controllers/subreddit_page.dart';
import 'package:flapp/models/subreddit.dart';
import 'package:flapp/views/loading.dart';
import 'package:flappy_search_bar_ns/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'flapp_page.dart';
import '../models/redditor.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';
import 'image_header.dart';

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
    return FlappPage(
      title: "Search Subreddits",
      body: SafeArea(
        child: SearchBar<Subreddit>(
          searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
          headerPadding: const EdgeInsets.symmetric(horizontal: 10),
          listPadding: const EdgeInsets.symmetric(horizontal: 20),
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
          onItemFound: (Subreddit? post, int index) {
            if (post == null) {
              return Container();
            }
            Subreddit sub = post;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    child: CircularCachedNetworkImage(url: sub.pictureUrl, size: 40)
                ),
                Expanded(
                    child: Text(sub.displayName)
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(NumberFormat.compact().format(sub.membersCount).toString())
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
