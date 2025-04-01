// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tribe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TribeModel _$TribeModelFromJson(Map<String, dynamic> json) {
  return _TribeModel.fromJson(json);
}

/// @nodoc
mixin _$TribeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_count')
  int get memberCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'events_count')
  int get eventsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'messages_count')
  int get messagesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'chief_id')
  String? get chiefId => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  LocationModel? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_focus')
  List<String>? get culturalFocus => throw _privateConstructorUsedError;
  @JsonKey(name: 'traditions')
  List<String>? get traditions => throw _privateConstructorUsedError;
  @JsonKey(name: 'events')
  List<TribeEventModel>? get events => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TribeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TribeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TribeModelCopyWith<TribeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TribeModelCopyWith<$Res> {
  factory $TribeModelCopyWith(
          TribeModel value, $Res Function(TribeModel) then) =
      _$TribeModelCopyWithImpl<$Res, TribeModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      String status,
      @JsonKey(name: 'member_count') int memberCount,
      @JsonKey(name: 'events_count') int eventsCount,
      @JsonKey(name: 'messages_count') int messagesCount,
      @JsonKey(name: 'chief_id') String? chiefId,
      @JsonKey(name: 'location') LocationModel? location,
      @JsonKey(name: 'cultural_focus') List<String>? culturalFocus,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'events') List<TribeEventModel>? events,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$TribeModelCopyWithImpl<$Res, $Val extends TribeModel>
    implements $TribeModelCopyWith<$Res> {
  _$TribeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TribeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdBy = null,
    Object? status = null,
    Object? memberCount = null,
    Object? eventsCount = null,
    Object? messagesCount = null,
    Object? chiefId = freezed,
    Object? location = freezed,
    Object? culturalFocus = freezed,
    Object? traditions = freezed,
    Object? events = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      eventsCount: null == eventsCount
          ? _value.eventsCount
          : eventsCount // ignore: cast_nullable_to_non_nullable
              as int,
      messagesCount: null == messagesCount
          ? _value.messagesCount
          : messagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      chiefId: freezed == chiefId
          ? _value.chiefId
          : chiefId // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      culturalFocus: freezed == culturalFocus
          ? _value.culturalFocus
          : culturalFocus // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      traditions: freezed == traditions
          ? _value.traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      events: freezed == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<TribeEventModel>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TribeModelImplCopyWith<$Res>
    implements $TribeModelCopyWith<$Res> {
  factory _$$TribeModelImplCopyWith(
          _$TribeModelImpl value, $Res Function(_$TribeModelImpl) then) =
      __$$TribeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      String status,
      @JsonKey(name: 'member_count') int memberCount,
      @JsonKey(name: 'events_count') int eventsCount,
      @JsonKey(name: 'messages_count') int messagesCount,
      @JsonKey(name: 'chief_id') String? chiefId,
      @JsonKey(name: 'location') LocationModel? location,
      @JsonKey(name: 'cultural_focus') List<String>? culturalFocus,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'events') List<TribeEventModel>? events,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$TribeModelImplCopyWithImpl<$Res>
    extends _$TribeModelCopyWithImpl<$Res, _$TribeModelImpl>
    implements _$$TribeModelImplCopyWith<$Res> {
  __$$TribeModelImplCopyWithImpl(
      _$TribeModelImpl _value, $Res Function(_$TribeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TribeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdBy = null,
    Object? status = null,
    Object? memberCount = null,
    Object? eventsCount = null,
    Object? messagesCount = null,
    Object? chiefId = freezed,
    Object? location = freezed,
    Object? culturalFocus = freezed,
    Object? traditions = freezed,
    Object? events = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TribeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      eventsCount: null == eventsCount
          ? _value.eventsCount
          : eventsCount // ignore: cast_nullable_to_non_nullable
              as int,
      messagesCount: null == messagesCount
          ? _value.messagesCount
          : messagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      chiefId: freezed == chiefId
          ? _value.chiefId
          : chiefId // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      culturalFocus: freezed == culturalFocus
          ? _value._culturalFocus
          : culturalFocus // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      traditions: freezed == traditions
          ? _value._traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      events: freezed == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<TribeEventModel>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TribeModelImpl implements _TribeModel {
  const _$TribeModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @JsonKey(name: 'created_by') required this.createdBy,
      required this.status,
      @JsonKey(name: 'member_count') required this.memberCount,
      @JsonKey(name: 'events_count') required this.eventsCount,
      @JsonKey(name: 'messages_count') required this.messagesCount,
      @JsonKey(name: 'chief_id') this.chiefId,
      @JsonKey(name: 'location') this.location,
      @JsonKey(name: 'cultural_focus') final List<String>? culturalFocus,
      @JsonKey(name: 'traditions') final List<String>? traditions,
      @JsonKey(name: 'events') final List<TribeEventModel>? events,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : _culturalFocus = culturalFocus,
        _traditions = traditions,
        _events = events;

  factory _$TribeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TribeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  final String status;
  @override
  @JsonKey(name: 'member_count')
  final int memberCount;
  @override
  @JsonKey(name: 'events_count')
  final int eventsCount;
  @override
  @JsonKey(name: 'messages_count')
  final int messagesCount;
  @override
  @JsonKey(name: 'chief_id')
  final String? chiefId;
  @override
  @JsonKey(name: 'location')
  final LocationModel? location;
  final List<String>? _culturalFocus;
  @override
  @JsonKey(name: 'cultural_focus')
  List<String>? get culturalFocus {
    final value = _culturalFocus;
    if (value == null) return null;
    if (_culturalFocus is EqualUnmodifiableListView) return _culturalFocus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _traditions;
  @override
  @JsonKey(name: 'traditions')
  List<String>? get traditions {
    final value = _traditions;
    if (value == null) return null;
    if (_traditions is EqualUnmodifiableListView) return _traditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TribeEventModel>? _events;
  @override
  @JsonKey(name: 'events')
  List<TribeEventModel>? get events {
    final value = _events;
    if (value == null) return null;
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TribeModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, createdBy: $createdBy, status: $status, memberCount: $memberCount, eventsCount: $eventsCount, messagesCount: $messagesCount, chiefId: $chiefId, location: $location, culturalFocus: $culturalFocus, traditions: $traditions, events: $events, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TribeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.eventsCount, eventsCount) ||
                other.eventsCount == eventsCount) &&
            (identical(other.messagesCount, messagesCount) ||
                other.messagesCount == messagesCount) &&
            (identical(other.chiefId, chiefId) || other.chiefId == chiefId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._culturalFocus, _culturalFocus) &&
            const DeepCollectionEquality()
                .equals(other._traditions, _traditions) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      createdBy,
      status,
      memberCount,
      eventsCount,
      messagesCount,
      chiefId,
      location,
      const DeepCollectionEquality().hash(_culturalFocus),
      const DeepCollectionEquality().hash(_traditions),
      const DeepCollectionEquality().hash(_events),
      createdAt,
      updatedAt);

  /// Create a copy of TribeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TribeModelImplCopyWith<_$TribeModelImpl> get copyWith =>
      __$$TribeModelImplCopyWithImpl<_$TribeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TribeModelImplToJson(
      this,
    );
  }
}

abstract class _TribeModel implements TribeModel {
  const factory _TribeModel(
          {required final String id,
          required final String name,
          required final String description,
          @JsonKey(name: 'image_url') required final String imageUrl,
          @JsonKey(name: 'created_by') required final String createdBy,
          required final String status,
          @JsonKey(name: 'member_count') required final int memberCount,
          @JsonKey(name: 'events_count') required final int eventsCount,
          @JsonKey(name: 'messages_count') required final int messagesCount,
          @JsonKey(name: 'chief_id') final String? chiefId,
          @JsonKey(name: 'location') final LocationModel? location,
          @JsonKey(name: 'cultural_focus') final List<String>? culturalFocus,
          @JsonKey(name: 'traditions') final List<String>? traditions,
          @JsonKey(name: 'events') final List<TribeEventModel>? events,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt}) =
      _$TribeModelImpl;

  factory _TribeModel.fromJson(Map<String, dynamic> json) =
      _$TribeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  String get status;
  @override
  @JsonKey(name: 'member_count')
  int get memberCount;
  @override
  @JsonKey(name: 'events_count')
  int get eventsCount;
  @override
  @JsonKey(name: 'messages_count')
  int get messagesCount;
  @override
  @JsonKey(name: 'chief_id')
  String? get chiefId;
  @override
  @JsonKey(name: 'location')
  LocationModel? get location;
  @override
  @JsonKey(name: 'cultural_focus')
  List<String>? get culturalFocus;
  @override
  @JsonKey(name: 'traditions')
  List<String>? get traditions;
  @override
  @JsonKey(name: 'events')
  List<TribeEventModel>? get events;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of TribeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TribeModelImplCopyWith<_$TribeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TribeEventModel _$TribeEventModelFromJson(Map<String, dynamic> json) {
  return _TribeEventModel.fromJson(json);
}

/// @nodoc
mixin _$TribeEventModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendees_count')
  int get attendeesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_type')
  String? get culturalType => throw _privateConstructorUsedError;
  @JsonKey(name: 'traditions')
  List<String>? get traditions => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TribeEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TribeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TribeEventModelCopyWith<TribeEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TribeEventModelCopyWith<$Res> {
  factory $TribeEventModelCopyWith(
          TribeEventModel value, $Res Function(TribeEventModel) then) =
      _$TribeEventModelCopyWithImpl<$Res, TribeEventModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime date,
      String location,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'attendees_count') int attendeesCount,
      @JsonKey(name: 'cultural_type') String? culturalType,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$TribeEventModelCopyWithImpl<$Res, $Val extends TribeEventModel>
    implements $TribeEventModelCopyWith<$Res> {
  _$TribeEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TribeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? location = null,
    Object? imageUrl = freezed,
    Object? createdBy = null,
    Object? attendeesCount = null,
    Object? culturalType = freezed,
    Object? traditions = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      attendeesCount: null == attendeesCount
          ? _value.attendeesCount
          : attendeesCount // ignore: cast_nullable_to_non_nullable
              as int,
      culturalType: freezed == culturalType
          ? _value.culturalType
          : culturalType // ignore: cast_nullable_to_non_nullable
              as String?,
      traditions: freezed == traditions
          ? _value.traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TribeEventModelImplCopyWith<$Res>
    implements $TribeEventModelCopyWith<$Res> {
  factory _$$TribeEventModelImplCopyWith(_$TribeEventModelImpl value,
          $Res Function(_$TribeEventModelImpl) then) =
      __$$TribeEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime date,
      String location,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'attendees_count') int attendeesCount,
      @JsonKey(name: 'cultural_type') String? culturalType,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$TribeEventModelImplCopyWithImpl<$Res>
    extends _$TribeEventModelCopyWithImpl<$Res, _$TribeEventModelImpl>
    implements _$$TribeEventModelImplCopyWith<$Res> {
  __$$TribeEventModelImplCopyWithImpl(
      _$TribeEventModelImpl _value, $Res Function(_$TribeEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TribeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? location = null,
    Object? imageUrl = freezed,
    Object? createdBy = null,
    Object? attendeesCount = null,
    Object? culturalType = freezed,
    Object? traditions = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$TribeEventModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      attendeesCount: null == attendeesCount
          ? _value.attendeesCount
          : attendeesCount // ignore: cast_nullable_to_non_nullable
              as int,
      culturalType: freezed == culturalType
          ? _value.culturalType
          : culturalType // ignore: cast_nullable_to_non_nullable
              as String?,
      traditions: freezed == traditions
          ? _value._traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TribeEventModelImpl implements _TribeEventModel {
  const _$TribeEventModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.location,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'attendees_count') required this.attendeesCount,
      @JsonKey(name: 'cultural_type') this.culturalType,
      @JsonKey(name: 'traditions') final List<String>? traditions,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _traditions = traditions;

  factory _$TribeEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TribeEventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final String location;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'attendees_count')
  final int attendeesCount;
  @override
  @JsonKey(name: 'cultural_type')
  final String? culturalType;
  final List<String>? _traditions;
  @override
  @JsonKey(name: 'traditions')
  List<String>? get traditions {
    final value = _traditions;
    if (value == null) return null;
    if (_traditions is EqualUnmodifiableListView) return _traditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TribeEventModel(id: $id, title: $title, description: $description, date: $date, location: $location, imageUrl: $imageUrl, createdBy: $createdBy, attendeesCount: $attendeesCount, culturalType: $culturalType, traditions: $traditions, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TribeEventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.attendeesCount, attendeesCount) ||
                other.attendeesCount == attendeesCount) &&
            (identical(other.culturalType, culturalType) ||
                other.culturalType == culturalType) &&
            const DeepCollectionEquality()
                .equals(other._traditions, _traditions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      date,
      location,
      imageUrl,
      createdBy,
      attendeesCount,
      culturalType,
      const DeepCollectionEquality().hash(_traditions),
      createdAt);

  /// Create a copy of TribeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TribeEventModelImplCopyWith<_$TribeEventModelImpl> get copyWith =>
      __$$TribeEventModelImplCopyWithImpl<_$TribeEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TribeEventModelImplToJson(
      this,
    );
  }
}

abstract class _TribeEventModel implements TribeEventModel {
  const factory _TribeEventModel(
          {required final String id,
          required final String title,
          required final String description,
          required final DateTime date,
          required final String location,
          @JsonKey(name: 'image_url') final String? imageUrl,
          @JsonKey(name: 'created_by') required final String createdBy,
          @JsonKey(name: 'attendees_count') required final int attendeesCount,
          @JsonKey(name: 'cultural_type') final String? culturalType,
          @JsonKey(name: 'traditions') final List<String>? traditions,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$TribeEventModelImpl;

  factory _TribeEventModel.fromJson(Map<String, dynamic> json) =
      _$TribeEventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get date;
  @override
  String get location;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'attendees_count')
  int get attendeesCount;
  @override
  @JsonKey(name: 'cultural_type')
  String? get culturalType;
  @override
  @JsonKey(name: 'traditions')
  List<String>? get traditions;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of TribeEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TribeEventModelImplCopyWith<_$TribeEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TribeVoteModel _$TribeVoteModelFromJson(Map<String, dynamic> json) {
  return _TribeVoteModel.fromJson(json);
}

/// @nodoc
mixin _$TribeVoteModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tribe_id')
  String get tribeId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'options')
  List<VoteOptionModel> get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TribeVoteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TribeVoteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TribeVoteModelCopyWith<TribeVoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TribeVoteModelCopyWith<$Res> {
  factory $TribeVoteModelCopyWith(
          TribeVoteModel value, $Res Function(TribeVoteModel) then) =
      _$TribeVoteModelCopyWithImpl<$Res, TribeVoteModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'tribe_id') String tribeId,
      String title,
      String description,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'options') List<VoteOptionModel> options,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$TribeVoteModelCopyWithImpl<$Res, $Val extends TribeVoteModel>
    implements $TribeVoteModelCopyWith<$Res> {
  _$TribeVoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TribeVoteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tribeId = null,
    Object? title = null,
    Object? description = null,
    Object? createdBy = null,
    Object? options = null,
    Object? endsAt = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tribeId: null == tribeId
          ? _value.tribeId
          : tribeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<VoteOptionModel>,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TribeVoteModelImplCopyWith<$Res>
    implements $TribeVoteModelCopyWith<$Res> {
  factory _$$TribeVoteModelImplCopyWith(_$TribeVoteModelImpl value,
          $Res Function(_$TribeVoteModelImpl) then) =
      __$$TribeVoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'tribe_id') String tribeId,
      String title,
      String description,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'options') List<VoteOptionModel> options,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$TribeVoteModelImplCopyWithImpl<$Res>
    extends _$TribeVoteModelCopyWithImpl<$Res, _$TribeVoteModelImpl>
    implements _$$TribeVoteModelImplCopyWith<$Res> {
  __$$TribeVoteModelImplCopyWithImpl(
      _$TribeVoteModelImpl _value, $Res Function(_$TribeVoteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TribeVoteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tribeId = null,
    Object? title = null,
    Object? description = null,
    Object? createdBy = null,
    Object? options = null,
    Object? endsAt = null,
    Object? createdAt = null,
  }) {
    return _then(_$TribeVoteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tribeId: null == tribeId
          ? _value.tribeId
          : tribeId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<VoteOptionModel>,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TribeVoteModelImpl implements _TribeVoteModel {
  const _$TribeVoteModelImpl(
      {required this.id,
      @JsonKey(name: 'tribe_id') required this.tribeId,
      required this.title,
      required this.description,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'options') required final List<VoteOptionModel> options,
      @JsonKey(name: 'ends_at') required this.endsAt,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _options = options;

  factory _$TribeVoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TribeVoteModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'tribe_id')
  final String tribeId;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  final List<VoteOptionModel> _options;
  @override
  @JsonKey(name: 'options')
  List<VoteOptionModel> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey(name: 'ends_at')
  final DateTime endsAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TribeVoteModel(id: $id, tribeId: $tribeId, title: $title, description: $description, createdBy: $createdBy, options: $options, endsAt: $endsAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TribeVoteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tribeId, tribeId) || other.tribeId == tribeId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tribeId,
      title,
      description,
      createdBy,
      const DeepCollectionEquality().hash(_options),
      endsAt,
      createdAt);

  /// Create a copy of TribeVoteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TribeVoteModelImplCopyWith<_$TribeVoteModelImpl> get copyWith =>
      __$$TribeVoteModelImplCopyWithImpl<_$TribeVoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TribeVoteModelImplToJson(
      this,
    );
  }
}

abstract class _TribeVoteModel implements TribeVoteModel {
  const factory _TribeVoteModel(
      {required final String id,
      @JsonKey(name: 'tribe_id') required final String tribeId,
      required final String title,
      required final String description,
      @JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'options') required final List<VoteOptionModel> options,
      @JsonKey(name: 'ends_at') required final DateTime endsAt,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$TribeVoteModelImpl;

  factory _TribeVoteModel.fromJson(Map<String, dynamic> json) =
      _$TribeVoteModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'tribe_id')
  String get tribeId;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'options')
  List<VoteOptionModel> get options;
  @override
  @JsonKey(name: 'ends_at')
  DateTime get endsAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of TribeVoteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TribeVoteModelImplCopyWith<_$TribeVoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoteOptionModel _$VoteOptionModelFromJson(Map<String, dynamic> json) {
  return _VoteOptionModel.fromJson(json);
}

/// @nodoc
mixin _$VoteOptionModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'votes_count')
  int get votesCount => throw _privateConstructorUsedError;

  /// Serializes this VoteOptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoteOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteOptionModelCopyWith<VoteOptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteOptionModelCopyWith<$Res> {
  factory $VoteOptionModelCopyWith(
          VoteOptionModel value, $Res Function(VoteOptionModel) then) =
      _$VoteOptionModelCopyWithImpl<$Res, VoteOptionModel>;
  @useResult
  $Res call(
      {String id, String text, @JsonKey(name: 'votes_count') int votesCount});
}

/// @nodoc
class _$VoteOptionModelCopyWithImpl<$Res, $Val extends VoteOptionModel>
    implements $VoteOptionModelCopyWith<$Res> {
  _$VoteOptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? votesCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      votesCount: null == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteOptionModelImplCopyWith<$Res>
    implements $VoteOptionModelCopyWith<$Res> {
  factory _$$VoteOptionModelImplCopyWith(_$VoteOptionModelImpl value,
          $Res Function(_$VoteOptionModelImpl) then) =
      __$$VoteOptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String text, @JsonKey(name: 'votes_count') int votesCount});
}

/// @nodoc
class __$$VoteOptionModelImplCopyWithImpl<$Res>
    extends _$VoteOptionModelCopyWithImpl<$Res, _$VoteOptionModelImpl>
    implements _$$VoteOptionModelImplCopyWith<$Res> {
  __$$VoteOptionModelImplCopyWithImpl(
      _$VoteOptionModelImpl _value, $Res Function(_$VoteOptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? votesCount = null,
  }) {
    return _then(_$VoteOptionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      votesCount: null == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteOptionModelImpl implements _VoteOptionModel {
  const _$VoteOptionModelImpl(
      {required this.id,
      required this.text,
      @JsonKey(name: 'votes_count') required this.votesCount});

  factory _$VoteOptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteOptionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  @JsonKey(name: 'votes_count')
  final int votesCount;

  @override
  String toString() {
    return 'VoteOptionModel(id: $id, text: $text, votesCount: $votesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteOptionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.votesCount, votesCount) ||
                other.votesCount == votesCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, votesCount);

  /// Create a copy of VoteOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteOptionModelImplCopyWith<_$VoteOptionModelImpl> get copyWith =>
      __$$VoteOptionModelImplCopyWithImpl<_$VoteOptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteOptionModelImplToJson(
      this,
    );
  }
}

abstract class _VoteOptionModel implements VoteOptionModel {
  const factory _VoteOptionModel(
          {required final String id,
          required final String text,
          @JsonKey(name: 'votes_count') required final int votesCount}) =
      _$VoteOptionModelImpl;

  factory _VoteOptionModel.fromJson(Map<String, dynamic> json) =
      _$VoteOptionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  @JsonKey(name: 'votes_count')
  int get votesCount;

  /// Create a copy of VoteOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteOptionModelImplCopyWith<_$VoteOptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
