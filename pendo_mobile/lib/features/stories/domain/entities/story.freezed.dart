// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) {
  return _StoryModel.fromJson(json);
}

/// @nodoc
mixin _$StoryModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // image, video
  String get url => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  int get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reaction_count')
  int get reactionCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this StoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryModelCopyWith<StoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryModelCopyWith<$Res> {
  factory $StoryModelCopyWith(
          StoryModel value, $Res Function(StoryModel) then) =
      _$StoryModelCopyWithImpl<$Res, StoryModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      String url,
      String? caption,
      @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
      @JsonKey(name: 'view_count') int viewCount,
      @JsonKey(name: 'reaction_count') int reactionCount,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class _$StoryModelCopyWithImpl<$Res, $Val extends StoryModel>
    implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? url = null,
    Object? caption = freezed,
    Object? culturalTags = freezed,
    Object? viewCount = null,
    Object? reactionCount = null,
    Object? createdAt = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      culturalTags: freezed == culturalTags
          ? _value.culturalTags
          : culturalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _value.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryModelImplCopyWith<$Res>
    implements $StoryModelCopyWith<$Res> {
  factory _$$StoryModelImplCopyWith(
          _$StoryModelImpl value, $Res Function(_$StoryModelImpl) then) =
      __$$StoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      String url,
      String? caption,
      @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
      @JsonKey(name: 'view_count') int viewCount,
      @JsonKey(name: 'reaction_count') int reactionCount,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class __$$StoryModelImplCopyWithImpl<$Res>
    extends _$StoryModelCopyWithImpl<$Res, _$StoryModelImpl>
    implements _$$StoryModelImplCopyWith<$Res> {
  __$$StoryModelImplCopyWithImpl(
      _$StoryModelImpl _value, $Res Function(_$StoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? url = null,
    Object? caption = freezed,
    Object? culturalTags = freezed,
    Object? viewCount = null,
    Object? reactionCount = null,
    Object? createdAt = null,
    Object? expiresAt = null,
  }) {
    return _then(_$StoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      culturalTags: freezed == culturalTags
          ? _value._culturalTags
          : culturalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _value.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryModelImpl implements _StoryModel {
  const _$StoryModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.type,
      required this.url,
      this.caption,
      @JsonKey(name: 'cultural_tags') final List<String>? culturalTags,
      @JsonKey(name: 'view_count') required this.viewCount,
      @JsonKey(name: 'reaction_count') required this.reactionCount,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'expires_at') required this.expiresAt})
      : _culturalTags = culturalTags;

  factory _$StoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String type;
// image, video
  @override
  final String url;
  @override
  final String? caption;
  final List<String>? _culturalTags;
  @override
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags {
    final value = _culturalTags;
    if (value == null) return null;
    if (_culturalTags is EqualUnmodifiableListView) return _culturalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'view_count')
  final int viewCount;
  @override
  @JsonKey(name: 'reaction_count')
  final int reactionCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  @override
  String toString() {
    return 'StoryModel(id: $id, userId: $userId, type: $type, url: $url, caption: $caption, culturalTags: $culturalTags, viewCount: $viewCount, reactionCount: $reactionCount, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            const DeepCollectionEquality()
                .equals(other._culturalTags, _culturalTags) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.reactionCount, reactionCount) ||
                other.reactionCount == reactionCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      type,
      url,
      caption,
      const DeepCollectionEquality().hash(_culturalTags),
      viewCount,
      reactionCount,
      createdAt,
      expiresAt);

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      __$$StoryModelImplCopyWithImpl<_$StoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryModelImplToJson(
      this,
    );
  }
}

abstract class _StoryModel implements StoryModel {
  const factory _StoryModel(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final String type,
          required final String url,
          final String? caption,
          @JsonKey(name: 'cultural_tags') final List<String>? culturalTags,
          @JsonKey(name: 'view_count') required final int viewCount,
          @JsonKey(name: 'reaction_count') required final int reactionCount,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'expires_at') required final DateTime expiresAt}) =
      _$StoryModelImpl;

  factory _StoryModel.fromJson(Map<String, dynamic> json) =
      _$StoryModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get type; // image, video
  @override
  String get url;
  @override
  String? get caption;
  @override
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags;
  @override
  @JsonKey(name: 'view_count')
  int get viewCount;
  @override
  @JsonKey(name: 'reaction_count')
  int get reactionCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiveStreamModel _$LiveStreamModelFromJson(Map<String, dynamic> json) {
  return _LiveStreamModel.fromJson(json);
}

/// @nodoc
mixin _$LiveStreamModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'stream_url')
  String get streamUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'viewer_count')
  int get viewerCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Serializes this LiveStreamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveStreamModelCopyWith<LiveStreamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveStreamModelCopyWith<$Res> {
  factory $LiveStreamModelCopyWith(
          LiveStreamModel value, $Res Function(LiveStreamModel) then) =
      _$LiveStreamModelCopyWithImpl<$Res, LiveStreamModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      String? description,
      @JsonKey(name: 'stream_url') String streamUrl,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      @JsonKey(name: 'viewer_count') int viewerCount,
      @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'started_at') DateTime startedAt});
}

