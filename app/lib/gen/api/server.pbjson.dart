// This is a generated file - do not edit.
//
// Generated from api/server.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use healthResponseDescriptor instead')
const HealthResponse$json = {
  '1': 'HealthResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'uptime_secs', '3': 3, '4': 1, '5': 1, '10': 'uptimeSecs'},
  ],
};

/// Descriptor for `HealthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthResponseDescriptor = $convert.base64Decode(
    'Cg5IZWFsdGhSZXNwb25zZRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIYCgd2ZXJzaW9uGAIgAS'
    'gJUgd2ZXJzaW9uEh8KC3VwdGltZV9zZWNzGAMgASgBUgp1cHRpbWVTZWNz');

@$core.Deprecated('Use statusResponseDescriptor instead')
const StatusResponse$json = {
  '1': 'StatusResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'uptime_secs', '3': 3, '4': 1, '5': 1, '10': 'uptimeSecs'},
    {'1': 'total_requests', '3': 4, '4': 1, '5': 4, '10': 'totalRequests'},
    {'1': 'active_sessions', '3': 5, '4': 1, '5': 4, '10': 'activeSessions'},
    {'1': 'db_type', '3': 6, '4': 1, '5': 9, '10': 'dbType'},
    {'1': 'db_size_bytes', '3': 7, '4': 1, '5': 4, '10': 'dbSizeBytes'},
  ],
};

/// Descriptor for `StatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResponseDescriptor = $convert.base64Decode(
    'Cg5TdGF0dXNSZXNwb25zZRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIYCgd2ZXJzaW9uGAIgAS'
    'gJUgd2ZXJzaW9uEh8KC3VwdGltZV9zZWNzGAMgASgBUgp1cHRpbWVTZWNzEiUKDnRvdGFsX3Jl'
    'cXVlc3RzGAQgASgEUg10b3RhbFJlcXVlc3RzEicKD2FjdGl2ZV9zZXNzaW9ucxgFIAEoBFIOYW'
    'N0aXZlU2Vzc2lvbnMSFwoHZGJfdHlwZRgGIAEoCVIGZGJUeXBlEiIKDWRiX3NpemVfYnl0ZXMY'
    'ByABKARSC2RiU2l6ZUJ5dGVz');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
