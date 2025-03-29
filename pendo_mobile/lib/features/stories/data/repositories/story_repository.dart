import 'package:dio/dio.dart';
import '../models/story_model.dart';

class StoryRepository {
  final Dio _dio;

  StoryRepository(this._dio);

  Future<List<StoryModel>> getStories() async {
    final response = await _dio.get('/stories');
    return (response.data as List)
        .map((json) => StoryModel.fromJson(json))
        .toList();
  }

  Future<StoryModel> createStory({
    required String mediaType,
    required String mediaUrl,
    String? caption,
  }) async {
    final response = await _dio.post('/stories', data: {
      'media_type': mediaType,
      'media_url': mediaUrl,
      'caption': caption,
    });
    return StoryModel.fromJson(response.data);
  }

  Future<void> viewStory(int storyId) async {
    await _dio.post('/stories/$storyId/view');
  }

  Future<void> deleteStory(int storyId) async {
    await _dio.delete('/stories/$storyId');
  }
}
