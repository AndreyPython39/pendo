import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/subscription_model.dart';
import '../../domain/repositories/i_premium_repository.dart';

part 'premium_bloc.freezed.dart';
part 'premium_event.dart';
part 'premium_state.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  final IPremiumRepository _repository;

  PremiumBloc(this._repository) : super(const PremiumState.initial()) {
    on<PremiumEvent>((event, emit) async {
      await event.map(
        loadSubscriptions: (e) => _onLoadSubscriptions(e, emit),
        purchase: (e) => _onPurchase(e, emit),
        cancel: (e) => _onCancel(e, emit),
        restore: (e) => _onRestore(e, emit),
        checkFeature: (e) => _onCheckFeature(e, emit),
        loadFeatures: (e) => _onLoadFeatures(e, emit),
      );
    });
  }

  Future<void> _onLoadSubscriptions(_LoadSubscriptions event,
      Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());
      final subscriptions = await _repository.getSubscriptions();
      emit(PremiumState.subscriptionsLoaded(subscriptions));
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }

  Future<void> _onPurchase(_Purchase event, Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());
      final purchase = await _repository.purchaseSubscription(event.subscriptionId);
      emit(PremiumState.purchased(purchase));
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }

  Future<void> _onCancel(_Cancel event, Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());
      await _repository.cancelSubscription();
      emit(const PremiumState.cancelled());
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }

  Future<void> _onRestore(_Restore event, Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());
      await _repository.restorePurchases();
      final subscriptions = await _repository.getSubscriptions();
      emit(PremiumState.restored(subscriptions));
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }

  Future<void> _onCheckFeature(_CheckFeature event,
      Emitter<PremiumState> emit) async {
    try {
      final hasAccess = await _repository.checkFeatureAccess(event.featureId);
      emit(PremiumState.featureChecked(event.featureId, hasAccess));
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }

  Future<void> _onLoadFeatures(_LoadFeatures event,
      Emitter<PremiumState> emit) async {
    try {
      emit(const PremiumState.loading());
      final features = await _repository.getFeatureAccess();
      emit(PremiumState.featuresLoaded(features));
    } catch (e) {
      emit(PremiumState.error(e.toString()));
    }
  }
}
