import 'package:flutter/material.dart';

/// The various things an `ItemCard` can represent
enum ItemCardMode { album, artist, song }

class ItemCard extends StatelessWidget {
  /// What version of the `ItemCard` to display
  final ItemCardMode mode;

  /// Return a minimal/fancy version of the `ItemCard`. Set to false by default.
  final bool fancy;

  /// The image to display on the card
  final ImageProvider image;

  /// Primary card text
  final String title;

  /// Optional subheading/subtitle for the card
  final String? subtitle;

  /// Optional extra subheading/subtitle for the card
  final String? extra;

  const ItemCard({
    super.key,
    required this.mode,
    this.fancy = false,
    required this.title,
    this.subtitle,
    this.extra,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    if (fancy == true) {
      return Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ClipRect(
            child: OverflowBox(
              maxWidth: width * 7 / 8,
              minWidth: width * 7 / 8,
              child: Image(image: image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
                if (subtitle != null)
                  Row(
                    children: [
                      (Text(
                        subtitle!,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      )),
                      if (extra != null)
                        Text(
                          " • ",
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      if (extra != null)
                        Text(
                          extra!,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Card();
    }
  }
}
