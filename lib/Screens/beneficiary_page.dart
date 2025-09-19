import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeneficiaryPage extends StatelessWidget {
  const BeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final demo = [
      {'title': 'Clothes', 'credits': 10},
      {'title': 'Food', 'credits': 8},
      {'title': 'Electronics', 'credits': 20},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Beneficiary')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demo.length,
        itemBuilder: (context, i) {
          final item = demo[i];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(item['title']!.toString()),
              subtitle: Text('Credits: ${item['credits']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Redeem "${item['title']}" (mock)')),
                  );
                },
                child: const Text('Redeem'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _BottomNav(current: 1),
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
