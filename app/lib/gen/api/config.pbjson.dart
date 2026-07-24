// This is a generated file - do not edit.
//
// Generated from api/config.proto.

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

@$core.Deprecated('Use configResponseDescriptor instead')
const ConfigResponse$json = {
  '1': 'ConfigResponse',
  '2': [
    {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    {'1': 'log_level', '3': 3, '4': 1, '5': 9, '10': 'logLevel'},
    {'1': 'db_type', '3': 4, '4': 1, '5': 9, '10': 'dbType'},
    {'1': 'data_dir', '3': 5, '4': 1, '5': 9, '10': 'dataDir'},
    {'1': 'max_connections', '3': 6, '4': 1, '5': 13, '10': 'maxConnections'},
  ],
};

/// Descriptor for `ConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configResponseDescriptor = $convert.base64Decode(
    'Cg5Db25maWdSZXNwb25zZRISCgRob3N0GAEgASgJUgRob3N0EhIKBHBvcnQYAiABKA1SBHBvcn'
    'QSGwoJbG9nX2xldmVsGAMgASgJUghsb2dMZXZlbBIXCgdkYl90eXBlGAQgASgJUgZkYlR5cGUS'
    'GQoIZGF0YV9kaXIYBSABKAlSB2RhdGFEaXISJwoPbWF4X2Nvbm5lY3Rpb25zGAYgASgNUg5tYX'
    'hDb25uZWN0aW9ucw==');
