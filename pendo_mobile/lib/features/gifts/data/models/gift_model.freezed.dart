// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GiftModel _$GiftModelFromJson(Map<String, dynamic> json) {
  return _GiftModel.fromJson(json);
}

/// @nodoc
mixin _$GiftModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  bool get isAnimated => throw _privateConstructorUsedError;
  String? get animationUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GiftModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftModelCopyWith<GiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftModelCopyWith<$Res> {
  factory $GiftModelCopyWith(GiftModel value, $Res Function(GiftModel) then) =
      _$GiftModelCopyWithImpl<$Res, GiftModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      int coins,
      bool isAnimated,
      String? animationUrl,
      Map<String, dynamic> metadata,
      DateTime createdAt});
}

/// @nodoc
class _$GiftModelCopyWithImpl<$Res, $Val extends GiftModel>
    implements $GiftModelCopyWith<$Res> {
  _$GiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? coins = null,
    Object? isAnimated = null,
    Object? animationUrl = freezed,
    Object? metadata = null,
    Object? createdAt = null,
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
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
      animationUrl: freezed == animationUrl
          ? _value.animationUrl
          : animationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftModelImplCopyWith<$Res>
    implements $GiftModelCopyWith<$Res> {
  factory _$$GiftModelImplCopyWith(
          _$GiftModelImpl value, $Res Function(_$GiftModelImpl) then) =
      __$$GiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      int coins,
      bool isAnimated,
      String? animationUrl,
      Map<String, dynamic> metadata,
      DateTime createdAt});
}

/// @nodoc
class __$$GiftModelImplCopyWithImpl<$Res>
    extends _$GiftModelCopyWithImpl<$Res, _$GiftModelImpl>
    implements _$$GiftModelImplCopyWith<$Res> {
  __$$GiftModelImplCopyWithImpl(
      _$GiftModelImpl _value, $Res Function(_$GiftModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? coins = null,
    Object? isAnimated = null,
    Object? animationUrl = freezed,
    Object? metadata = null,
    Object? createdAt = null,
  }) {
    return _then(_$GiftModelImpl(
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
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
      animationUrl: freezed == animationUrl
          ? _value.animationUrl
          : animationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftModelImpl implements _GiftModel {
  const _$GiftModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.coins,
      required this.isAnimated,
      this.animationUrl,
      required final Map<String, dynamic> metadata,
      required this.createdAt})
      : _metadata = metadata;

  factory _$GiftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final int coins;
  @override
  final bool isAnimated;
  @override
  final String? animationUrl;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'GiftModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, coins: $coins, isAnimated: $isAnimated, animationUrl: $animationUrl, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.isAnimated, isAnimated) ||
                other.isAnimated == isAnimated) &&
            (identical(other.animationUrl, animationUrl) ||
                other.animationUrl == animationUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      coins,
      isAnimated,
      animationUrl,
      const DeepCollectionEquality().hash(_metadata),
      createdAt);

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftModelImplCopyWith<_$GiftModelImpl> get copyWith =>
      __$$GiftModelImplCopyWithImpl<_$GiftModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftModelImplToJson(
      this,
    );
  }
}

abstract class _GiftModel implements GiftModel {
  const factory _GiftModel(
      {required final String id,
      required final String name,
      required final String description,
      required final String imageUrl,
      required final int coins,
      required final bool isAnimated,
      final String? animationUrl,
      required final Map<String, dynamic> metadata,
      required final DateTime createdAt}) = _$GiftModelImpl;

  factory _GiftModel.fromJson(Map<String, dynamic> json) =
      _$GiftModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  int get coins;
  @override
  bool get isAnimated;
  @override
  String? get animationUrl;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime get createdAt;

  /// Create a copy of GiftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftModelImplCopyWith<_$GiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftTransactionModel _$GiftTransactionModelFromJson(Map<String, dynamic> json) {
  return _GiftTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$GiftTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get giftId => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;

