import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Partner')),
      body: const Center(child: Text('Upload surplus items (coming next).')),
      bottomNavigationBar: _BottomNav(current: 2),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int current;
  const _BottomNav({required this.current});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: current,
      onDestinationSelected: (i) {
        if (i == 0) context.go('/donor');
        if (i == 1) context.go('/beneficiary');
        if (i == 2) context.go('/business');
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Donor'),
        NavigationDestination(icon: Icon(Icons.list_alt), selectedIcon: Icon(Icons.list), label: 'Beneficiary'),
        NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Business'),
      ],
    );
  }
}
