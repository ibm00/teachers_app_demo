import 'dart:convert';

class VideoModel {
  final String quality;
  final String url;
  VideoModel({
    required this.quality,
    required this.url,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoModel && other.quality == quality && other.url == url;
  }

  @override
  int get hashCode => quality.hashCode ^ url.hashCode;
}
