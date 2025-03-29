import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/models/story_model.dart';

part 'stories_bloc.freezed.dart';
part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final StoryRepository _repository;

  StoriesBloc(this._repository) : super(const StoriesState.initial()) {
    on<StoriesEvent>((event, emit) async {
      await event.map(
        load: (e) => _onLoad(e, emit),
        create: (e) => _onCreate(e, emit),
        view: (e) => _onView(e, emit),
        delete: (e) => _onDelete(e, emit),
      );
    });
  }

  Future<void> _onLoad(_LoadStories event, Emitter<StoriesState> emit) async {
    try {
      emit(const StoriesState.loading());
      final stories = await _repository.getStories();
      emit(StoriesState.loaded(stories));
    } catch (e) {
      emit(StoriesState.error(e.toString()));
    }
  }

  Future<void> _onCreate(_CreateStory event, Emitter<StoriesState> emit) async {
    try {
      final story = await _repository.createStory(
        mediaType: event.mediaType,
        mediaUrl: event.mediaUrl,
        caption: event.caption,
      );
      
      final currentStories = state.maybeWhen(
        loaded: (stories) => stories,
        orElse: () => <StoryModel>[],
      );

      emit(StoriesState.loaded([story, ...currentStories]));
    } catch (e) {
      emit(StoriesState.error(e.toString()));
    }
  }

  Future<void> _onView(_ViewStory event, Emitter<StoriesState> emit) async {
    try {
      await _repository.viewStory(event.storyId);
      
      final currentStories = state.maybeWhen(
        loaded: (stories) => stories.map((story) {
          if (story.id == event.storyId) {
            return story.copyWith(isViewed: true);
          }
          return story;
        }).toList(),
        orElse: () => <StoryModel>[],
      );

      emit(StoriesState.loaded(currentStories));
    } catch (e) {
      emit(StoriesState.error(e.toString()));
    }
  }

  Future<void> _onDelete(_DeleteStory event, Emitter<StoriesState> emit) async {
    try {
      await _repository.deleteStory(event.storyId);
      
      final currentStories = state.maybeWhen(
        loaded: (stories) => stories.where((s) => s.id != event.storyId).toList(),
        orElse: () => <StoryModel>[],
      );

      emit(StoriesState.loaded(currentStories));
    } catch (e) {
      emit(StoriesState.error(e.toString()));
    }
  }
}
