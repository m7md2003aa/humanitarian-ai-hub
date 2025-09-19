import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/donor_page.dart';
import 'screens/beneficiary_page.dart';
import 'screens/business_page.dart';

void main() => runApp(const SDPApp());

class SDPApp extends StatelessWidget {
  const SDPApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/donor',   // 👈 start here
      routes: [
        GoRoute(path: '/donor', builder: (_, __) => const DonorPage()),
        GoRoute(path: '/beneficiary', builder: (_, __) => const BeneficiaryPage()),
        GoRoute(path: '/business', builder: (_, __) => const BusinessPage()),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,        // 👈 important: use router
      title: 'SDP – Humanitarian AI Hub',
      theme: ThemeData(useMaterial3: true),
    );
  }
}
