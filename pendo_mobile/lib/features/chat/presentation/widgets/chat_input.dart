import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final Function(String)? onTyping;
  final Function(String)? onImageSelected;
  final List<String>? quickReplies;

  const ChatInput({
    super.key,
    required this.onSendMessage,
    this.onTyping,
    this.onImageSelected,
    this.quickReplies,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isComposing = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    final isComposing = _controller.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });
    }

    if (widget.onTyping != null) {
      _typingTimer?.cancel();
      widget.onTyping!(_controller.text);
      _typingTimer = Timer(const Duration(milliseconds: 500), () {
        widget.onTyping!('');
      });
    }
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    widget.onSendMessage(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  Future<void> _pickImage() async {
    if (widget.onImageSelected == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.onImageSelected!(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        if (widget.quickReplies != null && widget.quickReplies!.isNotEmpty) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Row(
              children: widget.quickReplies!.map((reply) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ActionChip(
                    label: Text(reply),
                    onPressed: () => _handleSubmitted(reply),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
        ],
        Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Row(
                children: [
                  if (widget.onImageSelected != null)
                    IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: _pickImage,
                    ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isComposing ? 48 : 0,
                    child: _isComposing
                        ? IconButton(
                            icon: Icon(
                              Icons.send,
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: () =>
                                _handleSubmitted(_controller.text.trim()),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
