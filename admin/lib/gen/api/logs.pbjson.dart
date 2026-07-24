// This is a generated file - do not edit.
//
// Generated from api/logs.proto.

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

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry$json = {
  '1': 'LogEntry',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'level', '3': 2, '4': 1, '5': 9, '10': 'level'},
    {'1': 'target', '3': 3, '4': 1, '5': 9, '10': 'target'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'fields',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.logs.LogEntry.FieldsEntry',
      '10': 'fields'
    },
  ],
  '3': [LogEntry_FieldsEntry$json],
};

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry_FieldsEntry$json = {
  '1': 'FieldsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryDescriptor = $convert.base64Decode(
    'CghMb2dFbnRyeRIcCgl0aW1lc3RhbXAYASABKAlSCXRpbWVzdGFtcBIUCgVsZXZlbBgCIAEoCV'
    'IFbGV2ZWwSFgoGdGFyZ2V0GAMgASgJUgZ0YXJnZXQSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2Fn'
    'ZRI+CgZmaWVsZHMYBSADKAsyJi5mbHVzdHJhLmFwaS5sb2dzLkxvZ0VudHJ5LkZpZWxkc0VudH'
    'J5UgZmaWVsZHMaOQoLRmllbGRzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiAB'
    'KAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use listLogsRequestDescriptor instead')
const ListLogsRequest$json = {
  '1': 'ListLogsRequest',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'level', '17': true},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'search', '17': true},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
  '8': [
    {'1': '_level'},
    {'1': '_search'},
  ],
};

/// Descriptor for `ListLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogsRequestDescriptor = $convert.base64Decode(
    'Cg9MaXN0TG9nc1JlcXVlc3QSGQoFbGV2ZWwYASABKAlIAFIFbGV2ZWyIAQESGwoGc2VhcmNoGA'
    'IgASgJSAFSBnNlYXJjaIgBARIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgF'
    'UgZvZmZzZXRCCAoGX2xldmVsQgkKB19zZWFyY2g=');

@$core.Deprecated('Use listLogsResponseDescriptor instead')
const ListLogsResponse$json = {
  '1': 'ListLogsResponse',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.logs.LogEntry',
      '10': 'entries'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogsResponseDescriptor = $convert.base64Decode(
    'ChBMaXN0TG9nc1Jlc3BvbnNlEjQKB2VudHJpZXMYASADKAsyGi5mbHVzdHJhLmFwaS5sb2dzLk'
    'xvZ0VudHJ5UgdlbnRyaWVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
