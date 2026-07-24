// This is a generated file - do not edit.
//
// Generated from api/plugins.proto.

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

@$core.Deprecated('Use pluginInfoDescriptor instead')
const PluginInfo$json = {
  '1': 'PluginInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'enabled', '3': 3, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `PluginInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pluginInfoDescriptor = $convert.base64Decode(
    'CgpQbHVnaW5JbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHdmVyc2lvbhgCIAEoCVIHdmVyc2'
    'lvbhIYCgdlbmFibGVkGAMgASgIUgdlbmFibGVk');

@$core.Deprecated('Use listPluginsResponseDescriptor instead')
const ListPluginsResponse$json = {
  '1': 'ListPluginsResponse',
  '2': [
    {
      '1': 'plugins',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.plugins.PluginInfo',
      '10': 'plugins'
    },
  ],
};

/// Descriptor for `ListPluginsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPluginsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0UGx1Z2luc1Jlc3BvbnNlEjkKB3BsdWdpbnMYASADKAsyHy5mbHVzdHJhLmFwaS5wbH'
    'VnaW5zLlBsdWdpbkluZm9SB3BsdWdpbnM=');

@$core.Deprecated('Use togglePluginRequestDescriptor instead')
const TogglePluginRequest$json = {
  '1': 'TogglePluginRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `TogglePluginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List togglePluginRequestDescriptor = $convert.base64Decode(
    'ChNUb2dnbGVQbHVnaW5SZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSGAoHZW5hYmxlZBgCIA'
    'EoCFIHZW5hYmxlZA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
