import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your role')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _RoleTile('Donor', 'Upload and manage donations', () => context.go('/donor')),
          _RoleTile('Beneficiary', 'Browse marketplace and redeem credits', () => context.go('/beneficiary')),
          _RoleTile('Business', 'List surplus items for the community', () => context.go('/business')),
        ],
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onTap;
  const _RoleTile(this.title, this.subtitle, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
