import 'package:flutter/material.dart';
import '../../data/models/subscription_model.dart';

class FeatureList extends StatelessWidget {
  final List<FeatureAccessModel> features;

  const FeatureList({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              feature.isEnabled ? Icons.check_circle : Icons.block,
              color: feature.isEnabled ? Colors.green : Colors.red,
            ),
            title: Text(feature.name),
            subtitle: feature.limit > 0
                ? Text('${feature.used}/${feature.limit} used')
                : null,
            trailing: feature.expiryDate != null
                ? Text(
                    'Expires: ${_formatDate(feature.expiryDate!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
