import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/premium_bloc.dart';
import '../../data/models/subscription_model.dart';
import '../widgets/subscription_card.dart';
import '../widgets/feature_list.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  void initState() {
    super.initState();
    context.read<PremiumBloc>()
      ..add(const PremiumEvent.loadSubscriptions())
      ..add(const PremiumEvent.loadFeatures());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<PremiumBloc>().add(const PremiumEvent.restore());
            },
            child: const Text('Restore'),
          ),
        ],
      ),
      body: BlocConsumer<PremiumBloc, PremiumState>(
        listener: (context, state) {
          state.maybeWhen(
            purchased: (purchase) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase successful!')),
              );
            },
            cancelled: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Subscription cancelled')),
              );
            },
            restored: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchases restored')),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $message')),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            subscriptionsLoaded: (subscriptions) => _buildSubscriptionsList(subscriptions),
            featuresLoaded: (features) => FeatureList(features: features),
            error: (message) => Center(child: Text('Error: $message')),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionsList(List<SubscriptionModel> subscriptions) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ...subscriptions.map((subscription) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SubscriptionCard(
            subscription: subscription,
            onSelect: () {
              context.read<PremiumBloc>().add(
                PremiumEvent.purchase(subscription.id),
              );
            },
          ),
        )),
        const SizedBox(height: 16),
        const Text(
          'By subscribing, you agree to our Terms of Service and Privacy Policy. '
          'Subscriptions will automatically renew unless cancelled at least 24 hours '
          'before the end of the current period.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
