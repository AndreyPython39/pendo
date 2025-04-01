// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PremiumEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumEventCopyWith<$Res> {
  factory $PremiumEventCopyWith(
          PremiumEvent value, $Res Function(PremiumEvent) then) =
      _$PremiumEventCopyWithImpl<$Res, PremiumEvent>;
}

/// @nodoc
class _$PremiumEventCopyWithImpl<$Res, $Val extends PremiumEvent>
    implements $PremiumEventCopyWith<$Res> {
  _$PremiumEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSubscriptionsImplCopyWith<$Res> {
  factory _$$LoadSubscriptionsImplCopyWith(_$LoadSubscriptionsImpl value,
          $Res Function(_$LoadSubscriptionsImpl) then) =
      __$$LoadSubscriptionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSubscriptionsImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$LoadSubscriptionsImpl>
    implements _$$LoadSubscriptionsImplCopyWith<$Res> {
  __$$LoadSubscriptionsImplCopyWithImpl(_$LoadSubscriptionsImpl _value,
      $Res Function(_$LoadSubscriptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSubscriptionsImpl implements _LoadSubscriptions {
  const _$LoadSubscriptionsImpl();

  @override
  String toString() {
    return 'PremiumEvent.loadSubscriptions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSubscriptionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return loadSubscriptions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return loadSubscriptions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (loadSubscriptions != null) {
      return loadSubscriptions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return loadSubscriptions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return loadSubscriptions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (loadSubscriptions != null) {
      return loadSubscriptions(this);
    }
    return orElse();
  }
}

abstract class _LoadSubscriptions implements PremiumEvent {
  const factory _LoadSubscriptions() = _$LoadSubscriptionsImpl;
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
          _$PurchaseImpl value, $Res Function(_$PurchaseImpl) then) =
      __$$PurchaseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String subscriptionId});
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
      _$PurchaseImpl _value, $Res Function(_$PurchaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
  }) {
    return _then(_$PurchaseImpl(
      null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PurchaseImpl implements _Purchase {
  const _$PurchaseImpl(this.subscriptionId);

  @override
  final String subscriptionId;

  @override
  String toString() {
    return 'PremiumEvent.purchase(subscriptionId: $subscriptionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subscriptionId);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return purchase(subscriptionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return purchase?.call(subscriptionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (purchase != null) {
      return purchase(subscriptionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return purchase(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return purchase?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (purchase != null) {
      return purchase(this);
    }
    return orElse();
  }
}

abstract class _Purchase implements PremiumEvent {
  const factory _Purchase(final String subscriptionId) = _$PurchaseImpl;

  String get subscriptionId;

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelImplCopyWith<$Res> {
  factory _$$CancelImplCopyWith(
          _$CancelImpl value, $Res Function(_$CancelImpl) then) =
      __$$CancelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$CancelImpl>
    implements _$$CancelImplCopyWith<$Res> {
  __$$CancelImplCopyWithImpl(
      _$CancelImpl _value, $Res Function(_$CancelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelImpl implements _Cancel {
  const _$CancelImpl();

  @override
  String toString() {
    return 'PremiumEvent.cancel()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return cancel();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return cancel?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return cancel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return cancel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(this);
    }
    return orElse();
  }
}

abstract class _Cancel implements PremiumEvent {
  const factory _Cancel() = _$CancelImpl;
}

/// @nodoc
abstract class _$$RestoreImplCopyWith<$Res> {
  factory _$$RestoreImplCopyWith(
          _$RestoreImpl value, $Res Function(_$RestoreImpl) then) =
      __$$RestoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RestoreImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$RestoreImpl>
    implements _$$RestoreImplCopyWith<$Res> {
  __$$RestoreImplCopyWithImpl(
      _$RestoreImpl _value, $Res Function(_$RestoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RestoreImpl implements _Restore {
  const _$RestoreImpl();

  @override
  String toString() {
    return 'PremiumEvent.restore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RestoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return restore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return restore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (restore != null) {
      return restore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return restore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return restore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (restore != null) {
      return restore(this);
    }
    return orElse();
  }
}

abstract class _Restore implements PremiumEvent {
  const factory _Restore() = _$RestoreImpl;
}

/// @nodoc
abstract class _$$CheckFeatureImplCopyWith<$Res> {
  factory _$$CheckFeatureImplCopyWith(
          _$CheckFeatureImpl value, $Res Function(_$CheckFeatureImpl) then) =
      __$$CheckFeatureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String featureId});
}

/// @nodoc
class __$$CheckFeatureImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$CheckFeatureImpl>
    implements _$$CheckFeatureImplCopyWith<$Res> {
  __$$CheckFeatureImplCopyWithImpl(
      _$CheckFeatureImpl _value, $Res Function(_$CheckFeatureImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureId = null,
  }) {
    return _then(_$CheckFeatureImpl(
      null == featureId
          ? _value.featureId
          : featureId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckFeatureImpl implements _CheckFeature {
  const _$CheckFeatureImpl(this.featureId);

  @override
  final String featureId;

  @override
  String toString() {
    return 'PremiumEvent.checkFeature(featureId: $featureId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckFeatureImpl &&
            (identical(other.featureId, featureId) ||
                other.featureId == featureId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, featureId);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckFeatureImplCopyWith<_$CheckFeatureImpl> get copyWith =>
      __$$CheckFeatureImplCopyWithImpl<_$CheckFeatureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return checkFeature(featureId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return checkFeature?.call(featureId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (checkFeature != null) {
      return checkFeature(featureId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return checkFeature(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return checkFeature?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (checkFeature != null) {
      return checkFeature(this);
    }
    return orElse();
  }
}

abstract class _CheckFeature implements PremiumEvent {
  const factory _CheckFeature(final String featureId) = _$CheckFeatureImpl;

  String get featureId;

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckFeatureImplCopyWith<_$CheckFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadFeaturesImplCopyWith<$Res> {
  factory _$$LoadFeaturesImplCopyWith(
          _$LoadFeaturesImpl value, $Res Function(_$LoadFeaturesImpl) then) =
      __$$LoadFeaturesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFeaturesImplCopyWithImpl<$Res>
    extends _$PremiumEventCopyWithImpl<$Res, _$LoadFeaturesImpl>
    implements _$$LoadFeaturesImplCopyWith<$Res> {
  __$$LoadFeaturesImplCopyWithImpl(
      _$LoadFeaturesImpl _value, $Res Function(_$LoadFeaturesImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadFeaturesImpl implements _LoadFeatures {
  const _$LoadFeaturesImpl();

  @override
  String toString() {
    return 'PremiumEvent.loadFeatures()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFeaturesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSubscriptions,
    required TResult Function(String subscriptionId) purchase,
    required TResult Function() cancel,
    required TResult Function() restore,
    required TResult Function(String featureId) checkFeature,
    required TResult Function() loadFeatures,
  }) {
    return loadFeatures();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSubscriptions,
    TResult? Function(String subscriptionId)? purchase,
    TResult? Function()? cancel,
    TResult? Function()? restore,
    TResult? Function(String featureId)? checkFeature,
    TResult? Function()? loadFeatures,
  }) {
    return loadFeatures?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSubscriptions,
    TResult Function(String subscriptionId)? purchase,
    TResult Function()? cancel,
    TResult Function()? restore,
    TResult Function(String featureId)? checkFeature,
    TResult Function()? loadFeatures,
    required TResult orElse(),
  }) {
    if (loadFeatures != null) {
      return loadFeatures();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscriptions value) loadSubscriptions,
    required TResult Function(_Purchase value) purchase,
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Restore value) restore,
    required TResult Function(_CheckFeature value) checkFeature,
    required TResult Function(_LoadFeatures value) loadFeatures,
  }) {
    return loadFeatures(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult? Function(_Purchase value)? purchase,
    TResult? Function(_Cancel value)? cancel,
    TResult? Function(_Restore value)? restore,
    TResult? Function(_CheckFeature value)? checkFeature,
    TResult? Function(_LoadFeatures value)? loadFeatures,
  }) {
    return loadFeatures?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscriptions value)? loadSubscriptions,
    TResult Function(_Purchase value)? purchase,
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Restore value)? restore,
    TResult Function(_CheckFeature value)? checkFeature,
    TResult Function(_LoadFeatures value)? loadFeatures,
    required TResult orElse(),
  }) {
    if (loadFeatures != null) {
      return loadFeatures(this);
    }
    return orElse();
  }
}

abstract class _LoadFeatures implements PremiumEvent {
  const factory _LoadFeatures() = _$LoadFeaturesImpl;
}

/// @nodoc
mixin _$PremiumState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumStateCopyWith<$Res> {
  factory $PremiumStateCopyWith(
          PremiumState value, $Res Function(PremiumState) then) =
      _$PremiumStateCopyWithImpl<$Res, PremiumState>;
}

/// @nodoc
class _$PremiumStateCopyWithImpl<$Res, $Val extends PremiumState>
    implements $PremiumStateCopyWith<$Res> {
  _$PremiumStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PremiumState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PremiumState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PremiumState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PremiumState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SubscriptionsLoadedImplCopyWith<$Res> {
  factory _$$SubscriptionsLoadedImplCopyWith(_$SubscriptionsLoadedImpl value,
          $Res Function(_$SubscriptionsLoadedImpl) then) =
      __$$SubscriptionsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SubscriptionModel> subscriptions});
}

/// @nodoc
class __$$SubscriptionsLoadedImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$SubscriptionsLoadedImpl>
    implements _$$SubscriptionsLoadedImplCopyWith<$Res> {
  __$$SubscriptionsLoadedImplCopyWithImpl(_$SubscriptionsLoadedImpl _value,
      $Res Function(_$SubscriptionsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptions = null,
  }) {
    return _then(_$SubscriptionsLoadedImpl(
      null == subscriptions
          ? _value._subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionModel>,
    ));
  }
}

/// @nodoc

class _$SubscriptionsLoadedImpl implements _SubscriptionsLoaded {
  const _$SubscriptionsLoadedImpl(final List<SubscriptionModel> subscriptions)
      : _subscriptions = subscriptions;

  final List<SubscriptionModel> _subscriptions;
  @override
  List<SubscriptionModel> get subscriptions {
    if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscriptions);
  }

  @override
  String toString() {
    return 'PremiumState.subscriptionsLoaded(subscriptions: $subscriptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionsLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._subscriptions, _subscriptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_subscriptions));

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionsLoadedImplCopyWith<_$SubscriptionsLoadedImpl> get copyWith =>
      __$$SubscriptionsLoadedImplCopyWithImpl<_$SubscriptionsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return subscriptionsLoaded(subscriptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return subscriptionsLoaded?.call(subscriptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (subscriptionsLoaded != null) {
      return subscriptionsLoaded(subscriptions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return subscriptionsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return subscriptionsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (subscriptionsLoaded != null) {
      return subscriptionsLoaded(this);
    }
    return orElse();
  }
}

abstract class _SubscriptionsLoaded implements PremiumState {
  const factory _SubscriptionsLoaded(
      final List<SubscriptionModel> subscriptions) = _$SubscriptionsLoadedImpl;

  List<SubscriptionModel> get subscriptions;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionsLoadedImplCopyWith<_$SubscriptionsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchasedImplCopyWith<$Res> {
  factory _$$PurchasedImplCopyWith(
          _$PurchasedImpl value, $Res Function(_$PurchasedImpl) then) =
      __$$PurchasedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchaseModel purchase});

  $PurchaseModelCopyWith<$Res> get purchase;
}

/// @nodoc
class __$$PurchasedImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$PurchasedImpl>
    implements _$$PurchasedImplCopyWith<$Res> {
  __$$PurchasedImplCopyWithImpl(
      _$PurchasedImpl _value, $Res Function(_$PurchasedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchase = null,
  }) {
    return _then(_$PurchasedImpl(
      null == purchase
          ? _value.purchase
          : purchase // ignore: cast_nullable_to_non_nullable
              as PurchaseModel,
    ));
  }

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PurchaseModelCopyWith<$Res> get purchase {
    return $PurchaseModelCopyWith<$Res>(_value.purchase, (value) {
      return _then(_value.copyWith(purchase: value));
    });
  }
}

/// @nodoc

class _$PurchasedImpl implements _Purchased {
  const _$PurchasedImpl(this.purchase);

  @override
  final PurchaseModel purchase;

  @override
  String toString() {
    return 'PremiumState.purchased(purchase: $purchase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasedImpl &&
            (identical(other.purchase, purchase) ||
                other.purchase == purchase));
  }

  @override
  int get hashCode => Object.hash(runtimeType, purchase);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasedImplCopyWith<_$PurchasedImpl> get copyWith =>
      __$$PurchasedImplCopyWithImpl<_$PurchasedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return purchased(purchase);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return purchased?.call(purchase);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (purchased != null) {
      return purchased(purchase);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return purchased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return purchased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (purchased != null) {
      return purchased(this);
    }
    return orElse();
  }
}

abstract class _Purchased implements PremiumState {
  const factory _Purchased(final PurchaseModel purchase) = _$PurchasedImpl;

  PurchaseModel get purchase;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasedImplCopyWith<_$PurchasedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelledImplCopyWith<$Res> {
  factory _$$CancelledImplCopyWith(
          _$CancelledImpl value, $Res Function(_$CancelledImpl) then) =
      __$$CancelledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelledImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$CancelledImpl>
    implements _$$CancelledImplCopyWith<$Res> {
  __$$CancelledImplCopyWithImpl(
      _$CancelledImpl _value, $Res Function(_$CancelledImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelledImpl implements _Cancelled {
  const _$CancelledImpl();

  @override
  String toString() {
    return 'PremiumState.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }
}

abstract class _Cancelled implements PremiumState {
  const factory _Cancelled() = _$CancelledImpl;
}

/// @nodoc
abstract class _$$RestoredImplCopyWith<$Res> {
  factory _$$RestoredImplCopyWith(
          _$RestoredImpl value, $Res Function(_$RestoredImpl) then) =
      __$$RestoredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SubscriptionModel> subscriptions});
}

/// @nodoc
class __$$RestoredImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$RestoredImpl>
    implements _$$RestoredImplCopyWith<$Res> {
  __$$RestoredImplCopyWithImpl(
      _$RestoredImpl _value, $Res Function(_$RestoredImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptions = null,
  }) {
    return _then(_$RestoredImpl(
      null == subscriptions
          ? _value._subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionModel>,
    ));
  }
}

/// @nodoc

class _$RestoredImpl implements _Restored {
  const _$RestoredImpl(final List<SubscriptionModel> subscriptions)
      : _subscriptions = subscriptions;

  final List<SubscriptionModel> _subscriptions;
  @override
  List<SubscriptionModel> get subscriptions {
    if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscriptions);
  }

  @override
  String toString() {
    return 'PremiumState.restored(subscriptions: $subscriptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestoredImpl &&
            const DeepCollectionEquality()
                .equals(other._subscriptions, _subscriptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_subscriptions));

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestoredImplCopyWith<_$RestoredImpl> get copyWith =>
      __$$RestoredImplCopyWithImpl<_$RestoredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return restored(subscriptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return restored?.call(subscriptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (restored != null) {
      return restored(subscriptions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return restored(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return restored?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (restored != null) {
      return restored(this);
    }
    return orElse();
  }
}

abstract class _Restored implements PremiumState {
  const factory _Restored(final List<SubscriptionModel> subscriptions) =
      _$RestoredImpl;

  List<SubscriptionModel> get subscriptions;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestoredImplCopyWith<_$RestoredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeatureCheckedImplCopyWith<$Res> {
  factory _$$FeatureCheckedImplCopyWith(_$FeatureCheckedImpl value,
          $Res Function(_$FeatureCheckedImpl) then) =
      __$$FeatureCheckedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String featureId, bool hasAccess});
}

/// @nodoc
class __$$FeatureCheckedImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$FeatureCheckedImpl>
    implements _$$FeatureCheckedImplCopyWith<$Res> {
  __$$FeatureCheckedImplCopyWithImpl(
      _$FeatureCheckedImpl _value, $Res Function(_$FeatureCheckedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureId = null,
    Object? hasAccess = null,
  }) {
    return _then(_$FeatureCheckedImpl(
      null == featureId
          ? _value.featureId
          : featureId // ignore: cast_nullable_to_non_nullable
              as String,
      null == hasAccess
          ? _value.hasAccess
          : hasAccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FeatureCheckedImpl implements _FeatureChecked {
  const _$FeatureCheckedImpl(this.featureId, this.hasAccess);

  @override
  final String featureId;
  @override
  final bool hasAccess;

  @override
  String toString() {
    return 'PremiumState.featureChecked(featureId: $featureId, hasAccess: $hasAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureCheckedImpl &&
            (identical(other.featureId, featureId) ||
                other.featureId == featureId) &&
            (identical(other.hasAccess, hasAccess) ||
                other.hasAccess == hasAccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, featureId, hasAccess);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureCheckedImplCopyWith<_$FeatureCheckedImpl> get copyWith =>
      __$$FeatureCheckedImplCopyWithImpl<_$FeatureCheckedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return featureChecked(featureId, hasAccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return featureChecked?.call(featureId, hasAccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (featureChecked != null) {
      return featureChecked(featureId, hasAccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return featureChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return featureChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (featureChecked != null) {
      return featureChecked(this);
    }
    return orElse();
  }
}

abstract class _FeatureChecked implements PremiumState {
  const factory _FeatureChecked(final String featureId, final bool hasAccess) =
      _$FeatureCheckedImpl;

  String get featureId;
  bool get hasAccess;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureCheckedImplCopyWith<_$FeatureCheckedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeaturesLoadedImplCopyWith<$Res> {
  factory _$$FeaturesLoadedImplCopyWith(_$FeaturesLoadedImpl value,
          $Res Function(_$FeaturesLoadedImpl) then) =
      __$$FeaturesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FeatureAccessModel> features});
}

/// @nodoc
class __$$FeaturesLoadedImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$FeaturesLoadedImpl>
    implements _$$FeaturesLoadedImplCopyWith<$Res> {
  __$$FeaturesLoadedImplCopyWithImpl(
      _$FeaturesLoadedImpl _value, $Res Function(_$FeaturesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? features = null,
  }) {
    return _then(_$FeaturesLoadedImpl(
      null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<FeatureAccessModel>,
    ));
  }
}

/// @nodoc

class _$FeaturesLoadedImpl implements _FeaturesLoaded {
  const _$FeaturesLoadedImpl(final List<FeatureAccessModel> features)
      : _features = features;

  final List<FeatureAccessModel> _features;
  @override
  List<FeatureAccessModel> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  String toString() {
    return 'PremiumState.featuresLoaded(features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturesLoadedImpl &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_features));

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturesLoadedImplCopyWith<_$FeaturesLoadedImpl> get copyWith =>
      __$$FeaturesLoadedImplCopyWithImpl<_$FeaturesLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return featuresLoaded(features);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return featuresLoaded?.call(features);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (featuresLoaded != null) {
      return featuresLoaded(features);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return featuresLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return featuresLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (featuresLoaded != null) {
      return featuresLoaded(this);
    }
    return orElse();
  }
}

abstract class _FeaturesLoaded implements PremiumState {
  const factory _FeaturesLoaded(final List<FeatureAccessModel> features) =
      _$FeaturesLoadedImpl;

  List<FeatureAccessModel> get features;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturesLoadedImplCopyWith<_$FeaturesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PremiumState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionModel> subscriptions)
        subscriptionsLoaded,
    required TResult Function(PurchaseModel purchase) purchased,
    required TResult Function() cancelled,
    required TResult Function(List<SubscriptionModel> subscriptions) restored,
    required TResult Function(String featureId, bool hasAccess) featureChecked,
    required TResult Function(List<FeatureAccessModel> features) featuresLoaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult? Function(PurchaseModel purchase)? purchased,
    TResult? Function()? cancelled,
    TResult? Function(List<SubscriptionModel> subscriptions)? restored,
    TResult? Function(String featureId, bool hasAccess)? featureChecked,
    TResult? Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SubscriptionModel> subscriptions)?
        subscriptionsLoaded,
    TResult Function(PurchaseModel purchase)? purchased,
    TResult Function()? cancelled,
    TResult Function(List<SubscriptionModel> subscriptions)? restored,
    TResult Function(String featureId, bool hasAccess)? featureChecked,
    TResult Function(List<FeatureAccessModel> features)? featuresLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SubscriptionsLoaded value) subscriptionsLoaded,
    required TResult Function(_Purchased value) purchased,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Restored value) restored,
    required TResult Function(_FeatureChecked value) featureChecked,
    required TResult Function(_FeaturesLoaded value) featuresLoaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult? Function(_Purchased value)? purchased,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Restored value)? restored,
    TResult? Function(_FeatureChecked value)? featureChecked,
    TResult? Function(_FeaturesLoaded value)? featuresLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SubscriptionsLoaded value)? subscriptionsLoaded,
    TResult Function(_Purchased value)? purchased,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Restored value)? restored,
    TResult Function(_FeatureChecked value)? featureChecked,
    TResult Function(_FeaturesLoaded value)? featuresLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PremiumState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
