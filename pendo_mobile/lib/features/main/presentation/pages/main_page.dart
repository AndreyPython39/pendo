import 'package:flutter/material.dart';
import 'package:pendo_mobile/features/discover/presentation/pages/discover_page.dart';
import 'package:pendo_mobile/features/tribes/presentation/pages/tribes_page.dart';
import 'package:pendo_mobile/features/chat/presentation/pages/chat_list_page.dart';
import 'package:pendo_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DiscoverPage(),
    const TribesPage(),
    const ChatListPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/discover.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/tribes.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            label: 'Tribes',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/chat.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
