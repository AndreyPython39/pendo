import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class MediaService {
  final FirebaseStorage _storage;
  final _uuid = const Uuid();

  MediaService(this._storage);

  Future<Map<String, String>> uploadStoryMedia(String filePath, String mediaType) async {
    final fileName = '${_uuid.v4()}${path.extension(filePath)}';
    final storageRef = _storage.ref().child('stories/$fileName');
    
    String? thumbnailUrl;
    
    if (mediaType == 'video') {
      // Generate thumbnail for video
      final thumbnail = await VideoCompress.getFileThumbnail(filePath);
      final thumbnailRef = _storage.ref().child('stories/thumbnails/$fileName.jpg');
      await thumbnailRef.putFile(File(thumbnail.path));
      thumbnailUrl = await thumbnailRef.getDownloadURL();
      
      // Compress video if needed
      final MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        filePath,
        quality: VideoQuality.MediumQuality,
      );
      
      if (mediaInfo?.file == null) {
        throw Exception('Failed to compress video');
      }
      
      await storageRef.putFile(File(mediaInfo!.file!.path));
    } else {
      await storageRef.putFile(File(filePath));
    }

    final mediaUrl = await storageRef.getDownloadURL();

    return {
      'mediaUrl': mediaUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
    };
  }

  Future<void> deleteStoryMedia(String mediaUrl, String? thumbnailUrl) async {
    try {
      final mediaRef = _storage.refFromURL(mediaUrl);
      await mediaRef.delete();

      if (thumbnailUrl != null) {
        final thumbnailRef = _storage.refFromURL(thumbnailUrl);
        await thumbnailRef.delete();
      }
    } catch (e) {
      // Log error but don't throw, as the media might have been already deleted
      print('Error deleting media: $e');
    }
  }
}
