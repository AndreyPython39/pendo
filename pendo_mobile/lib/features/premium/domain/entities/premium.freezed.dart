// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PremiumSubscriptionModel _$PremiumSubscriptionModelFromJson(
    Map<String, dynamic> json) {
  return _PremiumSubscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$PremiumSubscriptionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get plan => throw _privateConstructorUsedError; // monthly, annual
  @JsonKey(name: 'starts_at')
  DateTime get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_renew')
  bool get autoRenew => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this PremiumSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PremiumSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PremiumSubscriptionModelCopyWith<PremiumSubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumSubscriptionModelCopyWith<$Res> {
  factory $PremiumSubscriptionModelCopyWith(PremiumSubscriptionModel value,
          $Res Function(PremiumSubscriptionModel) then) =
      _$PremiumSubscriptionModelCopyWithImpl<$Res, PremiumSubscriptionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String plan,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'auto_renew') bool autoRenew,
      @JsonKey(name: 'payment_method') String paymentMethod});
}

/// @nodoc
class _$PremiumSubscriptionModelCopyWithImpl<$Res,
        $Val extends PremiumSubscriptionModel>
    implements $PremiumSubscriptionModelCopyWith<$Res> {
  _$PremiumSubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? plan = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isActive = null,
    Object? autoRenew = null,
    Object? paymentMethod = null,
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
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PremiumSubscriptionModelImplCopyWith<$Res>
    implements $PremiumSubscriptionModelCopyWith<$Res> {
  factory _$$PremiumSubscriptionModelImplCopyWith(
          _$PremiumSubscriptionModelImpl value,
          $Res Function(_$PremiumSubscriptionModelImpl) then) =
      __$$PremiumSubscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String plan,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'auto_renew') bool autoRenew,
      @JsonKey(name: 'payment_method') String paymentMethod});
}

/// @nodoc
class __$$PremiumSubscriptionModelImplCopyWithImpl<$Res>
    extends _$PremiumSubscriptionModelCopyWithImpl<$Res,
        _$PremiumSubscriptionModelImpl>
    implements _$$PremiumSubscriptionModelImplCopyWith<$Res> {
  __$$PremiumSubscriptionModelImplCopyWithImpl(
      _$PremiumSubscriptionModelImpl _value,
      $Res Function(_$PremiumSubscriptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? plan = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isActive = null,
    Object? autoRenew = null,
    Object? paymentMethod = null,
  }) {
    return _then(_$PremiumSubscriptionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PremiumSubscriptionModelImpl implements _PremiumSubscriptionModel {
  const _$PremiumSubscriptionModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.plan,
      @JsonKey(name: 'starts_at') required this.startsAt,
      @JsonKey(name: 'ends_at') required this.endsAt,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'auto_renew') required this.autoRenew,
      @JsonKey(name: 'payment_method') required this.paymentMethod});

  factory _$PremiumSubscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PremiumSubscriptionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String plan;
// monthly, annual
  @override
  @JsonKey(name: 'starts_at')
  final DateTime startsAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime endsAt;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'auto_renew')
  final bool autoRenew;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  @override
  String toString() {
    return 'PremiumSubscriptionModel(id: $id, userId: $userId, plan: $plan, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive, autoRenew: $autoRenew, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumSubscriptionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, plan, startsAt,
      endsAt, isActive, autoRenew, paymentMethod);

  /// Create a copy of PremiumSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumSubscriptionModelImplCopyWith<_$PremiumSubscriptionModelImpl>
      get copyWith => __$$PremiumSubscriptionModelImplCopyWithImpl<
          _$PremiumSubscriptionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PremiumSubscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _PremiumSubscriptionModel implements PremiumSubscriptionModel {
  const factory _PremiumSubscriptionModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      required final String plan,
      @JsonKey(name: 'starts_at') required final DateTime startsAt,
      @JsonKey(name: 'ends_at') required final DateTime endsAt,
      @JsonKey(name: 'is_active') required final bool isActive,
      @JsonKey(name: 'auto_renew') required final bool autoRenew,
      @JsonKey(name: 'payment_method')
      required final String paymentMethod}) = _$PremiumSubscriptionModelImpl;

  factory _PremiumSubscriptionModel.fromJson(Map<String, dynamic> json) =
      _$PremiumSubscriptionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get plan; // monthly, annual
  @override
  @JsonKey(name: 'starts_at')
  DateTime get startsAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime get endsAt;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'auto_renew')
  bool get autoRenew;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;

  /// Create a copy of PremiumSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PremiumSubscriptionModelImplCopyWith<_$PremiumSubscriptionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BoostModel _$BoostModelFromJson(Map<String, dynamic> json) {
  return _BoostModel.fromJson(json);
}

