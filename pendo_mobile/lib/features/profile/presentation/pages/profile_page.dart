import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:pendo_mobile/features/profile/presentation/widgets/profile_header.dart';
import 'package:pendo_mobile/features/profile/presentation/widgets/profile_stats.dart';
import 'package:pendo_mobile/features/profile/presentation/widgets/profile_actions.dart';
import 'package:pendo_mobile/features/profile/presentation/widgets/profile_tribes.dart';
import 'package:pendo_mobile/shared/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const LoadingIndicator();
          }

          if (state is ProfileLoaded) {
            return CustomScrollView(
              slivers: [
                // Profile Header with Photos
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    user: state.user,
                    onEditProfile: () {
                      Navigator.pushNamed(context, Routes.editProfile);
                    },
                    onEditPhotos: () {
                      Navigator.pushNamed(context, Routes.photos);
                    },
                  ),
                ),

                // Profile Stats
                SliverToBoxAdapter(
                  child: ProfileStats(
                    matches: state.stats.matches,
                    likes: state.stats.likes,
                    views: state.stats.views,
                  ),
                ),

                // Profile Actions
                SliverToBoxAdapter(
                  child: ProfileActions(
                    isPremium: state.user.isPremium,
                    onPremiumTap: () {
                      Navigator.pushNamed(context, Routes.premium);
                    },
                    onSettingsTap: () {
                      Navigator.pushNamed(context, Routes.settings);
                    },
                    onPreferencesTap: () {
                      Navigator.pushNamed(context, Routes.preferences);
                    },
                  ),
                ),

                // My Tribes
                SliverToBoxAdapter(
                  child: ProfileTribes(
                    tribes: state.tribes,
                    onTribeTap: (tribe) {
                      Navigator.pushNamed(
                        context,
                        Routes.tribeDetails,
                        arguments: tribe,
                      );
                    },
                    onCreateTribe: () {
                      Navigator.pushNamed(context, Routes.createTribe);
                    },
                  ),
                ),

                // Spacer
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
