// This is a generated file - do not edit.
//
// Generated from api/media.proto.

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

@$core.Deprecated('Use mediaItemDescriptor instead')
const MediaItem$json = {
  '1': 'MediaItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'media_type', '3': 4, '4': 1, '5': 9, '10': 'mediaType'},
    {'1': 'size_bytes', '3': 5, '4': 1, '5': 3, '10': 'sizeBytes'},
    {
      '1': 'duration_secs',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'durationSecs',
      '17': true
    },
    {'1': 'width', '3': 7, '4': 1, '5': 5, '9': 1, '10': 'width', '17': true},
    {'1': 'height', '3': 8, '4': 1, '5': 5, '9': 2, '10': 'height', '17': true},
    {'1': 'codec', '3': 9, '4': 1, '5': 9, '9': 3, '10': 'codec', '17': true},
    {
      '1': 'bitrate',
      '3': 10,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'bitrate',
      '17': true
    },
    {
      '1': 'metadata',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.media.MediaItem.MetadataEntry',
      '10': 'metadata'
    },
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [MediaItem_MetadataEntry$json],
  '8': [
    {'1': '_duration_secs'},
    {'1': '_width'},
    {'1': '_height'},
    {'1': '_codec'},
    {'1': '_bitrate'},
  ],
};

@$core.Deprecated('Use mediaItemDescriptor instead')
const MediaItem_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `MediaItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaItemDescriptor = $convert.base64Decode(
    'CglNZWRpYUl0ZW0SDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRISCgRwYX'
    'RoGAMgASgJUgRwYXRoEh0KCm1lZGlhX3R5cGUYBCABKAlSCW1lZGlhVHlwZRIdCgpzaXplX2J5'
    'dGVzGAUgASgDUglzaXplQnl0ZXMSKAoNZHVyYXRpb25fc2VjcxgGIAEoBUgAUgxkdXJhdGlvbl'
    'NlY3OIAQESGQoFd2lkdGgYByABKAVIAVIFd2lkdGiIAQESGwoGaGVpZ2h0GAggASgFSAJSBmhl'
    'aWdodIgBARIZCgVjb2RlYxgJIAEoCUgDUgVjb2RlY4gBARIdCgdiaXRyYXRlGAogASgFSARSB2'
    'JpdHJhdGWIAQESRgoIbWV0YWRhdGEYCyADKAsyKi5mbHVzdHJhLmFwaS5tZWRpYS5NZWRpYUl0'
    'ZW0uTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgMIAEoCVIJY3JlYXRlZE'
    'F0Eh0KCnVwZGF0ZWRfYXQYDSABKAlSCXVwZGF0ZWRBdBo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tl'
    'eRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCEAoOX2R1cmF0aW9uX3NlY3'
    'NCCAoGX3dpZHRoQgkKB19oZWlnaHRCCAoGX2NvZGVjQgoKCF9iaXRyYXRl');

@$core.Deprecated('Use listMediaRequestDescriptor instead')
const ListMediaRequest$json = {
  '1': 'ListMediaRequest',
  '2': [
    {
      '1': 'media_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'mediaType',
      '17': true
    },
    {'1': 'search', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'search', '17': true},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
  '8': [
    {'1': '_media_type'},
    {'1': '_search'},
  ],
};

/// Descriptor for `ListMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMediaRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0TWVkaWFSZXF1ZXN0EiIKCm1lZGlhX3R5cGUYASABKAlIAFIJbWVkaWFUeXBliAEBEh'
    'sKBnNlYXJjaBgCIAEoCUgBUgZzZWFyY2iIAQESEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdl'
    'X3NpemUYBCABKAVSCHBhZ2VTaXplQg0KC19tZWRpYV90eXBlQgkKB19zZWFyY2g=');

@$core.Deprecated('Use listMediaResponseDescriptor instead')
const ListMediaResponse$json = {
  '1': 'ListMediaResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.media.MediaItem',
      '10': 'items'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListMediaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMediaResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0TWVkaWFSZXNwb25zZRIyCgVpdGVtcxgBIAMoCzIcLmZsdXN0cmEuYXBpLm1lZGlhLk'
    '1lZGlhSXRlbVIFaXRlbXMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBh'
    'Z2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
