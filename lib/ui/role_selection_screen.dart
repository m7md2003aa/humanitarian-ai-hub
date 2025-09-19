import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
// TODO: replace with your actual screens if you already built them:
import '../Screens/donor_page.dart';
import '../Screens/beneficiary_page.dart';
import '../Screens/business_page.dart';



class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Humanitarian AI Hub')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // Hero / header
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFDCFCE7), Color(0xFFE0F2FE)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Empower • Donate • Redeem',
                    style: t.titleLarge?.copyWith(color: AppColors.text, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('Choose your role to continue',
                    style: t.bodyMedium?.copyWith(color: AppColors.textMuted)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10, runSpacing: 10,
                  children: [
                    ActionChip(label: const Text('Start a Donation'),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Donate flow coming soon…')))),
                    const ActionChip(label: Text('View Impact')),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          _RoleCard(
            title: 'Donor',
            subtitle: 'Upload & track donations',
            icon: Icons.volunteer_activism_outlined,
            color: AppColors.primary,
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const DonorScreen())),
          ),
          const SizedBox(height: 12),
          _RoleCard(
            title: 'Beneficiary',
            subtitle: 'See wallet & redeem credits',
            icon: Icons.redeem_outlined,
            color: AppColors.tertiary,
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const BeneficiaryDashboard())),
          ),
          const SizedBox(height: 12),
          _RoleCard(
            title: 'Business',
            subtitle: 'List surplus / discounted items',
            icon: Icons.storefront_outlined,
            color: AppColors.secondary,
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const BusinessScreen())),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title, required this.subtitle, required this.icon,
    required this.color, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
              colors: [color.withOpacity(0.08), Colors.white],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: t.bodyMedium?.copyWith(color: Color(0xFF6B7280))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}
