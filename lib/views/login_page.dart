import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/reddit_interface.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    RedditInterface interface = RedditInterface();
                    await interface.createAPIConnection();
                    GetIt.I.registerSingleton<RedditInterface>(interface);
                    Navigator.pushNamed(context, '/user');
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('An error occurred'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Flapp couldn\'t connect to Reddit.'),
                                  Text(
                                      'Check your internet connection'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK, I\'ll try again'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.grey,
                    maximumSize: const Size(100, 40)),
                child:
                    Row(children: const [Icon(Icons.vpn_key), Text(' Login')]),
              )),
        ]));
  }
}
