import 'package:flutter/material.dart';

import '../models/member_portal_data.dart';
import '../widgets/brand_mark.dart';
import 'contributions_screen.dart';
import 'dashboard_screen.dart';
import 'info_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.data,
    required this.onLogout,
  });

  final MemberPortalData data;
  final VoidCallback onLogout;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final titles = <String>[
      'Accueil membre',
      'Mon profil',
      'Cotisations',
      'Informations',
    ];

    final screens = <Widget>[
      DashboardScreen(data: widget.data),
      ProfileScreen(member: widget.data.member),
      ContributionsScreen(
        member: widget.data.member,
        payments: widget.data.payments,
      ),
      InfoScreen(
        announcements: widget.data.announcements,
        contacts: widget.data.contacts,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const BrandMark(size: 42, showRing: false),
            const SizedBox(width: 12),
            Text(
              titles[_currentIndex],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Deconnexion',
            onPressed: widget.onLogout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        height: 76,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge_rounded),
            label: 'Profil',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Cotisations',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign_rounded),
            label: 'Infos',
          ),
        ],
      ),
    );
  }
}
