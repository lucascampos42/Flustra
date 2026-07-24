// This is a generated file - do not edit.
//
// Generated from api/server.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HealthResponse extends $pb.GeneratedMessage {
  factory HealthResponse({
    $core.String? status,
    $core.String? version,
    $core.double? uptimeSecs,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (version != null) result.version = version;
    if (uptimeSecs != null) result.uptimeSecs = uptimeSecs;
    return result;
  }

  HealthResponse._();

  factory HealthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'flustra.api.server'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..aD(3, _omitFieldNames ? '' : 'uptimeSecs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse copyWith(void Function(HealthResponse) updates) =>
      super.copyWith((message) => updates(message as HealthResponse))
          as HealthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthResponse create() => HealthResponse._();
  @$core.override
  HealthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthResponse>(create);
  static HealthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get uptimeSecs => $_getN(2);
  @$pb.TagNumber(3)
  set uptimeSecs($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUptimeSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearUptimeSecs() => $_clearField(3);
}

class StatusResponse extends $pb.GeneratedMessage {
  factory StatusResponse({
    $core.String? status,
    $core.String? version,
    $core.double? uptimeSecs,
    $fixnum.Int64? totalRequests,
    $fixnum.Int64? activeSessions,
    $core.String? dbType,
    $fixnum.Int64? dbSizeBytes,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (version != null) result.version = version;
    if (uptimeSecs != null) result.uptimeSecs = uptimeSecs;
    if (totalRequests != null) result.totalRequests = totalRequests;
    if (activeSessions != null) result.activeSessions = activeSessions;
    if (dbType != null) result.dbType = dbType;
    if (dbSizeBytes != null) result.dbSizeBytes = dbSizeBytes;
    return result;
  }

  StatusResponse._();

  factory StatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'flustra.api.server'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'version')
    ..aD(3, _omitFieldNames ? '' : 'uptimeSecs')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'totalRequests', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'activeSessions', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'dbType')
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'dbSizeBytes', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResponse copyWith(void Function(StatusResponse) updates) =>
      super.copyWith((message) => updates(message as StatusResponse))
          as StatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusResponse create() => StatusResponse._();
  @$core.override
  StatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatusResponse>(create);
  static StatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get uptimeSecs => $_getN(2);
  @$pb.TagNumber(3)
  set uptimeSecs($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUptimeSecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearUptimeSecs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalRequests => $_getI64(3);
  @$pb.TagNumber(4)
  set totalRequests($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalRequests() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalRequests() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get activeSessions => $_getI64(4);
  @$pb.TagNumber(5)
  set activeSessions($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasActiveSessions() => $_has(4);
  @$pb.TagNumber(5)
  void clearActiveSessions() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get dbType => $_getSZ(5);
  @$pb.TagNumber(6)
  set dbType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDbType() => $_has(5);
  @$pb.TagNumber(6)
  void clearDbType() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get dbSizeBytes => $_getI64(6);
  @$pb.TagNumber(7)
  set dbSizeBytes($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDbSizeBytes() => $_has(6);
  @$pb.TagNumber(7)
  void clearDbSizeBytes() => $_clearField(7);
}

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Empty',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'flustra.api.server'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  @$core.override
  Empty createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
