import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_with_flutter/src/Controller/main_data_controller.dart';
import 'package:wallpaper_app_with_flutter/src/Model/wallpaper_class_model.dart';
import 'package:wallpaper_app_with_flutter/src/sample_feature/sample_item_details_view.dart';

import '../settings/settings_view.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainDataFlower().apiCall();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wallpaper List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Consumer<MainDataFlower>(
        builder: (context, value, child) => (value.listOfImages.isNotEmpty)
            ? Stack(
                alignment: Alignment.center,
                children: [
                  NotificationListener<ScrollEndNotification>(
                    onNotification: (not) {
                      if (not.metrics.atEdge) {
                        if (not.metrics.pixels != 0) {
                          value.pageIncrease();
                          value.apiCall();
                        }
                      }
                      return true;
                    },
                    child: ListView.builder(
                      restorationId: 'sampleItemListView',
                      controller: _scrollController,
                      itemCount: value.listOfImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = value.listOfImages[index];
                        return SingleWallpaper(screen: screen, item: item);
                      },
                    ),
                  ),
                  (value.loadingData)
                      ? const Positioned(child: CircularProgressIndicator())
                      : const SizedBox(),
                ],
              )
            : const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator()),
      ),
    );
  }
}

class SingleWallpaper extends StatelessWidget {
  const SingleWallpaper({
    Key? key,
    required this.screen,
    required this.item,
  }) : super(key: key);

  final Size screen;
  final WallpaperClass item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: screen.height * .30,
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SampleItemDetailsView(
                          id: item.id, url: item.downloadUrl)));
            },
            child: Hero(
              tag: item.id,
              child: CachedNetworkImage(
                key: ValueKey(item.id),
                /*placeholder: (context, url) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text('Waiting for network'),
                  );
                },*/
                cacheKey: item.id,
                imageUrl: item.downloadUrl,
                progressIndicatorBuilder: (_, url, download) {
                  if (download.progress != null) {
                    final double percent = download.progress! * 100;
                    return Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text("Loading: ${percent.floor()}%")));
                  } else {
                    return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  }
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screen.height * .05,
          child: Text(
            'Author : ${item.author}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

showDialog(BuildContext context, String url, String id) {
  return showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    useRootNavigator: true,
    pageBuilder: (_, __, ___) {
      return Material(
        child: Column(
          children: [
            Hero(
              tag: id,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
