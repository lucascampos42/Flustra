class StatusResponse {
  final String status;
  final String version;
  final int uptimeSecs;
  final String dbType;
  final int activeSessions;
  final int mediaCount;
  final int userCount;

  StatusResponse({
    required this.status,
    required this.version,
    required this.uptimeSecs,
    required this.dbType,
    required this.activeSessions,
    required this.mediaCount,
    required this.userCount,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
        status: json['status'] as String? ?? '',
        version: json['version'] as String? ?? '',
        uptimeSecs: (json['uptime_secs'] as num?)?.toInt() ?? 0,
        dbType: json['db_type'] as String? ?? '',
        activeSessions: (json['active_sessions'] as num?)?.toInt() ?? 0,
        mediaCount: (json['media_count'] as num?)?.toInt() ?? 0,
        userCount: (json['user_count'] as num?)?.toInt() ?? 0,
      );
}

class UserResponse {
  final String id;
  final String username;
  final String role;

  UserResponse({required this.id, required this.username, required this.role});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json['id'] as String? ?? '',
        username: json['username'] as String? ?? '',
        role: json['role'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'role': role,
      };
}

class LogEntry {
  final String timestamp;
  final String level;
  final String message;

  LogEntry({required this.timestamp, required this.level, required this.message});

  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
        timestamp: json['timestamp'] as String? ?? '',
        level: json['level'] as String? ?? '',
        message: json['message'] as String? ?? '',
      );
}

class LogsResponse {
  final List<LogEntry> entries;
  final int total;

  LogsResponse({required this.entries, required this.total});

  factory LogsResponse.fromJson(Map<String, dynamic> json) => LogsResponse(
        entries: (json['entries'] as List? ?? [])
            .map((e) => LogEntry.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: (json['total'] as num?)?.toInt() ?? 0,
      );
}

class PluginInfo {
  final String name;
  final String version;
  final bool enabled;

  PluginInfo({required this.name, required this.version, required this.enabled});

  factory PluginInfo.fromJson(Map<String, dynamic> json) => PluginInfo(
        name: json['name'] as String? ?? '',
        version: json['version'] as String? ?? '',
        enabled: json['enabled'] as bool? ?? false,
      );
}

class MediaItem {
  final String id;
  final String title;
  final String path;
  final String mediaType;
  final int sizeBytes;

  MediaItem({
    required this.id,
    required this.title,
    required this.path,
    required this.mediaType,
    required this.sizeBytes,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) => MediaItem(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        path: json['path'] as String? ?? '',
        mediaType: json['media_type'] as String? ?? '',
        sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
      );

  String get sizeFormatted {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    if (sizeBytes < 1024 * 1024 * 1024) {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(sizeBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class Metric {
  final String name;
  final double value;

  Metric({required this.name, required this.value});

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        name: json['name'] as String? ?? '',
        value: (json['value'] as num?)?.toDouble() ?? 0.0,
      );
}
