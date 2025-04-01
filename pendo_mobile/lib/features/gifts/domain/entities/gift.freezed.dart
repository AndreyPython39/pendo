// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VirtualGiftModel _$VirtualGiftModelFromJson(Map<String, dynamic> json) {
  return _VirtualGiftModel.fromJson(json);
}

/// @nodoc
mixin _$VirtualGiftModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'animation_url')
  String? get animationUrl => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_significance')
  String? get culturalSignificance => throw _privateConstructorUsedError;
  @JsonKey(name: 'cultural_category')
  String? get culturalCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_premium')
  bool get isPremium => throw _privateConstructorUsedError;

  /// Serializes this VirtualGiftModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VirtualGiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VirtualGiftModelCopyWith<VirtualGiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VirtualGiftModelCopyWith<$Res> {
  factory $VirtualGiftModelCopyWith(
          VirtualGiftModel value, $Res Function(VirtualGiftModel) then) =
      _$VirtualGiftModelCopyWithImpl<$Res, VirtualGiftModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'animation_url') String? animationUrl,
      int price,
      @JsonKey(name: 'cultural_significance') String? culturalSignificance,
      @JsonKey(name: 'cultural_category') String? culturalCategory,
      @JsonKey(name: 'is_premium') bool isPremium});
}

/// @nodoc
class _$VirtualGiftModelCopyWithImpl<$Res, $Val extends VirtualGiftModel>
    implements $VirtualGiftModelCopyWith<$Res> {
  _$VirtualGiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VirtualGiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? animationUrl = freezed,
    Object? price = null,
    Object? culturalSignificance = freezed,
    Object? culturalCategory = freezed,
    Object? isPremium = null,
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
      animationUrl: freezed == animationUrl
          ? _value.animationUrl
          : animationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      culturalSignificance: freezed == culturalSignificance
          ? _value.culturalSignificance
          : culturalSignificance // ignore: cast_nullable_to_non_nullable
              as String?,
      culturalCategory: freezed == culturalCategory
          ? _value.culturalCategory
          : culturalCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VirtualGiftModelImplCopyWith<$Res>
    implements $VirtualGiftModelCopyWith<$Res> {
  factory _$$VirtualGiftModelImplCopyWith(_$VirtualGiftModelImpl value,
          $Res Function(_$VirtualGiftModelImpl) then) =
      __$$VirtualGiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'animation_url') String? animationUrl,
      int price,
      @JsonKey(name: 'cultural_significance') String? culturalSignificance,
      @JsonKey(name: 'cultural_category') String? culturalCategory,
      @JsonKey(name: 'is_premium') bool isPremium});
}

/// @nodoc
class __$$VirtualGiftModelImplCopyWithImpl<$Res>
    extends _$VirtualGiftModelCopyWithImpl<$Res, _$VirtualGiftModelImpl>
    implements _$$VirtualGiftModelImplCopyWith<$Res> {
  __$$VirtualGiftModelImplCopyWithImpl(_$VirtualGiftModelImpl _value,
      $Res Function(_$VirtualGiftModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VirtualGiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? animationUrl = freezed,
    Object? price = null,
    Object? culturalSignificance = freezed,
    Object? culturalCategory = freezed,
    Object? isPremium = null,
  }) {
    return _then(_$VirtualGiftModelImpl(
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
      animationUrl: freezed == animationUrl
          ? _value.animationUrl
          : animationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      culturalSignificance: freezed == culturalSignificance
          ? _value.culturalSignificance
          : culturalSignificance // ignore: cast_nullable_to_non_nullable
              as String?,
      culturalCategory: freezed == culturalCategory
          ? _value.culturalCategory
          : culturalCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VirtualGiftModelImpl implements _VirtualGiftModel {
  const _$VirtualGiftModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @JsonKey(name: 'animation_url') this.animationUrl,
      required this.price,
      @JsonKey(name: 'cultural_significance') this.culturalSignificance,
      @JsonKey(name: 'cultural_category') this.culturalCategory,
      @JsonKey(name: 'is_premium') required this.isPremium});

  factory _$VirtualGiftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VirtualGiftModelImplFromJson(json);

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
  @JsonKey(name: 'animation_url')
  final String? animationUrl;
  @override
  final int price;
  @override
  @JsonKey(name: 'cultural_significance')
  final String? culturalSignificance;
  @override
  @JsonKey(name: 'cultural_category')
  final String? culturalCategory;
  @override
  @JsonKey(name: 'is_premium')
  final bool isPremium;

  @override
  String toString() {
    return 'VirtualGiftModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, animationUrl: $animationUrl, price: $price, culturalSignificance: $culturalSignificance, culturalCategory: $culturalCategory, isPremium: $isPremium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VirtualGiftModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.animationUrl, animationUrl) ||
                other.animationUrl == animationUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.culturalSignificance, culturalSignificance) ||
                other.culturalSignificance == culturalSignificance) &&
            (identical(other.culturalCategory, culturalCategory) ||
                other.culturalCategory == culturalCategory) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, imageUrl,
      animationUrl, price, culturalSignificance, culturalCategory, isPremium);

  /// Create a copy of VirtualGiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VirtualGiftModelImplCopyWith<_$VirtualGiftModelImpl> get copyWith =>
      __$$VirtualGiftModelImplCopyWithImpl<_$VirtualGiftModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VirtualGiftModelImplToJson(
      this,
    );
  }
}

