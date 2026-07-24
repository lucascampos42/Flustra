import 'package:flutter_riverpod/flutter_riverpod.dart';
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
