import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:syncthing_but_like_for_music/src/rust/api/media.dart';

import '../src/rust/api/sync_engine.dart';

import '../widgets/item_card.dart';

class RouteHome extends StatefulWidget {
  const RouteHome({super.key});

  @override
  State<RouteHome> createState() => _RouteHomeState();
}

Future<void> doIndex() async {
  var musicDir = "~/Projects/SampleMusic";
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory == null) {
    // User canceled the picker
    return;
  }
  // index media dir
  var appIndex = await runIndex(musicDir: selectedDirectory);
  return;
}

class _RouteHomeState extends State<RouteHome> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String greeting = greet(name: "Home");
    final double height = MediaQuery.sizeOf(context).height;
    const ImageProvider defaultImg = NetworkImage(
      "https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png",
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        Text("For You:", style: Theme.of(context).textTheme.displayMedium),
        // list of song/album/artist cards
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 3),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[4, 2, 1],
            children: [
              ItemCard(
                mode: ItemCardMode.album,
                fancy: true,
                title: 'Album',
                subtitle: 'Artist',
                image: defaultImg,
              ),
              ItemCard(
                mode: ItemCardMode.artist,
                fancy: true,
                title: 'Artist',
                image: defaultImg,
              ),
              ItemCard(
                mode: ItemCardMode.song,
                fancy: true,
                title: 'Song',
                subtitle: 'Artist',
                extra: "Album",
                image: defaultImg,
              ),
              ItemCard(
                mode: ItemCardMode.album,
                fancy: true,
                title: 'Album',
                subtitle: 'Artist',
                image: defaultImg,
              ),
              ItemCard(
                mode: ItemCardMode.artist,
                fancy: true,
                title: 'Artist',
                image: defaultImg,
              ),
            ],
          ),
        ),
        FilledButton(onPressed: doIndex, child: Text("Do Index")),
      ],
    );

    // Center(
    //   child: Text(greeting, style: Theme.of(context).textTheme.displayLarge),
    // );
  }
}
