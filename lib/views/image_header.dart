import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return Wrap(children: [
      Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: CachedNetworkImage(
                imageUrl: bannerUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
              top: 50,
              left: 20,
              child: Row(children: [
                CachedNetworkImage(
                  imageUrl: pictureUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ])),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center))
        ],
      )
    ]);
  }
}
