// This is a generated file - do not edit.
//
// Generated from api/config.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ConfigResponse extends $pb.GeneratedMessage {
  factory ConfigResponse({
    $core.String? host,
    $core.int? port,
    $core.String? logLevel,
    $core.String? dbType,
    $core.String? dataDir,
    $core.int? maxConnections,
  }) {
    final result = create();
    if (host != null) result.host = host;
    if (port != null) result.port = port;
    if (logLevel != null) result.logLevel = logLevel;
    if (dbType != null) result.dbType = dbType;
    if (dataDir != null) result.dataDir = dataDir;
    if (maxConnections != null) result.maxConnections = maxConnections;
    return result;
  }

  ConfigResponse._();

  factory ConfigResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfigResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfigResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'flustra.api.config'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'host')
    ..aI(2, _omitFieldNames ? '' : 'port', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'logLevel')
    ..aOS(4, _omitFieldNames ? '' : 'dbType')
    ..aOS(5, _omitFieldNames ? '' : 'dataDir')
    ..aI(6, _omitFieldNames ? '' : 'maxConnections',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigResponse copyWith(void Function(ConfigResponse) updates) =>
      super.copyWith((message) => updates(message as ConfigResponse))
          as ConfigResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigResponse create() => ConfigResponse._();
  @$core.override
  ConfigResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ConfigResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfigResponse>(create);
  static ConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get host => $_getSZ(0);
  @$pb.TagNumber(1)
  set host($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get logLevel => $_getSZ(2);
  @$pb.TagNumber(3)
  set logLevel($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get dbType => $_getSZ(3);
  @$pb.TagNumber(4)
  set dbType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDbType() => $_has(3);
  @$pb.TagNumber(4)
  void clearDbType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dataDir => $_getSZ(4);
  @$pb.TagNumber(5)
  set dataDir($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDataDir() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataDir() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get maxConnections => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxConnections($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxConnections() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxConnections() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
