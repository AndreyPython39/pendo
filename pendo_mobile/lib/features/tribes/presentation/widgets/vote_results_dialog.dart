import 'package:flutter/material.dart';
import '../../data/models/tribe_model.dart';
import 'package:fl_chart/fl_chart.dart';

class VoteResultsDialog extends StatelessWidget {
  final TribeVoteModel vote;

  const VoteResultsDialog({
    super.key,
    required this.vote,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentages for each option
    final totalVotes = vote.votes.values
        .map((voters) => voters.length)
        .fold(0, (sum, count) => sum + count);

    final results = vote.options.map((option) {
      final count = vote.votes[option]?.length ?? 0;
      final percentage = totalVotes > 0 ? (count / totalVotes * 100) : 0.0;
      return MapEntry(option, percentage);
    }).toList();

    // Sort results by percentage in descending order
    results.sort((a, b) => b.value.compareTo(a.value));

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vote.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              vote.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (totalVotes > 0) ...[
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: results
                        .map(
                          (result) => PieChartSectionData(
                            value: result.value,
                            title: '${result.value.toStringAsFixed(1)}%',
                            color: _getColor(results.indexOf(result)),
                            radius: 100,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...results.map(
                (result) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getColor(results.indexOf(result)),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          result.key,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        '${(vote.votes[result.key]?.length ?? 0)} votes',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ] else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No votes yet'),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Votes: $totalVotes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (!vote.isActive)
                  const Chip(
                    label: Text('Closed'),
                    backgroundColor: Colors.grey,
                  )
                else if (vote.endTime.isBefore(DateTime.now()))
                  const Chip(
                    label: Text('Ended'),
                    backgroundColor: Colors.red,
                  )
                else
                  Chip(
                    label: Text(
                      'Ends in ${_formatDuration(vote.endTime.difference(DateTime.now()))}',
                    ),
                    backgroundColor: Colors.green,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d';
    }
    if (duration.inHours > 0) {
      return '${duration.inHours}h';
    }
    return '${duration.inMinutes}m';
  }
}
