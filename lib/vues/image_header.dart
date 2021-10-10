import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String bannerUrl;
  final String pictureUrl;
  final String title;
  const ImageHeader(
      {Key? key,
      required this.bannerUrl,
      required this.pictureUrl,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          SizedBox(
              height: 100,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Image(
                  image: NetworkImage(bannerUrl),
                ),
              )),
          Positioned(
              top: 50,
              left: 20,
              child: Row(children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(pictureUrl)))),

              ])),

        ],
      ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [Container(
    padding: EdgeInsets.only(top: 10),
    child: Text(title, style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center))],
    )]
    );
  }
}
