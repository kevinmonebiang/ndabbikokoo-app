import 'package:flutter/material.dart';

import '../models/member_portal_data.dart';
import '../utils/app_formatters.dart';
import '../widgets/brand_mark.dart';
import '../widgets/digital_member_card.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.data,
  });

  final MemberPortalData data;

  @override
  Widget build(BuildContext context) {
    final member = data.member;
    final latestPayments = data.payments.take(3).toList();
    final latestAnnouncements = data.announcements.take(2).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F4A3B),
                Color(0xFF17614B),
                Color(0xFF2A8A70),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A10382B),
                blurRadius: 30,
                offset: Offset(0, 18),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -24,
                right: -16,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0x15FFFFFF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -48,
                left: -12,
                child: Container(
                  width: 168,
                  height: 168,
                  decoration: const BoxDecoration(
                    color: Color(0x18F0B34A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BrandMark(size: 68, showRing: true),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          member.fullName,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.7,
                                  ),
                        ),
                      ),
                      StatusBadge(status: member.status),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _HeroPill(
                        label: member.memberNumber,
                        color: const Color(0x21FFFFFF),
                      ),
                      _HeroPill(
                        label: '${member.city}, ${member.country}',
                        color: const Color(0x21F0B34A),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(
          title: 'Vue rapide',
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth < 640
                ? constraints.maxWidth
                : (constraints.maxWidth - 12) / 2;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: _MetricCard(
                    label: 'Cotise en 2026',
                    value: formatCurrency(member.totalPaidThisYear),
                    accent: const Color(0xFF1D5A4A),
                    icon: Icons.savings_rounded,
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _MetricCard(
                    label: 'Solde restant',
                    value: formatCurrency(member.balanceDue),
                    accent: const Color(0xFFC38A2E),
                    icon: Icons.schedule_rounded,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth < 720
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 24) / 3;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: itemWidth,
                      child: _MiniInfo(
                        label: 'Numero membre',
                        value: member.memberNumber,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _MiniInfo(
                        label: 'Ville',
                        value: '${member.city}, ${member.country}',
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _MiniInfo(
                        label: 'Adhesion',
                        value: formatShortDate(member.joinedOn),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Carte de membre',
        ),
        const SizedBox(height: 14),
        DigitalMemberCard(member: member),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Paiements recents',
        ),
        const SizedBox(height: 14),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: latestPayments
                  .map(
                    (payment) => ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFF3E6C8),
                        child: Icon(
                          Icons.receipt_long_rounded,
                          color: Color(0xFF1D5A4A),
                        ),
                      ),
                      title: Text(
                        payment.label,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${payment.method} - ${formatShortDate(payment.paidOn)}',
                      ),
                      trailing: Text(
                        formatCurrency(payment.amount),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Annonces recentes',
        ),
        const SizedBox(height: 14),
        ...latestAnnouncements.map(
          (announcement) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: announcement.highlighted
                                ? const Color(0xFFF3E6C8)
                                : const Color(0xFFE4EFEA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            announcement.category,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(formatShortDate(announcement.publishedOn)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      announcement.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      announcement.message,
                      style: const TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.accent,
    required this.icon,
  });

  final String label;
  final String value;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6D6F6B),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6D6F6B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
