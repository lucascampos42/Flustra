// This is a generated file - do not edit.
//
// Generated from api/metrics.proto.

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

@$core.Deprecated('Use metricDescriptor instead')
const Metric$json = {
  '1': 'Metric',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    {
      '1': 'labels',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.metrics.Metric.LabelsEntry',
      '10': 'labels'
    },
  ],
  '3': [Metric_LabelsEntry$json],
};

@$core.Deprecated('Use metricDescriptor instead')
const Metric_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Metric`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricDescriptor = $convert.base64Decode(
    'CgZNZXRyaWMSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWUSPwoGbG'
    'FiZWxzGAMgAygLMicuZmx1c3RyYS5hcGkubWV0cmljcy5NZXRyaWMuTGFiZWxzRW50cnlSBmxh'
    'YmVscxo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdm'
    'FsdWU6AjgB');

@$core.Deprecated('Use metricsResponseDescriptor instead')
const MetricsResponse$json = {
  '1': 'MetricsResponse',
  '2': [
    {
      '1': 'metrics',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.flustra.api.metrics.Metric',
      '10': 'metrics'
    },
  ],
};

/// Descriptor for `MetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricsResponseDescriptor = $convert.base64Decode(
    'Cg9NZXRyaWNzUmVzcG9uc2USNQoHbWV0cmljcxgBIAMoCzIbLmZsdXN0cmEuYXBpLm1ldHJpY3'
    'MuTWV0cmljUgdtZXRyaWNz');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
