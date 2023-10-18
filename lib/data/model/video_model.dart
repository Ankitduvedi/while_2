class Video {
  final String videoRef;
  final String uploadedBy;
  final String videoUrl;
  final String title;
  final String description;
  final List likes;
  final int shares;

  Video({
    required this.videoRef,
    required this.uploadedBy,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.shares,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      videoRef: map['videoRef'] as String,
      uploadedBy: map['uploadedBy'] as String,
      videoUrl: map['videoUrl'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      likes: List.from(map['likes']),
      shares: map['shares'] as int,
    );
  }
}
