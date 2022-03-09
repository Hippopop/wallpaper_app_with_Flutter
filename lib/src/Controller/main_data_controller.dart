import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_with_flutter/src/Model/wallpaper_class_model.dart';

class MainDataFlower extends ChangeNotifier {
  MainDataFlower._sharedInstance();
  static final MainDataFlower _shared = MainDataFlower._sharedInstance();
  factory MainDataFlower() => _shared;

  List<WallpaperClass> listOfImages = [];
  int pageNum = 2;
  bool loadingData = false;

  Future<void> apiCall() async {
    setLoading();
    String apiUrl = "https://picsum.photos/v2/list?page=$pageNum&limit=10";
    http.Response response = await http.get(Uri.parse(apiUrl));
    convertJsonList(json.decode(response.body));
    setLoading();
  }

  void convertJsonList(List<dynamic> list) {
    for (var json in list) {
      listOfImages.add(WallpaperClass(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      ));
      notifyListeners();
    }
  }

  void pageIncrease() {
    pageNum++;
    notifyListeners();
  }

  void setLoading() {
    loadingData = !loadingData;
    notifyListeners();
  }
}