/// @nodoc
class _$LiveStreamModelCopyWithImpl<$Res, $Val extends LiveStreamModel>
    implements $LiveStreamModelCopyWith<$Res> {
  _$LiveStreamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? streamUrl = null,
    Object? thumbnailUrl = freezed,
    Object? viewerCount = null,
    Object? culturalTags = freezed,
    Object? isActive = null,
    Object? startedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      viewerCount: null == viewerCount
          ? _value.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
      culturalTags: freezed == culturalTags
          ? _value.culturalTags
          : culturalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveStreamModelImplCopyWith<$Res>
    implements $LiveStreamModelCopyWith<$Res> {
  factory _$$LiveStreamModelImplCopyWith(_$LiveStreamModelImpl value,
          $Res Function(_$LiveStreamModelImpl) then) =
      __$$LiveStreamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      String? description,
      @JsonKey(name: 'stream_url') String streamUrl,
      @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
      @JsonKey(name: 'viewer_count') int viewerCount,
      @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'started_at') DateTime startedAt});
}

/// @nodoc
class __$$LiveStreamModelImplCopyWithImpl<$Res>
    extends _$LiveStreamModelCopyWithImpl<$Res, _$LiveStreamModelImpl>
    implements _$$LiveStreamModelImplCopyWith<$Res> {
  __$$LiveStreamModelImplCopyWithImpl(
      _$LiveStreamModelImpl _value, $Res Function(_$LiveStreamModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? streamUrl = null,
    Object? thumbnailUrl = freezed,
    Object? viewerCount = null,
    Object? culturalTags = freezed,
    Object? isActive = null,
    Object? startedAt = null,
  }) {
    return _then(_$LiveStreamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      viewerCount: null == viewerCount
          ? _value.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
      culturalTags: freezed == culturalTags
          ? _value._culturalTags
          : culturalTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveStreamModelImpl implements _LiveStreamModel {
  const _$LiveStreamModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.title,
      this.description,
      @JsonKey(name: 'stream_url') required this.streamUrl,
      @JsonKey(name: 'thumbnail_url') this.thumbnailUrl,
      @JsonKey(name: 'viewer_count') required this.viewerCount,
      @JsonKey(name: 'cultural_tags') final List<String>? culturalTags,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'started_at') required this.startedAt})
      : _culturalTags = culturalTags;

  factory _$LiveStreamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveStreamModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'stream_url')
  final String streamUrl;
  @override
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @override
  @JsonKey(name: 'viewer_count')
  final int viewerCount;
  final List<String>? _culturalTags;
  @override
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags {
    final value = _culturalTags;
    if (value == null) return null;
    if (_culturalTags is EqualUnmodifiableListView) return _culturalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;

  @override
  String toString() {
    return 'LiveStreamModel(id: $id, userId: $userId, title: $title, description: $description, streamUrl: $streamUrl, thumbnailUrl: $thumbnailUrl, viewerCount: $viewerCount, culturalTags: $culturalTags, isActive: $isActive, startedAt: $startedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveStreamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount) &&
            const DeepCollectionEquality()
                .equals(other._culturalTags, _culturalTags) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      streamUrl,
      thumbnailUrl,
      viewerCount,
      const DeepCollectionEquality().hash(_culturalTags),
      isActive,
      startedAt);

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveStreamModelImplCopyWith<_$LiveStreamModelImpl> get copyWith =>
      __$$LiveStreamModelImplCopyWithImpl<_$LiveStreamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveStreamModelImplToJson(
      this,
    );
  }
}

abstract class _LiveStreamModel implements LiveStreamModel {
  const factory _LiveStreamModel(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final String title,
          final String? description,
          @JsonKey(name: 'stream_url') required final String streamUrl,
          @JsonKey(name: 'thumbnail_url') final String? thumbnailUrl,
          @JsonKey(name: 'viewer_count') required final int viewerCount,
          @JsonKey(name: 'cultural_tags') final List<String>? culturalTags,
          @JsonKey(name: 'is_active') required final bool isActive,
          @JsonKey(name: 'started_at') required final DateTime startedAt}) =
      _$LiveStreamModelImpl;

  factory _LiveStreamModel.fromJson(Map<String, dynamic> json) =
      _$LiveStreamModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'stream_url')
  String get streamUrl;
  @override
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl;
  @override
  @JsonKey(name: 'viewer_count')
  int get viewerCount;
  @override
  @JsonKey(name: 'cultural_tags')
  List<String>? get culturalTags;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'started_at')
  DateTime get startedAt;

  /// Create a copy of LiveStreamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveStreamModelImplCopyWith<_$LiveStreamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryReactionModel _$StoryReactionModelFromJson(Map<String, dynamic> json) {
  return _StoryReactionModel.fromJson(json);
}

