import 'package:flutter/material.dart';

import '../models/member.dart';
import '../utils/app_formatters.dart';
import '../widgets/digital_member_card.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const SectionHeader(
          title: 'Profil',
        ),
        const SizedBox(height: 16),
        DigitalMemberCard(member: member),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        member.fullName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    StatusBadge(status: member.status),
                  ],
                ),
                const SizedBox(height: 18),
                _InfoLine(label: 'Numero membre', value: member.memberNumber),
                _InfoLine(label: 'Role', value: member.roleLabel),
                _InfoLine(label: 'Communaute', value: member.community),
                _InfoLine(
                  label: 'Ville de residence',
                  value: '${member.city}, ${member.country}',
                ),
                _InfoLine(
                  label: 'Date d adhesion',
                  value: formatShortDate(member.joinedOn),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 18),
                _InfoLine(label: 'Telephone', value: member.phone),
                _InfoLine(label: 'Email', value: member.email),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cotisation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 18),
                _InfoLine(
                  label: 'Cotisation mensuelle',
                  value: formatCurrency(member.monthlyContribution),
                ),
                _InfoLine(
                  label: 'Total verse cette annee',
                  value: formatCurrency(member.totalPaidThisYear),
                ),
                _InfoLine(
                  label: 'Solde restant',
                  value: formatCurrency(member.balanceDue),
                ),
                _InfoLine(
                  label: 'Carte valide jusqu au',
                  value: formatShortDate(member.validUntil),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6D6F6B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