/// @nodoc
mixin _$BoostModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // standard, super
  @JsonKey(name: 'starts_at')
  DateTime get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'boost_multiplier')
  double get boostMultiplier => throw _privateConstructorUsedError;

  /// Serializes this BoostModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoostModelCopyWith<BoostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoostModelCopyWith<$Res> {
  factory $BoostModelCopyWith(
          BoostModel value, $Res Function(BoostModel) then) =
      _$BoostModelCopyWithImpl<$Res, BoostModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'boost_multiplier') double boostMultiplier});
}

/// @nodoc
class _$BoostModelCopyWithImpl<$Res, $Val extends BoostModel>
    implements $BoostModelCopyWith<$Res> {
  _$BoostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isActive = null,
    Object? boostMultiplier = null,
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
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      boostMultiplier: null == boostMultiplier
          ? _value.boostMultiplier
          : boostMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoostModelImplCopyWith<$Res>
    implements $BoostModelCopyWith<$Res> {
  factory _$$BoostModelImplCopyWith(
          _$BoostModelImpl value, $Res Function(_$BoostModelImpl) then) =
      __$$BoostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'boost_multiplier') double boostMultiplier});
}

/// @nodoc
class __$$BoostModelImplCopyWithImpl<$Res>
    extends _$BoostModelCopyWithImpl<$Res, _$BoostModelImpl>
    implements _$$BoostModelImplCopyWith<$Res> {
  __$$BoostModelImplCopyWithImpl(
      _$BoostModelImpl _value, $Res Function(_$BoostModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isActive = null,
    Object? boostMultiplier = null,
  }) {
    return _then(_$BoostModelImpl(
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
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      boostMultiplier: null == boostMultiplier
          ? _value.boostMultiplier
          : boostMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoostModelImpl implements _BoostModel {
  const _$BoostModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.type,
      @JsonKey(name: 'starts_at') required this.startsAt,
      @JsonKey(name: 'ends_at') required this.endsAt,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'boost_multiplier') required this.boostMultiplier});

  factory _$BoostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoostModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String type;
// standard, super
  @override
  @JsonKey(name: 'starts_at')
  final DateTime startsAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime endsAt;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'boost_multiplier')
  final double boostMultiplier;

  @override
  String toString() {
    return 'BoostModel(id: $id, userId: $userId, type: $type, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive, boostMultiplier: $boostMultiplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.boostMultiplier, boostMultiplier) ||
                other.boostMultiplier == boostMultiplier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, startsAt,
      endsAt, isActive, boostMultiplier);

  /// Create a copy of BoostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoostModelImplCopyWith<_$BoostModelImpl> get copyWith =>
      __$$BoostModelImplCopyWithImpl<_$BoostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoostModelImplToJson(
      this,
    );
  }
}

abstract class _BoostModel implements BoostModel {
  const factory _BoostModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      required final String type,
      @JsonKey(name: 'starts_at') required final DateTime startsAt,
      @JsonKey(name: 'ends_at') required final DateTime endsAt,
      @JsonKey(name: 'is_active') required final bool isActive,
      @JsonKey(name: 'boost_multiplier')
      required final double boostMultiplier}) = _$BoostModelImpl;

  factory _BoostModel.fromJson(Map<String, dynamic> json) =
      _$BoostModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get type; // standard, super
  @override
  @JsonKey(name: 'starts_at')
  DateTime get startsAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime get endsAt;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'boost_multiplier')
  double get boostMultiplier;

  /// Create a copy of BoostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoostModelImplCopyWith<_$BoostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PremiumFeatureModel _$PremiumFeatureModelFromJson(Map<String, dynamic> json) {
  return _PremiumFeatureModel.fromJson(json);
}

