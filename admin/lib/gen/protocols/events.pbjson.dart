// This is a generated file - do not edit.
//
// Generated from protocols/events.proto.

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

@$core.Deprecated('Use serverEventDescriptor instead')
const ServerEvent$json = {
  '1': 'ServerEvent',
  '2': [
    {'1': 'event_type', '3': 1, '4': 1, '5': 9, '10': 'eventType'},
    {'1': 'payload_json', '3': 2, '4': 1, '5': 9, '10': 'payloadJson'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `ServerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverEventDescriptor = $convert.base64Decode(
    'CgtTZXJ2ZXJFdmVudBIdCgpldmVudF90eXBlGAEgASgJUglldmVudFR5cGUSIQoMcGF5bG9hZF'
    '9qc29uGAIgASgJUgtwYXlsb2FkSnNvbhIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use mediaScanStartedDescriptor instead')
const MediaScanStarted$json = {
  '1': 'MediaScanStarted',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `MediaScanStarted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaScanStartedDescriptor = $convert
    .base64Decode('ChBNZWRpYVNjYW5TdGFydGVkEhIKBHBhdGgYASABKAlSBHBhdGg=');

@$core.Deprecated('Use mediaScanCompletedDescriptor instead')
const MediaScanCompleted$json = {
  '1': 'MediaScanCompleted',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'items_found', '3': 2, '4': 1, '5': 5, '10': 'itemsFound'},
  ],
};

/// Descriptor for `MediaScanCompleted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaScanCompletedDescriptor = $convert.base64Decode(
    'ChJNZWRpYVNjYW5Db21wbGV0ZWQSEgoEcGF0aBgBIAEoCVIEcGF0aBIfCgtpdGVtc19mb3VuZB'
    'gCIAEoBVIKaXRlbXNGb3VuZA==');

@$core.Deprecated('Use sessionCreatedDescriptor instead')
const SessionCreated$json = {
  '1': 'SessionCreated',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `SessionCreated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionCreatedDescriptor = $convert.base64Decode(
    'Cg5TZXNzaW9uQ3JlYXRlZBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKc2Vzc2lvbl9pZB'
    'gCIAEoCVIJc2Vzc2lvbklk');

@$core.Deprecated('Use sessionDestroyedDescriptor instead')
const SessionDestroyed$json = {
  '1': 'SessionDestroyed',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `SessionDestroyed`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDestroyedDescriptor = $convert.base64Decode(
    'ChBTZXNzaW9uRGVzdHJveWVkEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIdCgpzZXNzaW9uX2'
    'lkGAIgASgJUglzZXNzaW9uSWQ=');
