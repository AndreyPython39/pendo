part of 'stories_bloc.dart';

@freezed
class StoriesState with _$StoriesState {
  const factory StoriesState.initial() = _Initial;
  const factory StoriesState.loading() = _Loading;
  const factory StoriesState.loaded(List<StoryModel> stories) = _Loaded;
  const factory StoriesState.error(String message) = _Error;
}