/// @nodoc
mixin _$PremiumFeatureModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'requires_subscription')
  bool get requiresSubscription => throw _privateConstructorUsedError;
  @JsonKey(name: 'feature_type')
  String get featureType => throw _privateConstructorUsedError;

  /// Serializes this PremiumFeatureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PremiumFeatureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PremiumFeatureModelCopyWith<PremiumFeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumFeatureModelCopyWith<$Res> {
  factory $PremiumFeatureModelCopyWith(
          PremiumFeatureModel value, $Res Function(PremiumFeatureModel) then) =
      _$PremiumFeatureModelCopyWithImpl<$Res, PremiumFeatureModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'is_enabled') bool isEnabled,
      @JsonKey(name: 'requires_subscription') bool requiresSubscription,
      @JsonKey(name: 'feature_type') String featureType});
}

/// @nodoc
class _$PremiumFeatureModelCopyWithImpl<$Res, $Val extends PremiumFeatureModel>
    implements $PremiumFeatureModelCopyWith<$Res> {
  _$PremiumFeatureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumFeatureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isEnabled = null,
    Object? requiresSubscription = null,
    Object? featureType = null,
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
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresSubscription: null == requiresSubscription
          ? _value.requiresSubscription
          : requiresSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
      featureType: null == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PremiumFeatureModelImplCopyWith<$Res>
    implements $PremiumFeatureModelCopyWith<$Res> {
  factory _$$PremiumFeatureModelImplCopyWith(_$PremiumFeatureModelImpl value,
          $Res Function(_$PremiumFeatureModelImpl) then) =
      __$$PremiumFeatureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'is_enabled') bool isEnabled,
      @JsonKey(name: 'requires_subscription') bool requiresSubscription,
      @JsonKey(name: 'feature_type') String featureType});
}

/// @nodoc
class __$$PremiumFeatureModelImplCopyWithImpl<$Res>
    extends _$PremiumFeatureModelCopyWithImpl<$Res, _$PremiumFeatureModelImpl>
    implements _$$PremiumFeatureModelImplCopyWith<$Res> {
  __$$PremiumFeatureModelImplCopyWithImpl(_$PremiumFeatureModelImpl _value,
      $Res Function(_$PremiumFeatureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumFeatureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isEnabled = null,
    Object? requiresSubscription = null,
    Object? featureType = null,
  }) {
    return _then(_$PremiumFeatureModelImpl(
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
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresSubscription: null == requiresSubscription
          ? _value.requiresSubscription
          : requiresSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
      featureType: null == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PremiumFeatureModelImpl implements _PremiumFeatureModel {
  const _$PremiumFeatureModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'is_enabled') required this.isEnabled,
      @JsonKey(name: 'requires_subscription')
      required this.requiresSubscription,
      @JsonKey(name: 'feature_type') required this.featureType});

  factory _$PremiumFeatureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PremiumFeatureModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;
  @override
  @JsonKey(name: 'requires_subscription')
  final bool requiresSubscription;
  @override
  @JsonKey(name: 'feature_type')
  final String featureType;

  @override
  String toString() {
    return 'PremiumFeatureModel(id: $id, name: $name, description: $description, isEnabled: $isEnabled, requiresSubscription: $requiresSubscription, featureType: $featureType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumFeatureModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.requiresSubscription, requiresSubscription) ||
                other.requiresSubscription == requiresSubscription) &&
            (identical(other.featureType, featureType) ||
                other.featureType == featureType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, isEnabled,
      requiresSubscription, featureType);

  /// Create a copy of PremiumFeatureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumFeatureModelImplCopyWith<_$PremiumFeatureModelImpl> get copyWith =>
      __$$PremiumFeatureModelImplCopyWithImpl<_$PremiumFeatureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PremiumFeatureModelImplToJson(
      this,
    );
  }
}

abstract class _PremiumFeatureModel implements PremiumFeatureModel {
  const factory _PremiumFeatureModel(
          {required final String id,
          required final String name,
          required final String description,
          @JsonKey(name: 'is_enabled') required final bool isEnabled,
          @JsonKey(name: 'requires_subscription')
          required final bool requiresSubscription,
          @JsonKey(name: 'feature_type') required final String featureType}) =
      _$PremiumFeatureModelImpl;

  factory _PremiumFeatureModel.fromJson(Map<String, dynamic> json) =
      _$PremiumFeatureModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'is_enabled')
  bool get isEnabled;
  @override
  @JsonKey(name: 'requires_subscription')
  bool get requiresSubscription;
  @override
  @JsonKey(name: 'feature_type')
  String get featureType;

  /// Create a copy of PremiumFeatureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PremiumFeatureModelImplCopyWith<_$PremiumFeatureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