abstract class _VirtualGiftModel implements VirtualGiftModel {
  const factory _VirtualGiftModel(
          {required final String id,
          required final String name,
          required final String description,
          @JsonKey(name: 'image_url') required final String imageUrl,
          @JsonKey(name: 'animation_url') final String? animationUrl,
          required final int price,
          @JsonKey(name: 'cultural_significance')
          final String? culturalSignificance,
          @JsonKey(name: 'cultural_category') final String? culturalCategory,
          @JsonKey(name: 'is_premium') required final bool isPremium}) =
      _$VirtualGiftModelImpl;

  factory _VirtualGiftModel.fromJson(Map<String, dynamic> json) =
      _$VirtualGiftModelImpl.fromJson;

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
  @JsonKey(name: 'animation_url')
  String? get animationUrl;
  @override
  int get price;
  @override
  @JsonKey(name: 'cultural_significance')
  String? get culturalSignificance;
  @override
  @JsonKey(name: 'cultural_category')
  String? get culturalCategory;
  @override
  @JsonKey(name: 'is_premium')
  bool get isPremium;

  /// Create a copy of VirtualGiftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VirtualGiftModelImplCopyWith<_$VirtualGiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftTransactionModel _$GiftTransactionModelFromJson(Map<String, dynamic> json) {
  return _GiftTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$GiftTransactionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'gift_id')
  String get giftId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String get receiverId => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'gift_id') String giftId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'receiver_id') String receiverId,
      String? message,
      int price,
      @JsonKey(name: 'created_at') DateTime createdAt});
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
    Object? giftId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? message = freezed,
    Object? price = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      @JsonKey(name: 'gift_id') String giftId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'receiver_id') String receiverId,
      String? message,
      int price,
      @JsonKey(name: 'created_at') DateTime createdAt});
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
    Object? giftId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? message = freezed,
    Object? price = null,
    Object? createdAt = null,
  }) {
    return _then(_$GiftTransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftTransactionModelImpl implements _GiftTransactionModel {
  const _$GiftTransactionModelImpl(
      {required this.id,
      @JsonKey(name: 'gift_id') required this.giftId,
      @JsonKey(name: 'sender_id') required this.senderId,
      @JsonKey(name: 'receiver_id') required this.receiverId,
      this.message,
      required this.price,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$GiftTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'gift_id')
  final String giftId;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  @override
  final String? message;
  @override
  final int price;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'GiftTransactionModel(id: $id, giftId: $giftId, senderId: $senderId, receiverId: $receiverId, message: $message, price: $price, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.giftId, giftId) || other.giftId == giftId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, giftId, senderId, receiverId, message, price, createdAt);

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
          @JsonKey(name: 'gift_id') required final String giftId,
          @JsonKey(name: 'sender_id') required final String senderId,
          @JsonKey(name: 'receiver_id') required final String receiverId,
          final String? message,
          required final int price,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$GiftTransactionModelImpl;

  factory _GiftTransactionModel.fromJson(Map<String, dynamic> json) =
      _$GiftTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'gift_id')
  String get giftId;
  @override
  @JsonKey(name: 'sender_id')
  String get senderId;
  @override
  @JsonKey(name: 'receiver_id')
  String get receiverId;
  @override
  String? get message;
  @override
  int get price;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of GiftTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftTransactionModelImplCopyWith<_$GiftTransactionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GiftCollectionModel _$GiftCollectionModelFromJson(Map<String, dynamic> json) {
  return _GiftCollectionModel.fromJson(json);
}

/// @nodoc
mixin _$GiftCollectionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'gift_id')
  String get giftId => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_received')
  DateTime get firstReceived => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_received')
  DateTime get lastReceived => throw _privateConstructorUsedError;

  /// Serializes this GiftCollectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftCollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftCollectionModelCopyWith<GiftCollectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftCollectionModelCopyWith<$Res> {
  factory $GiftCollectionModelCopyWith(
          GiftCollectionModel value, $Res Function(GiftCollectionModel) then) =
      _$GiftCollectionModelCopyWithImpl<$Res, GiftCollectionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'gift_id') String giftId,
      int count,
      @JsonKey(name: 'first_received') DateTime firstReceived,
      @JsonKey(name: 'last_received') DateTime lastReceived});
}

