import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageSetter {
  Future<void> dowloadImage(BuildContext context, String url) async {
    var progressString = Wallpaper.imageDownloadProgress(url);
    progressString.listen((data) {}, onDone: () async {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }

  Future<void> homeScreens(BuildContext context) async {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var home = await Wallpaper.homeScreen(
        options: RequestSizeOptions.RESIZE_FIT, width: width, height: height);
  }

  Future<void> lockScreens(BuildContext context) async {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var lock = await Wallpaper.lockScreen(
        options: RequestSizeOptions.RESIZE_FIT, width: width, height: height);
  }

  bothScreens(BuildContext context) async {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var both = await Wallpaper.bothScreen(
        options: RequestSizeOptions.RESIZE_FIT, width: width, height: height);
  }

  void snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
          )),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 3),
    ));
  }
}
