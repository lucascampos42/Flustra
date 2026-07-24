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
        dbType: json['db