/// @nodoc
class _$GiftCollectionModelCopyWithImpl<$Res, $Val extends GiftCollectionModel>
    implements $GiftCollectionModelCopyWith<$Res> {
  _$GiftCollectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftCollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? giftId = null,
    Object? count = null,
    Object? firstReceived = null,
    Object? lastReceived = null,
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
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      firstReceived: null == firstReceived
          ? _value.firstReceived
          : firstReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastReceived: null == lastReceived
          ? _value.lastReceived
          : lastReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftCollectionModelImplCopyWith<$Res>
    implements $GiftCollectionModelCopyWith<$Res> {
  factory _$$GiftCollectionModelImplCopyWith(_$GiftCollectionModelImpl value,
          $Res Function(_$GiftCollectionModelImpl) then) =
      __$$GiftCollectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'gift_id') String giftId,
      int count,
      @JsonKey(name: 'first_received') DateTime firstReceived,
      @JsonKey(name: 'last_received') DateTime lastReceived});
}

/// @nodoc
class __$$GiftCollectionModelImplCopyWithImpl<$Res>
    extends _$GiftCollectionModelCopyWithImpl<$Res, _$GiftCollectionModelImpl>
    implements _$$GiftCollectionModelImplCopyWith<$Res> {
  __$$GiftCollectionModelImplCopyWithImpl(_$GiftCollectionModelImpl _value,
      $Res Function(_$GiftCollectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftCollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? giftId = null,
    Object? count = null,
    Object? firstReceived = null,
    Object? lastReceived = null,
  }) {
    return _then(_$GiftCollectionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      giftId: null == giftId
          ? _value.giftId
          : giftId // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      firstReceived: null == firstReceived
          ? _value.firstReceived
          : firstReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastReceived: null == lastReceived
          ? _value.lastReceived
          : lastReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftCollectionModelImpl implements _GiftCollectionModel {
  const _$GiftCollectionModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'gift_id') required this.giftId,
      required this.count,
      @JsonKey(name: 'first_received') required this.firstReceived,
      @JsonKey(name: 'last_received') required this.lastReceived});

  factory _$GiftCollectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftCollectionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'gift_id')
  final String giftId;
  @override
  final int count;
  @override
  @JsonKey(name: 'first_received')
  final DateTime firstReceived;
  @override
  @JsonKey(name: 'last_received')
  final DateTime lastReceived;

  @override
  String toString() {
    return 'GiftCollectionModel(id: $id, userId: $userId, giftId: $giftId, count: $count, firstReceived: $firstReceived, lastReceived: $lastReceived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftCollectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.giftId, giftId) || other.giftId == giftId) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.firstReceived, firstReceived) ||
                other.firstReceived == firstReceived) &&
            (identical(other.lastReceived, lastReceived) ||
                other.lastReceived == lastReceived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, giftId, count, firstReceived, lastReceived);

  /// Create a copy of GiftCollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftCollectionModelImplCopyWith<_$GiftCollectionModelImpl> get copyWith =>
      __$$GiftCollectionModelImplCopyWithImpl<_$GiftCollectionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftCollectionModelImplToJson(
      this,
    );
  }
}

abstract class _GiftCollectionModel implements GiftCollectionModel {
  const factory _GiftCollectionModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'gift_id') required final String giftId,
      required final int count,
      @JsonKey(name: 'first_received') required final DateTime firstReceived,
      @JsonKey(name: 'last_received')
      required final DateTime lastReceived}) = _$GiftCollectionModelImpl;

  factory _GiftCollectionModel.fromJson(Map<String, dynamic> json) =
      _$GiftCollectionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'gift_id')
  String get giftId;
  @override
  int get count;
  @override
  @JsonKey(name: 'first_received')
  DateTime get firstReceived;
  @override
  @JsonKey(name: 'last_received')
  DateTime get lastReceived;

  /// Create a copy of GiftCollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftCollectionModelImplCopyWith<_$GiftCollectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
