// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CulturalEventModel _$CulturalEventModelFromJson(Map<String, dynamic> json) {
  return _CulturalEventModel.fromJson(json);
}

/// @nodoc
mixin _$CulturalEventModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type')
  String get eventType => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendees_count')
  int get attendeesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_attendees')
  int? get maxAttendees => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_significance')
  String? get culturalSignificance => throw _privateConstructorUsedError;
  @JsonKey(name: 'traditions')
  List<String>? get traditions => throw _privateConstructorUsedError;
  @JsonKey(name: 'required_dress_code')
  String? get requiredDressCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_preferences')
  List<String>? get foodPreferences => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool get isPrivate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CulturalEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CulturalEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CulturalEventModelCopyWith<CulturalEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CulturalEventModelCopyWith<$Res> {
  factory $CulturalEventModelCopyWith(
          CulturalEventModel value, $Res Function(CulturalEventModel) then) =
      _$CulturalEventModelCopyWithImpl<$Res, CulturalEventModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @JsonKey(name: 'event_type') String eventType,
      DateTime date,
      String location,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'attendees_count') int attendeesCount,
      @JsonKey(name: 'max_attendees') int? maxAttendees,
      @JsonKey(name: 'cultural_significance') String? culturalSignificance,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'required_dress_code') String? requiredDressCode,
      @JsonKey(name: 'food_preferences') List<String>? foodPreferences,
      @JsonKey(name: 'is_private') bool isPrivate,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$CulturalEventModelCopyWithImpl<$Res, $Val extends CulturalEventModel>
    implements $CulturalEventModelCopyWith<$Res> {
  _$CulturalEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CulturalEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? eventType = null,
    Object? date = null,
    Object? location = null,
    Object? imageUrl = freezed,
    Object? createdBy = null,
    Object? attendeesCount = null,
    Object? maxAttendees = freezed,
    Object? culturalSignificance = freezed,
    Object? traditions = freezed,
    Object? requiredDressCode = freezed,
    Object? foodPreferences = freezed,
    Object? isPrivate = null,
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
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
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
      maxAttendees: freezed == maxAttendees
          ? _value.maxAttendees
          : maxAttendees // ignore: cast_nullable_to_non_nullable
              as int?,
      culturalSignificance: freezed == culturalSignificance
          ? _value.culturalSignificance
          : culturalSignificance // ignore: cast_nullable_to_non_nullable
              as String?,
      traditions: freezed == traditions
          ? _value.traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requiredDressCode: freezed == requiredDressCode
          ? _value.requiredDressCode
          : requiredDressCode // ignore: cast_nullable_to_non_nullable
              as String?,
      foodPreferences: freezed == foodPreferences
          ? _value.foodPreferences
          : foodPreferences // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CulturalEventModelImplCopyWith<$Res>
    implements $CulturalEventModelCopyWith<$Res> {
  factory _$$CulturalEventModelImplCopyWith(_$CulturalEventModelImpl value,
          $Res Function(_$CulturalEventModelImpl) then) =
      __$$CulturalEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @JsonKey(name: 'event_type') String eventType,
      DateTime date,
      String location,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'attendees_count') int attendeesCount,
      @JsonKey(name: 'max_attendees') int? maxAttendees,
      @JsonKey(name: 'cultural_significance') String? culturalSignificance,
      @JsonKey(name: 'traditions') List<String>? traditions,
      @JsonKey(name: 'required_dress_code') String? requiredDressCode,
      @JsonKey(name: 'food_preferences') List<String>? foodPreferences,
      @JsonKey(name: 'is_private') bool isPrivate,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$CulturalEventModelImplCopyWithImpl<$Res>
    extends _$CulturalEventModelCopyWithImpl<$Res, _$CulturalEventModelImpl>
    implements _$$CulturalEventModelImplCopyWith<$Res> {
  __$$CulturalEventModelImplCopyWithImpl(_$CulturalEventModelImpl _value,
      $Res Function(_$CulturalEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CulturalEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? eventType = null,
    Object? date = null,
    Object? location = null,
    Object? imageUrl = freezed,
    Object? createdBy = null,
    Object? attendeesCount = null,
    Object? maxAttendees = freezed,
    Object? culturalSignificance = freezed,
    Object? traditions = freezed,
    Object? requiredDressCode = freezed,
    Object? foodPreferences = freezed,
    Object? isPrivate = null,
    Object? createdAt = null,
  }) {
    return _then(_$CulturalEventModelImpl(
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
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
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
      maxAttendees: freezed == maxAttendees
          ? _value.maxAttendees
          : maxAttendees // ignore: cast_nullable_to_non_nullable
              as int?,
      culturalSignificance: freezed == culturalSignificance
          ? _value.culturalSignificance
          : culturalSignificance // ignore: cast_nullable_to_non_nullable
              as String?,
      traditions: freezed == traditions
          ? _value._traditions
          : traditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requiredDressCode: freezed == requiredDressCode
          ? _value.requiredDressCode
          : requiredDressCode // ignore: cast_nullable_to_non_nullable
              as String?,
      foodPreferences: freezed == foodPreferences
          ? _value._foodPreferences
          : foodPreferences // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CulturalEventModelImpl implements _CulturalEventModel {
  const _$CulturalEventModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      @JsonKey(name: 'event_type') required this.eventType,
      required this.date,
      required this.location,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'attendees_count') required this.attendeesCount,
      @JsonKey(name: 'max_attendees') this.maxAttendees,
      @JsonKey(name: 'cultural_significance') this.culturalSignificance,
      @JsonKey(name: 'traditions') final List<String>? traditions,
      @JsonKey(name: 'required_dress_code') this.requiredDressCode,
      @JsonKey(name: 'food_preferences') final List<String>? foodPreferences,
      @JsonKey(name: 'is_private') required this.isPrivate,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _traditions = traditions,
        _foodPreferences = foodPreferences;

  factory _$CulturalEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CulturalEventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'event_type')
  final String eventType;
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
  @JsonKey(name: 'max_attendees')
  final int? maxAttendees;
  @override
  @JsonKey(name: 'cultural_significance')
  final String? culturalSignificance;
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
  @JsonKey(name: 'required_dress_code')
  final String? requiredDressCode;
  final List<String>? _foodPreferences;
  @override
  @JsonKey(name: 'food_preferences')
  List<String>? get foodPreferences {
    final value = _foodPreferences;
    if (value == null) return null;
    if (_foodPreferences is EqualUnmodifiableListView) return _foodPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'CulturalEventModel(id: $id, title: $title, description: $description, eventType: $eventType, date: $date, location: $location, imageUrl: $imageUrl, createdBy: $createdBy, attendeesCount: $attendeesCount, maxAttendees: $maxAttendees, culturalSignificance: $culturalSignificance, traditions: $traditions, requiredDressCode: $requiredDressCode, foodPreferences: $foodPreferences, isPrivate: $isPrivate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CulturalEventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.attendeesCount, attendeesCount) ||
                other.attendeesCount == attendeesCount) &&
            (identical(other.maxAttendees, maxAttendees) ||
                other.maxAttendees == maxAttendees) &&
            (identical(other.culturalSignificance, culturalSignificance) ||
                other.culturalSignificance == culturalSignificance) &&
            const DeepCollectionEquality()
                .equals(other._traditions, _traditions) &&
            (identical(other.requiredDressCode, requiredDressCode) ||
                other.requiredDressCode == requiredDressCode) &&
            const DeepCollectionEquality()
                .equals(other._foodPreferences, _foodPreferences) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
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
      eventType,
      date,
      location,
      imageUrl,
      createdBy,
      attendeesCount,
      maxAttendees,
      culturalSignificance,
      const DeepCollectionEquality().hash(_traditions),
      requiredDressCode,
      const DeepCollectionEquality().hash(_foodPreferences),
      isPrivate,
      createdAt);

  /// Create a copy of CulturalEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CulturalEventModelImplCopyWith<_$CulturalEventModelImpl> get copyWith =>
      __$$CulturalEventModelImplCopyWithImpl<_$CulturalEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CulturalEventModelImplToJson(
      this,
    );
  }
}

