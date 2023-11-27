class Reels {
  Reels({
    required this.uploadedBy,
    required this.videoUrl,
    required this.title,
    required this.likes,
    required this.description,
    // required this.views,
  });

  late final String uploadedBy;
  late final String videoUrl;
  late final String title;
  late final String description;
  // late final int views;
  late final List likes;

  Reels.fromJson(Map<String, dynamic> json) {
    uploadedBy = json['uploadedBy'].toString();
    videoUrl = json['videoUrl'].toString();
    title = json['title'].toString();
    likes = json['likes'] ?? [];
    description = json['description'].toString();
    // views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uploadedBy'] = uploadedBy;
    data['videoUrl'] = videoUrl;
    data['title'] = title;
    data['likes'] = likes;
    data['description'] = description;
    // data['views'] = views;
    return data;
  }
}
