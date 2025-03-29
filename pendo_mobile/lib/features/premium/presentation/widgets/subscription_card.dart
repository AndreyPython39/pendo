import 'package:flutter/material.dart';
import '../../data/models/subscription_model.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel subscription;
  final VoidCallback onSelect;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: subscription.name.toLowerCase().contains('premium')
                  ? [Colors.purple.shade400, Colors.blue.shade400]
                  : [Colors.grey.shade300, Colors.grey.shade100],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subscription.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: subscription.name.toLowerCase().contains('premium')
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: subscription.name.toLowerCase().contains('premium')
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${subscription.price} ${subscription.currency}/${subscription.period}',
                      style: TextStyle(
                        color: subscription.name.toLowerCase().contains('premium')
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                subscription.description,
                style: TextStyle(
                  color: subscription.name.toLowerCase().contains('premium')
                      ? Colors.white.withOpacity(0.8)
                      : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ...subscription.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: subscription.name.toLowerCase().contains('premium')
                            ? Colors.white
                            : Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        feature,
                        style: TextStyle(
                          color: subscription.name.toLowerCase().contains('premium')
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: subscription.name.toLowerCase().contains('premium')
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    foregroundColor: subscription.name.toLowerCase().contains('premium')
                        ? Colors.purple.shade400
                        : Colors.white,
                  ),
                  child: const Text('Select Plan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