  /// Serializes this GiftTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftTransactionModelCopyWith<GiftTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftTransactionModelCopyWith<$Res> {
  factory $GiftTransactionModelCopyWith(GiftTransactionModel value,
          $Res Function(GiftTransactionModel) then) =
      _$GiftTransactionModelCopyWithImpl<$Res, GiftTransactionModel>;
  @useResult
  $Res call(
      {String id,
      String senderId,
      String receiverId,
      String giftId,
      int coins,
      String? message,
      DateTime sentAt,
      bool isAnonymous});
}

/// @nodoc
class _$GiftTransactionModelCopyWithImpl<$Res,
        $Val extends GiftTransactionModel>
    implements $GiftTransactionModelCopyWith<$Res> {
  _$GiftTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? giftId = null,
    Object? coins = null,
    Object? message = freezed,
    Object? sentAt = null,
    Object? isAnonymous = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftTransactionModelImplCopyWith<$Res>
    implements $GiftTransactionModelCopyWith<$Res> {
  factory _$$GiftTransactionModelImplCopyWith(_$GiftTransactionModelImpl value,
          $Res Function(_$GiftTransactionModelImpl) then) =
      __$$GiftTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String senderId,
      String receiverId,
      String giftId,
      int coins,
      String? message,
      DateTime sentAt,
      bool isAnonymous});
}

