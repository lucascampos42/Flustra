import os

base = "/home/lucasc/development/Flustra/admin/lib"

# 1. Models
os.makedirs(f"{base}/models", exist_ok=True)
with open(f"{base}/models/models.dart", "w") as f:
    f.write(r"""class StatusResponse {
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
""")

print("models.dart written")

# 2. Providers
os.makedirs(f"{base}/providers", exist_ok=True)
with open(f"{base}/providers/providers.dart", "w") as f:
    f.write(r"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants.dart';
import '../models/models.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final apiServiceProvider = Provider<ApiService>((ref) {
  final client = ref.watch(httpClientProvider);
  return ApiService(client);
});

class ApiService {
  final http.Client _client;

  ApiService(this._client);

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, dynamic>> _get(String path) async {
    final uri = Uri.parse('${AppConstants.serverBaseUrl}$path');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('GET $path: ${response.statusCode} ${response.body}');
  }

  Future<List<dynamic>> _getList(String path) async {
    final uri = Uri.parse('${AppConstants.serverBaseUrl}$path');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    throw Exception('GET $path: ${response.statusCode} ${response.body}');
  }

  Future<Map<String, dynamic>> _post(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${AppConstants.serverBaseUrl}$path');
    final response = await _client.post(
      uri,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('POST $path: ${response.statusCode} ${response.body}');
  }

  Future<Map<String, dynamic>> _put(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${AppConstants.serverBaseUrl}$path');
    final response = await _client.put(
      uri,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('PUT $path: ${response.statusCode} ${response.body}');
  }

  Future<Map<String, dynamic>> _delete(String path) async {
    final uri = Uri.parse('${AppConstants.serverBaseUrl}$path');
    final response = await _client.delete(uri, headers: _headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {};
    }
    throw Exception('DELETE $path: ${response.statusCode} ${response.body}');
  }

  Future<StatusResponse> getStatus() async {
    final data = await _get('/status');
    return StatusResponse.fromJson(data);
  }

  Future<List<UserResponse>> getUsers() async {
    final data = await _getList('/users');
    return data.map((e) => UserResponse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<UserResponse> createUser(String username, String password, String role) async {
    final data = await _post('/users', body: {
      'username': username,
      'password': password,
      'role': role,
    });
    return UserResponse.fromJson(data);
  }

  Future<UserResponse> updateUser(String id, {String? username, String? password, String? role}) async {
    final body = <String, dynamic>{};
    if (username != null) body['username'] = username;
    if (password != null) body['password'] = password;
    if (role != null) body['role'] = role;
    final data = await _put('/users/$id', body: body);
    return UserResponse.fromJson(data);
  }

  Future<void> deleteUser(String id) async {
    await _delete('/users/$id/delete');
  }

  Future<LogsResponse> getLogs({String? level, String? search, int? limit, int? offset}) async {
    final params = <String, String>{};
    if (level != null) params['level'] = level;
    if (search != null) params['search'] = search;
    if (limit != null) params['limit'] = limit.toString();
    if (offset != null) params['offset'] = offset.toString();
    final query = params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
    final data = await _get('/logs${query.isNotEmpty ? '?$query' : ''}');
    return LogsResponse.fromJson(data);
  }

  Future<List<PluginInfo>> getPlugins() async {
    final data = await _getList('/plugins');
    return data.map((e) => PluginInfo.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<PluginInfo> togglePlugin(String name, bool enabled) async {
    final data = await _post('/plugins', body: {'name': name, 'enabled': enabled});
    return PluginInfo.fromJson(data);
  }

  Future<Map<String, dynamic>> getConfig() async {
    return await _get('/config');
  }

  Future<List<Metric>> getMetrics() async {
    final data = await _get('/metrics');
    final metrics = (data['metrics'] as List? ?? []);
    return metrics.map((e) => Metric.fromJson(e as Map<String, dynamic>)).toList();
  }
}

// --- Providers ---

final statusProvider = FutureProvider<StatusResponse>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.getStatus();
});

final usersProvider = FutureProvider<List<UserResponse>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.getUsers();
});

final logsProvider = FutureProvider.family<LogsResponse, LogQueryParams>((ref, params) async {
  final api = ref.watch(apiServiceProvider);
  return api.getLogs(level: params.level, search: params.search, limit: params.limit, offset: params.offset);
});

class LogQueryParams {
  final String? level;
  final String? search;
  final int? limit;
  final int? offset;
  LogQueryParams({this.level, this.search, this.limit, this.offset});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogQueryParams &&
          runtimeType == other.runtimeType &&
          level == other.level &&
          search == other.search &&
          limit == other.limit &&
          offset == other.offset;

  @override
  int get hashCode => Object.hash(level, search, limit, offset);
}

final pluginsProvider = FutureProvider<List<PluginInfo>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.getPlugins();
});

final configProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.getConfig();
});
""")

print("providers.dart written")

# 3. Sidebar
os.makedirs(f"{base}/core/widgets", exist_ok=True)
with open(f"{base}/core/widgets/sidebar.dart", "w") as f:
    f.write(r"""import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const AppShell({super.key, required this.currentRoute, required this.child});

  static const _navItems = [
    ('/', 'Dashboard', Icons.dashboard),
    ('/users', 'Users', Icons.people),
    ('/logs', 'Logs', Icons.list_alt),
    ('/plugins', 'Plugins', Icons.extension),
    ('/settings', 'Settings', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _navItems.indexWhere((n) => n.$1 == currentRoute),
            onDestinationSelected: (i) {
              final route = _navItems[i].$1;
              if (route != currentRoute) {
                Navigator.of(context).pushReplacementNamed(route);
              }
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset('assets/logo.png', height: 36),
            ),
            destinations: _navItems
                .map((n) => NavigationRailDestination(
                      icon: Icon(n.$3),
                      label: Text(n.$2),
                    ))
                .toList(),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
""")

print("sidebar.dart written")
print("All files generated successfully")