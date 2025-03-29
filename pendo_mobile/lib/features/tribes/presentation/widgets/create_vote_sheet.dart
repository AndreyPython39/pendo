import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tribes_bloc.dart';
import '../../data/models/tribe_model.dart';

class CreateVoteSheet extends StatefulWidget {
  final String tribeId;

  const CreateVoteSheet({
    super.key,
    required this.tribeId,
  });

  @override
  State<CreateVoteSheet> createState() => _CreateVoteSheetState();
}

class _CreateVoteSheetState extends State<CreateVoteSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  DateTime _endTime = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    }
  }

  void _createVote() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _optionControllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final vote = TribeVoteModel(
      id: '', // Will be set by backend
      tribeId: widget.tribeId,
      title: _titleController.text,
      description: _descriptionController.text,
      startTime: DateTime.now(),
      endTime: _endTime,
      options: _optionControllers.map((c) => c.text).toList(),
      votes: {},
      isActive: true,
    );

    context.read<TribesBloc>().add(CreateVoteEvent(vote));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create Vote',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'What are we voting on?',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Provide more details about the vote',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Options',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...List.generate(
            _optionControllers.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _optionControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Option ${index + 1}',
                      ),
                    ),
                  ),
                  if (_optionControllers.length > 2)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => _removeOption(index),
                    ),
                ],
              ),
            ),
          ),
          TextButton.icon(
            onPressed: _addOption,
            icon: const Icon(Icons.add),
            label: const Text('Add Option'),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('End Time'),
            subtitle: Text(
              _endTime.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDateTimePicker(
                context: context,
                initialDate: _endTime,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (picked != null) {
                setState(() => _endTime = picked);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _createVote,
            child: const Text('Create Vote'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  final date = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );
  if (date == null) return null;

  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );
  if (time == null) return null;

  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