/// @nodoc
mixin _$StoryReactionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_id')
  String get storyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StoryReactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryReactionModelCopyWith<StoryReactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryReactionModelCopyWith<$Res> {
  factory $StoryReactionModelCopyWith(
          StoryReactionModel value, $Res Function(StoryReactionModel) then) =
      _$StoryReactionModelCopyWithImpl<$Res, StoryReactionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'story_id') String storyId,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$StoryReactionModelCopyWithImpl<$Res, $Val extends StoryReactionModel>
    implements $StoryReactionModelCopyWith<$Res> {
  _$StoryReactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storyId = null,
    Object? userId = null,
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryReactionModelImplCopyWith<$Res>
    implements $StoryReactionModelCopyWith<$Res> {
  factory _$$StoryReactionModelImplCopyWith(_$StoryReactionModelImpl value,
          $Res Function(_$StoryReactionModelImpl) then) =
      __$$StoryReactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'story_id') String storyId,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$StoryReactionModelImplCopyWithImpl<$Res>
    extends _$StoryReactionModelCopyWithImpl<$Res, _$StoryReactionModelImpl>
    implements _$$StoryReactionModelImplCopyWith<$Res> {
  __$$StoryReactionModelImplCopyWithImpl(_$StoryReactionModelImpl _value,
      $Res Function(_$StoryReactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storyId = null,
    Object? userId = null,
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(_$StoryReactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryReactionModelImpl implements _StoryReactionModel {
  const _$StoryReactionModelImpl(
      {required this.id,
      @JsonKey(name: 'story_id') required this.storyId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.type,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$StoryReactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryReactionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'story_id')
  final String storyId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String type;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'StoryReactionModel(id: $id, storyId: $storyId, userId: $userId, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryReactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, storyId, userId, type, createdAt);

  /// Create a copy of StoryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryReactionModelImplCopyWith<_$StoryReactionModelImpl> get copyWith =>
      __$$StoryReactionModelImplCopyWithImpl<_$StoryReactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryReactionModelImplToJson(
      this,
    );
  }
}

abstract class _StoryReactionModel implements StoryReactionModel {
  const factory _StoryReactionModel(
          {required final String id,
          @JsonKey(name: 'story_id') required final String storyId,
          @JsonKey(name: 'user_id') required final String userId,
          required final String type,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$StoryReactionModelImpl;

  factory _StoryReactionModel.fromJson(Map<String, dynamic> json) =
      _$StoryReactionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'story_id')
  String get storyId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get type;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of StoryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryReactionModelImplCopyWith<_$StoryReactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreamCommentModel _$StreamCommentModelFromJson(Map<String, dynamic> json) {
  return _StreamCommentModel.fromJson(json);
}

/// @nodoc
mixin _$StreamCommentModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StreamCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamCommentModelCopyWith<StreamCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamCommentModelCopyWith<$Res> {
  factory $StreamCommentModelCopyWith(
          StreamCommentModel value, $Res Function(StreamCommentModel) then) =
      _$StreamCommentModelCopyWithImpl<$Res, StreamCommentModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'stream_id') String streamId,
      @JsonKey(name: 'user_id') String userId,
      String text,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$StreamCommentModelCopyWithImpl<$Res, $Val extends StreamCommentModel>
    implements $StreamCommentModelCopyWith<$Res> {
  _$StreamCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? streamId = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamCommentModelImplCopyWith<$Res>
    implements $StreamCommentModelCopyWith<$Res> {
  factory _$$StreamCommentModelImplCopyWith(_$StreamCommentModelImpl value,
          $Res Function(_$StreamCommentModelImpl) then) =
      __$$StreamCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'stream_id') String streamId,
      @JsonKey(name: 'user_id') String userId,
      String text,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$StreamCommentModelImplCopyWithImpl<$Res>
    extends _$StreamCommentModelCopyWithImpl<$Res, _$StreamCommentModelImpl>
    implements _$$StreamCommentModelImplCopyWith<$Res> {
  __$$StreamCommentModelImplCopyWithImpl(_$StreamCommentModelImpl _value,
      $Res Function(_$StreamCommentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? streamId = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_$StreamCommentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamCommentModelImpl implements _StreamCommentModel {
  const _$StreamCommentModelImpl(
      {required this.id,
      @JsonKey(name: 'stream_id') required this.streamId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.text,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$StreamCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamCommentModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String text;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'StreamCommentModel(id: $id, streamId: $streamId, userId: $userId, text: $text, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, streamId, userId, text, createdAt);

  /// Create a copy of StreamCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamCommentModelImplCopyWith<_$StreamCommentModelImpl> get copyWith =>
      __$$StreamCommentModelImplCopyWithImpl<_$StreamCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamCommentModelImplToJson(
      this,
    );
  }
}

abstract class _StreamCommentModel implements StreamCommentModel {
  const factory _StreamCommentModel(
          {required final String id,
          @JsonKey(name: 'stream_id') required final String streamId,
          @JsonKey(name: 'user_id') required final String userId,
          required final String text,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$StreamCommentModelImpl;

  factory _StreamCommentModel.fromJson(Map<String, dynamic> json) =
      _$StreamCommentModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'stream_id')
  String get streamId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get text;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of StreamCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamCommentModelImplCopyWith<_$StreamCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
