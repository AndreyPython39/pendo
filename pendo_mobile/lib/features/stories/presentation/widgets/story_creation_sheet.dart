import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/stories_bloc.dart';
import '../../../../shared/widgets/loading_button.dart';

class StoryCreationSheet extends StatefulWidget {
  const StoryCreationSheet({super.key});

  @override
  State<StoryCreationSheet> createState() => _StoryCreationSheetState();
}

class _StoryCreationSheetState extends State<StoryCreationSheet> {
  final _captionController = TextEditingController();
  String? _mediaPath;
  String _mediaType = 'image';
  bool _isUploading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia(ImageSource source, String type) async {
    final picker = ImagePicker();
    final result = type == 'image'
        ? await picker.pickImage(source: source)
        : await picker.pickVideo(source: source);

    if (result != null) {
      setState(() {
        _mediaPath = result.path;
        _mediaType = type;
      });
    }
  }

  Future<void> _createStory() async {
    if (_mediaPath == null) return;

    setState(() => _isUploading = true);

    try {
      // TODO: Upload media to storage and get URL
      final mediaUrl = 'https://example.com/media.jpg'; // Placeholder

      context.read<StoriesBloc>().add(
            StoriesEvent.create(
              mediaType: _mediaType,
              mediaUrl: mediaUrl,
              caption: _captionController.text.isEmpty
                  ? null
                  : _captionController.text,
            ),
          );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: const Text('Create Story'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              if (_mediaPath != null)
                LoadingButton(
                  onPressed: _createStory,
                  isLoading: _isUploading,
                  child: const Text('Share'),
                ),
            ],
          ),
          if (_mediaPath == null) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MediaPickerButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => _pickMedia(ImageSource.gallery, 'image'),
                ),
                _MediaPickerButton(
                  icon: Icons.photo_camera,
                  label: 'Camera',
                  onTap: () => _pickMedia(ImageSource.camera, 'image'),
                ),
                _MediaPickerButton(
                  icon: Icons.videocam,
                  label: 'Video',
                  onTap: () => _pickMedia(ImageSource.camera, 'video'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ] else ...[
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _mediaPath!,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: TextField(
                        controller: _captionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MediaPickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MediaPickerButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
