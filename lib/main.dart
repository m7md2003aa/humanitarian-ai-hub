import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme/app_theme.dart';
import 'Screens/role_selection_page.dart';
import 'Screens/donor_page.dart';
import 'Screens/beneficiary_page.dart';
import 'Screens/business_page.dart';

final _router = GoRouter(
  initialLocation: '/roles',
  routes: [
    GoRoute(path: '/roles', builder: (_, __) => const RoleSelectionPage()),
    GoRoute(path: '/donor', builder: (_, __) => const DonorPage()),
    GoRoute(path: '/beneficiary', builder: (_, __) => const BeneficiaryPage()),
    GoRoute(path: '/business', builder: (_, __) => const BusinessPage()),
  ],
);

void main() => runApp(const HumanitarianAIHub());

class HumanitarianAIHub extends StatelessWidget {
  const HumanitarianAIHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Humanitarian AI Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