/// @nodoc
class __$$GiftTransactionModelImplCopyWithImpl<$Res>
    extends _$GiftTransactionModelCopyWithImpl<$Res, _$GiftTransactionModelImpl>
    implements _$$GiftTransactionModelImplCopyWith<$Res> {
  __$$GiftTransactionModelImplCopyWithImpl(_$GiftTransactionModelImpl _value,
      $Res Function(_$GiftTransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? giftId = null,
    Object? coins = null,
    Object? message = freezed,
    Object? sentAt = null,
    Object? isAnonymous = null,
  }) {
    return _then(_$GiftTransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftTransactionModelImpl implements _GiftTransactionModel {
  const _$GiftTransactionModelImpl(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.giftId,
      required this.coins,
      this.message,
      required this.sentAt,
      required this.isAnonymous});

  factory _$GiftTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  final String giftId;
  @override
  final int coins;
  @override
  final String? message;
  @override
  final DateTime sentAt;
  @override
  final bool isAnonymous;

  @override
  String toString() {
    return 'GiftTransactionModel(id: $id, senderId: $senderId, receiverId: $receiverId, giftId: $giftId, coins: $coins, message: $message, sentAt: $sentAt, isAnonymous: $isAnonymous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.giftId, giftId) || other.giftId == giftId) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, senderId, receiverId, giftId,
      coins, message, sentAt, isAnonymous);

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftTransactionModelImplCopyWith<_$GiftTransactionModelImpl>
      get copyWith =>
          __$$GiftTransactionModelImplCopyWithImpl<_$GiftTransactionModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftTransactionModelImplToJson(
      this,
    );
  }
}

abstract class _GiftTransactionModel implements GiftTransactionModel {
  const factory _GiftTransactionModel(
      {required final String id,
      required final String senderId,
      required final String receiverId,
      required final String giftId,
      required final int coins,
      final String? message,
      required final DateTime sentAt,
      required final bool isAnonymous}) = _$GiftTransactionModelImpl;

  factory _GiftTransactionModel.fromJson(Map<String, dynamic> json) =
      _$GiftTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get receiverId;
  @override
  String get giftId;
  @override
  int get coins;
  @override
  String? get message;
  @override
  DateTime get sentAt;
  @override
  bool get isAnonymous;

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftTransactionModelImplCopyWith<_$GiftTransactionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GiftPackageModel _$GiftPackageModelFromJson(Map<String, dynamic> json) {
  return _GiftPackageModel.fromJson(json);
}

/// @nodoc
mixin _$GiftPackageModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  bool get isLimited => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this GiftPackageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftPackageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftPackageModelCopyWith<GiftPackageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftPackageModelCopyWith<$Res> {
  factory $GiftPackageModelCopyWith(
          GiftPackageModel value, $Res Function(GiftPackageModel) then) =
      _$GiftPackageModelCopyWithImpl<$Res, GiftPackageModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int coins,
      double price,
      String currency,
      bool isPopular,
      bool isLimited,
      DateTime? expiresAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$GiftPackageModelCopyWithImpl<$Res, $Val extends GiftPackageModel>
    implements $GiftPackageModelCopyWith<$Res> {
  _$GiftPackageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftPackageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? coins = null,
    Object? price = null,
    Object? currency = null,
    Object? isPopular = null,
    Object? isLimited = null,
    Object? expiresAt = freezed,
    Object? metadata = null,
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
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isLimited: null == isLimited
          ? _value.isLimited
          : isLimited // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftPackageModelImplCopyWith<$Res>
    implements $GiftPackageModelCopyWith<$Res> {
  factory _$$GiftPackageModelImplCopyWith(_$GiftPackageModelImpl value,
          $Res Function(_$GiftPackageModelImpl) then) =
      __$$GiftPackageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      int coins,
      double price,
      String currency,
      bool isPopular,
      bool isLimited,
      DateTime? expiresAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$GiftPackageModelImplCopyWithImpl<$Res>
    extends _$GiftPackageModelCopyWithImpl<$Res, _$GiftPackageModelImpl>
    implements _$$GiftPackageModelImplCopyWith<$Res> {
  __$$GiftPackageModelImplCopyWithImpl(_$GiftPackageModelImpl _value,
      $Res Function(_$GiftPackageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftPackageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? coins = null,
    Object? price = null,
    Object? currency = null,
    Object? isPopular = null,
    Object? isLimited = null,
    Object? expiresAt = freezed,
    Object? metadata = null,
  }) {
    return _then(_$GiftPackageModelImpl(
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
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isLimited: null == isLimited
          ? _value.isLimited
          : isLimited // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftPackageModelImpl implements _GiftPackageModel {
  const _$GiftPackageModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.coins,
      required this.price,
      required this.currency,
      required this.isPopular,
      required this.isLimited,
      this.expiresAt,
      required final Map<String, dynamic> metadata})
      : _metadata = metadata;

  factory _$GiftPackageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftPackageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int coins;
  @override
  final double price;
  @override
  final String currency;
  @override
  final bool isPopular;
  @override
  final bool isLimited;
  @override
  final DateTime? expiresAt;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'GiftPackageModel(id: $id, name: $name, description: $description, coins: $coins, price: $price, currency: $currency, isPopular: $isPopular, isLimited: $isLimited, expiresAt: $expiresAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftPackageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.isLimited, isLimited) ||
                other.isLimited == isLimited) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      coins,
      price,
      currency,
      isPopular,
      isLimited,
      expiresAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of GiftPackageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftPackageModelImplCopyWith<_$GiftPackageModelImpl> get copyWith =>
      __$$GiftPackageModelImplCopyWithImpl<_$GiftPackageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftPackageModelImplToJson(
      this,
    );
  }
}

abstract class _GiftPackageModel implements GiftPackageModel {
  const factory _GiftPackageModel(
      {required final String id,
      required final String name,
      required final String description,
      required final int coins,
      required final double price,
      required final String currency,
      required final bool isPopular,
      required final bool isLimited,
      final DateTime? expiresAt,
      required final Map<String, dynamic> metadata}) = _$GiftPackageModelImpl;

  factory _GiftPackageModel.fromJson(Map<String, dynamic> json) =
      _$GiftPackageModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get coins;
  @override
  double get price;
  @override
  String get currency;
  @override
  bool get isPopular;
  @override
  bool get isLimited;
  @override
  DateTime? get expiresAt;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of GiftPackageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftPackageModelImplCopyWith<_$GiftPackageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
