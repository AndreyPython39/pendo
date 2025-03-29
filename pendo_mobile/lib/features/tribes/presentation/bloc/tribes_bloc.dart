import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/tribes/domain/repositories/tribes_repository.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_event.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_state.dart';

class TribesBloc extends Bloc<TribesEvent, TribesState> {
  final TribesRepository _tribesRepository;
  StreamSubscription? _tribeSubscription;
  StreamSubscription? _eventSubscription;
  StreamSubscription? _voteSubscription;

  TribesBloc(this._tribesRepository) : super(TribesInitial()) {
    on<LoadTribesEvent>(_onLoadTribes);
    on<CreateTribeEvent>(_onCreateTribe);
    on<UpdateTribeEvent>(_onUpdateTribe);
    on<DeleteTribeEvent>(_onDeleteTribe);
    on<JoinTribeEvent>(_onJoinTribe);
    on<LeaveTribeEvent>(_onLeaveTribe);
    on<AddModeratorEvent>(_onAddModerator);
    on<RemoveModeratorEvent>(_onRemoveModerator);
    on<KickMemberEvent>(_onKickMember);
    on<CreateEventEvent>(_onCreateEvent);
    on<LoadEventsEvent>(_onLoadEvents);
    on<JoinEventEvent>(_onJoinEvent);
    on<LeaveEventEvent>(_onLeaveEvent);
    on<CreateVoteEvent>(_onCreateVote);
    on<CastVoteEvent>(_onCastVote);
    on<LoadActiveVotesEvent>(_onLoadActiveVotes);
    on<LoadTribeStatsEvent>(_onLoadTribeStats);

    _subscribeToUpdates();
  }

  void _subscribeToUpdates() {
    _tribeSubscription = _tribesRepository.onTribeUpdated().listen(
      (data) {
        // Handle tribe updates
        add(const LoadTribesEvent());
      },
    );

    _eventSubscription = _tribesRepository.onEventCreated().listen(
      (event) {
        // Handle new event
        add(LoadEventsEvent(tribeId: event.tribeId));
      },
    );

    _voteSubscription = _tribesRepository.onVoteCreated().listen(
      (vote) {
        // Handle new vote
        add(LoadActiveVotesEvent(vote.tribeId));
      },
    );
  }

  Future<void> _onLoadTribes(
    LoadTribesEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final tribes = await _tribesRepository.getTribes(
        page: event.page,
        limit: event.limit,
        filters: event.filters,
      );
      emit(TribesLoaded(tribes: tribes));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onCreateTribe(
    CreateTribeEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final tribe = await _tribesRepository.createTribe(
        name: event.name,
        description: event.description,
        avatar: event.avatar,
        coverImage: event.coverImage,
        settings: event.settings,
      );
      emit(TribeCreated(tribe));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onUpdateTribe(
    UpdateTribeEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.updateTribe(
        tribeId: event.tribeId,
        name: event.name,
        description: event.description,
        avatar: event.avatar,
        coverImage: event.coverImage,
        settings: event.settings,
      );
      // Reload tribes to get updated data
      add(const LoadTribesEvent());
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onDeleteTribe(
    DeleteTribeEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.deleteTribe(event.tribeId);
      emit(TribeDeleted(event.tribeId));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onJoinTribe(
    JoinTribeEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.joinTribe(event.tribeId);
      emit(TribeJoined(event.tribeId));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onLeaveTribe(
    LeaveTribeEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.leaveTribe(event.tribeId);
      emit(TribeLeft(event.tribeId));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onAddModerator(
    AddModeratorEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.addModerator(
        tribeId: event.tribeId,
        userId: event.userId,
      );
      emit(ModeratorAdded(
        tribeId: event.tribeId,
        userId: event.userId,
      ));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onRemoveModerator(
    RemoveModeratorEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.removeModerator(
        tribeId: event.tribeId,
        userId: event.userId,
      );
      emit(ModeratorRemoved(
        tribeId: event.tribeId,
        userId: event.userId,
      ));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onKickMember(
    KickMemberEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.kickMember(
        tribeId: event.tribeId,
        userId: event.userId,
      );
      emit(MemberKicked(
        tribeId: event.tribeId,
        userId: event.userId,
      ));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onCreateEvent(
    CreateEventEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final tribeEvent = await _tribesRepository.createEvent(
        tribeId: event.tribeId,
        title: event.title,
        description: event.description,
        startTime: event.startTime,
        endTime: event.endTime,
        location: event.location,
        latitude: event.latitude,
        longitude: event.longitude,
        metadata: event.metadata,
      );
      emit(EventCreated(tribeEvent));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onLoadEvents(
    LoadEventsEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final events = await _tribesRepository.getEvents(
        tribeId: event.tribeId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(EventsLoaded(events));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onJoinEvent(
    JoinEventEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.joinEvent(
        tribeId: event.tribeId,
        eventId: event.eventId,
      );
      emit(EventJoined(event.eventId));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onLeaveEvent(
    LeaveEventEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.leaveEvent(
        tribeId: event.tribeId,
        eventId: event.eventId,
      );
      emit(EventLeft(event.eventId));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onCreateVote(
    CreateVoteEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final vote = await _tribesRepository.createVote(
        tribeId: event.tribeId,
        title: event.title,
        description: event.description,
        startTime: event.startTime,
        endTime: event.endTime,
        options: event.options,
      );
      emit(VoteCreated(vote));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onCastVote(
    CastVoteEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      await _tribesRepository.castVote(
        tribeId: event.tribeId,
        voteId: event.voteId,
        option: event.option,
      );
      emit(VoteCasted(
        voteId: event.voteId,
        option: event.option,
      ));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onLoadActiveVotes(
    LoadActiveVotesEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final votes = await _tribesRepository.getActiveVotes(event.tribeId);
      emit(ActiveVotesLoaded(votes));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  Future<void> _onLoadTribeStats(
    LoadTribeStatsEvent event,
    Emitter<TribesState> emit,
  ) async {
    try {
      emit(TribesLoading());
      final stats = await _tribesRepository.getTribeStats(event.tribeId);
      emit(TribeStatsLoaded(stats));
    } catch (e) {
      emit(TribesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _tribeSubscription?.cancel();
    _eventSubscription?.cancel();
    _voteSubscription?.cancel();
    return super.close();
  }
}
