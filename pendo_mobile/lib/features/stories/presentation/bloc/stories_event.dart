part of 'stories_bloc.dart';

@freezed
class StoriesEvent with _$StoriesEvent {
  const factory StoriesEvent.load() = _LoadStories;
  
  const factory StoriesEvent.create({
    required String mediaType,
    required String mediaUrl,
    String? caption,
  }) = _CreateStory;
  
  const factory StoriesEvent.view(int storyId) = _ViewStory;
  
  const factory StoriesEvent.delete(int storyId) = _DeleteStory;
}
