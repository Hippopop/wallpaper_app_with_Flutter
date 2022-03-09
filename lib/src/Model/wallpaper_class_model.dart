class WallpaperClass {
  WallpaperClass({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory WallpaperClass.fromJson(Map<String, dynamic> json) => WallpaperClass(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  factory WallpaperClass.fromListOfJson(Map<String, dynamic> json) =>
      WallpaperClass(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
