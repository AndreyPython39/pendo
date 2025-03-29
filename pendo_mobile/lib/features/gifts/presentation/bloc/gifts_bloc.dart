import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/gift_repository.dart';
import '../../domain/models/gift.dart';

// Events
abstract class GiftsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadGifts extends GiftsEvent {}
class LoadReceivedGifts extends GiftsEvent {}
class LoadSentGifts extends GiftsEvent {}
class SendGift extends GiftsEvent {
  final int giftId;
  final int receiverId;

  SendGift({required this.giftId, required this.receiverId});

  @override
  List<Object> get props => [giftId, receiverId];
}

// States
abstract class GiftsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GiftsInitial extends GiftsState {}
class GiftsLoading extends GiftsState {}
class GiftsLoaded extends GiftsState {
  final List<Gift> gifts;

  GiftsLoaded(this.gifts);

  @override
  List<Object> get props => [gifts];
}

class ReceivedGiftsLoading extends GiftsState {}
class ReceivedGiftsLoaded extends GiftsState {
  final List<Gift> gifts;

  ReceivedGiftsLoaded(this.gifts);

  @override
  List<Object> get props => [gifts];
}

class SentGiftsLoading extends GiftsState {}
class SentGiftsLoaded extends GiftsState {
  final List<Gift> gifts;

  SentGiftsLoaded(this.gifts);

  @override
  List<Object> get props => [gifts];
}

class GiftsError extends GiftsState {
  final String message;

  GiftsError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  final GiftRepository _giftRepository;

  GiftsBloc(this._giftRepository) : super(GiftsInitial()) {
    on<LoadGifts>(_onLoadGifts);
    on<LoadReceivedGifts>(_onLoadReceivedGifts);
    on<LoadSentGifts>(_onLoadSentGifts);
    on<SendGift>(_onSendGift);
  }

  Future<void> _onLoadGifts(LoadGifts event, Emitter<GiftsState> emit) async {
    try {
      emit(GiftsLoading());
      final gifts = await _giftRepository.getGifts();
      emit(GiftsLoaded(gifts));
    } catch (e) {
      emit(GiftsError(e.toString()));
    }
  }

  Future<void> _onLoadReceivedGifts(
    LoadReceivedGifts event,
    Emitter<GiftsState> emit,
  ) async {
    try {
      emit(ReceivedGiftsLoading());
      final gifts = await _giftRepository.getReceivedGifts();
      emit(ReceivedGiftsLoaded(gifts));
    } catch (e) {
      emit(GiftsError(e.toString()));
    }
  }

  Future<void> _onLoadSentGifts(
    LoadSentGifts event,
    Emitter<GiftsState> emit,
  ) async {
    try {
      emit(SentGiftsLoading());
      final gifts = await _giftRepository.getSentGifts();
      emit(SentGiftsLoaded(gifts));
    } catch (e) {
      emit(GiftsError(e.toString()));
    }
  }

  Future<void> _onSendGift(SendGift event, Emitter<GiftsState> emit) async {
    try {
      await _giftRepository.sendGift(
        giftId: event.giftId,
        receiverId: event.receiverId,
      );
      add(LoadSentGifts());
    } catch (e) {
      emit(GiftsError(e.toString()));
    }
  }
}
