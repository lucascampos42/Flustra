enum MediaType { movie, show, music, podcast }

class MediaItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String? thumbnailUrl;
  final String? streamUrl;
  final MediaType type;
  final Duration? duration;
  final DateTime? addedAt;

  MediaItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.thumbnailUrl,
    this.streamUrl,
    required this.type,
    this.duration,
    this.addedAt,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      streamUrl: json['stream_url'] as String?,
      type: MediaType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MediaType.movie,
      ),
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'] as int)
          : null,
      addedAt: json['added_at'] != null
          ? DateTime.parse(json['added_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'thumbnail_url': thumbnailUrl,
        'stream_url': streamUrl,
        'type': type.name,
        'duration': duration?.inSeconds,
        'added_at': addedAt?.toIso8601String(),
      };
}