abstract class _CulturalEventModel implements CulturalEventModel {
  const factory _CulturalEventModel(
      {required final String id,
      required final String title,
      required final String description,
      @JsonKey(name: 'event_type') required final String eventType,
      required final DateTime date,
      required final String location,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'attendees_count') required final int attendeesCount,
      @JsonKey(name: 'max_attendees') final int? maxAttendees,
      @JsonKey(name: 'cultural_significance')
      final String? culturalSignificance,
      @JsonKey(name: 'traditions') final List<String>? traditions,
      @JsonKey(name: 'required_dress_code') final String? requiredDressCode,
      @JsonKey(name: 'food_preferences') final List<String>? foodPreferences,
      @JsonKey(name: 'is_private') required final bool isPrivate,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$CulturalEventModelImpl;

  factory _CulturalEventModel.fromJson(Map<String, dynamic> json) =
      _$CulturalEventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'event_type')
  String get eventType;
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
  @JsonKey(name: 'max_attendees')
  int? get maxAttendees;
  @override
  @JsonKey(name: 'cultural_significance')
  String? get culturalSignificance;
  @override
  @JsonKey(name: 'traditions')
  List<String>? get traditions;
  @override
  @JsonKey(name: 'required_dress_code')
  String? get requiredDressCode;
  @override
  @JsonKey(name: 'food_preferences')
  List<String>? get foodPreferences;
  @override
  @JsonKey(name: 'is_private')
  bool get isPrivate;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of CulturalEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CulturalEventModelImplCopyWith<_$CulturalEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventAttendeeModel _$EventAttendeeModelFromJson(Map<String, dynamic> json) {
  return _EventAttendeeModel.fromJson(json);
}

/// @nodoc
mixin _$EventAttendeeModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // going, maybe, not_going
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EventAttendeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventAttendeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventAttendeeModelCopyWith<EventAttendeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventAttendeeModelCopyWith<$Res> {
  factory $EventAttendeeModelCopyWith(
          EventAttendeeModel value, $Res Function(EventAttendeeModel) then) =
      _$EventAttendeeModelCopyWithImpl<$Res, EventAttendeeModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      String status,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$EventAttendeeModelCopyWithImpl<$Res, $Val extends EventAttendeeModel>
    implements $EventAttendeeModelCopyWith<$Res> {
  _$EventAttendeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventAttendeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventAttendeeModelImplCopyWith<$Res>
    implements $EventAttendeeModelCopyWith<$Res> {
  factory _$$EventAttendeeModelImplCopyWith(_$EventAttendeeModelImpl value,
          $Res Function(_$EventAttendeeModelImpl) then) =
      __$$EventAttendeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      String status,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$EventAttendeeModelImplCopyWithImpl<$Res>
    extends _$EventAttendeeModelCopyWithImpl<$Res, _$EventAttendeeModelImpl>
    implements _$$EventAttendeeModelImplCopyWith<$Res> {
  __$$EventAttendeeModelImplCopyWithImpl(_$EventAttendeeModelImpl _value,
      $Res Function(_$EventAttendeeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventAttendeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$EventAttendeeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$EventAttendeeModelImpl implements _EventAttendeeModel {
  const _$EventAttendeeModelImpl(
      {required this.id,
      @JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.status,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$EventAttendeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventAttendeeModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'event_id')
  final String eventId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String status;
// going, maybe, not_going
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'EventAttendeeModel(id: $id, eventId: $eventId, userId: $userId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventAttendeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, eventId, userId, status, createdAt);

  /// Create a copy of EventAttendeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventAttendeeModelImplCopyWith<_$EventAttendeeModelImpl> get copyWith =>
      __$$EventAttendeeModelImplCopyWithImpl<_$EventAttendeeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventAttendeeModelImplToJson(
      this,
    );
  }
}

abstract class _EventAttendeeModel implements EventAttendeeModel {
  const factory _EventAttendeeModel(
          {required final String id,
          @JsonKey(name: 'event_id') required final String eventId,
          @JsonKey(name: 'user_id') required final String userId,
          required final String status,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$EventAttendeeModelImpl;

  factory _EventAttendeeModel.fromJson(Map<String, dynamic> json) =
      _$EventAttendeeModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'event_id')
  String get eventId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get status; // going, maybe, not_going
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of EventAttendeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventAttendeeModelImplCopyWith<_$EventAttendeeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventCommentModel _$EventCommentModelFromJson(Map<String, dynamic> json) {
  return _EventCommentModel.fromJson(json);
}

/// @nodoc
mixin _$EventCommentModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EventCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCommentModelCopyWith<EventCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCommentModelCopyWith<$Res> {
  factory $EventCommentModelCopyWith(
          EventCommentModel value, $Res Function(EventCommentModel) then) =
      _$EventCommentModelCopyWithImpl<$Res, EventCommentModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      String text,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$EventCommentModelCopyWithImpl<$Res, $Val extends EventCommentModel>
    implements $EventCommentModelCopyWith<$Res> {
  _$EventCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EventCommentModelImplCopyWith<$Res>
    implements $EventCommentModelCopyWith<$Res> {
  factory _$$EventCommentModelImplCopyWith(_$EventCommentModelImpl value,
          $Res Function(_$EventCommentModelImpl) then) =
      __$$EventCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      String text,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$EventCommentModelImplCopyWithImpl<$Res>
    extends _$EventCommentModelCopyWithImpl<$Res, _$EventCommentModelImpl>
    implements _$$EventCommentModelImplCopyWith<$Res> {
  __$$EventCommentModelImplCopyWithImpl(_$EventCommentModelImpl _value,
      $Res Function(_$EventCommentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_$EventCommentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
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
class _$EventCommentModelImpl implements _EventCommentModel {
  const _$EventCommentModelImpl(
      {required this.id,
      @JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.text,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$EventCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventCommentModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'event_id')
  final String eventId;
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
    return 'EventCommentModel(id: $id, eventId: $eventId, userId: $userId, text: $text, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, eventId, userId, text, createdAt);

  /// Create a copy of EventCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventCommentModelImplCopyWith<_$EventCommentModelImpl> get copyWith =>
      __$$EventCommentModelImplCopyWithImpl<_$EventCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventCommentModelImplToJson(
      this,
    );
  }
}

abstract class _EventCommentModel implements EventCommentModel {
  const factory _EventCommentModel(
          {required final String id,
          @JsonKey(name: 'event_id') required final String eventId,
          @JsonKey(name: 'user_id') required final String userId,
          required final String text,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$EventCommentModelImpl;

  factory _EventCommentModel.fromJson(Map<String, dynamic> json) =
      _$EventCommentModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'event_id')
  String get eventId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get text;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of EventCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventCommentModelImplCopyWith<_$EventCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventPhotoModel _$EventPhotoModelFromJson(Map<String, dynamic> json) {
  return _EventPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$EventPhotoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String get photoUrl => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EventPhotoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventPhotoModelCopyWith<EventPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventPhotoModelCopyWith<$Res> {
  factory $EventPhotoModelCopyWith(
          EventPhotoModel value, $Res Function(EventPhotoModel) then) =
      _$EventPhotoModelCopyWithImpl<$Res, EventPhotoModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'photo_url') String photoUrl,
      String? caption,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$EventPhotoModelCopyWithImpl<$Res, $Val extends EventPhotoModel>
    implements $EventPhotoModelCopyWith<$Res> {
  _$EventPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? photoUrl = null,
    Object? caption = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventPhotoModelImplCopyWith<$Res>
    implements $EventPhotoModelCopyWith<$Res> {
  factory _$$EventPhotoModelImplCopyWith(_$EventPhotoModelImpl value,
          $Res Function(_$EventPhotoModelImpl) then) =
      __$$EventPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'photo_url') String photoUrl,
      String? caption,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$EventPhotoModelImplCopyWithImpl<$Res>
    extends _$EventPhotoModelCopyWithImpl<$Res, _$EventPhotoModelImpl>
    implements _$$EventPhotoModelImplCopyWith<$Res> {
  __$$EventPhotoModelImplCopyWithImpl(
      _$EventPhotoModelImpl _value, $Res Function(_$EventPhotoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? photoUrl = null,
    Object? caption = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$EventPhotoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventPhotoModelImpl implements _EventPhotoModel {
  const _$EventPhotoModelImpl(
      {required this.id,
      @JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'photo_url') required this.photoUrl,
      this.caption,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$EventPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventPhotoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'event_id')
  final String eventId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'photo_url')
  final String photoUrl;
  @override
  final String? caption;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'EventPhotoModel(id: $id, eventId: $eventId, userId: $userId, photoUrl: $photoUrl, caption: $caption, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, eventId, userId, photoUrl, caption, createdAt);

  /// Create a copy of EventPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventPhotoModelImplCopyWith<_$EventPhotoModelImpl> get copyWith =>
      __$$EventPhotoModelImplCopyWithImpl<_$EventPhotoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventPhotoModelImplToJson(
      this,
    );
  }
}

abstract class _EventPhotoModel implements EventPhotoModel {
  const factory _EventPhotoModel(
          {required final String id,
          @JsonKey(name: 'event_id') required final String eventId,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'photo_url') required final String photoUrl,
          final String? caption,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$EventPhotoModelImpl;

  factory _EventPhotoModel.fromJson(Map<String, dynamic> json) =
      _$EventPhotoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'event_id')
  String get eventId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'photo_url')
  String get photoUrl;
  @override
  String? get caption;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of EventPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventPhotoModelImplCopyWith<_$EventPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
