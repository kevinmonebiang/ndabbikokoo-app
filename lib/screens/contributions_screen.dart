import 'package:flutter/material.dart';

import '../models/member.dart';
import '../models/payment.dart';
import '../utils/app_formatters.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';

class ContributionsScreen extends StatelessWidget {
  const ContributionsScreen({
    super.key,
    required this.member,
    required this.payments,
  });

  final Member member;
  final List<Payment> payments;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const SectionHeader(
          title: 'Cotisations et paiements',
          subtitle: 'Suivi de vos versements et de votre statut actuel.',
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
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
                      child: _SummaryBox(
                        label: 'Statut membre',
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: StatusBadge(status: member.status),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _SummaryBox(
                        label: 'Cotisation mensuelle',
                        child: Text(
                          formatCurrency(member.monthlyContribution),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _SummaryBox(
                        label: 'Paye cette annee',
                        child: Text(
                          formatCurrency(member.totalPaidThisYear),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: _SummaryBox(
                        label: 'Reste a payer',
                        child: Text(
                          formatCurrency(member.balanceDue),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
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
          title: 'Historique des paiements',
          subtitle: 'Tous les paiements enregistres pour votre compte.',
        ),
        const SizedBox(height: 14),
        ...payments.map(
          (payment) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E6C8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.payments_rounded,
                        color: Color(0xFF1D5A4A),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payment.label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${payment.method} - ${payment.reference}',
                            style: const TextStyle(
                              color: Color(0xFF6D6F6B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatShortDate(payment.paidOn),
                            style: const TextStyle(
                              color: Color(0xFF6D6F6B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency(payment.amount),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4EFEA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            payment.statusLabel,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1D5A4A),
                            ),
                          ),
                        ),
                      ],
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

class _SummaryBox extends StatelessWidget {
  const _SummaryBox({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6D6F6B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
