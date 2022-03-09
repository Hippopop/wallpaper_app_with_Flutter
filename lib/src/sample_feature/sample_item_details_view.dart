import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wallpaper_app_with_flutter/src/Controller/set_wallpaper.dart';

class SampleItemDetailsView extends StatefulWidget {
  SampleItemDetailsView({Key? key, required this.id, required this.url})
      : super(key: key);
  String id;
  String url;
  static const routeName = '/sample_item';

  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final ImageSetter _imageSetter = ImageSetter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          backgroundColor: Colors.blueAccent,
          closeManually: false,
          animationSpeed: 300,
          closeDialOnPop: true,
          renderOverlay: false,
          spacing: 12,
          spaceBetweenChildren: 12,
          onOpen: () async {
            await _imageSetter.dowloadImage(context, widget.url);
          },
          children: [
            SpeedDialChild(
                child: const Icon(Icons.home),
                label: 'Set HomeScreen',
                onTap: () async {
                  _imageSetter.snack(context, "Setting Up...");
                  Future.delayed(const Duration(milliseconds: 500), () async {
                    await _imageSetter.homeScreens(context);
                  });
                  _imageSetter.snack(context, "Done!");
                }),
            SpeedDialChild(
              child: const Icon(Icons.lock),
              label: 'Set LockScreen',
              onTap: () async {
                _imageSetter.snack(context, "Setting Up...");
                Future.delayed(const Duration(milliseconds: 500), () async {
                  await _imageSetter.lockScreens(context);
                });
                _imageSetter.snack(context, "Done!");
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.wallpaper_outlined),
              label: 'Set Both',
              onTap: () async {
                _imageSetter.snack(context, "Setting Up...");
                Future.delayed(const Duration(milliseconds: 500), () async {
                  await _imageSetter.bothScreens(context);
                });
                _imageSetter.snack(context, "Done!");
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: widget.id,
                child: CachedNetworkImage(
                  cacheKey: widget.id,
                  fit: BoxFit.cover,
                  imageUrl: widget.url,
                ),
              ),
            )
          ],
        ));
  }
}
