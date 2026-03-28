import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../models/association_contact.dart';
import '../utils/app_formatters.dart';
import '../widgets/section_header.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.announcements,
    required this.contacts,
  });

  final List<Announcement> announcements;
  final List<AssociationContact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const SectionHeader(
          title: 'Annonces et communiques',
          subtitle: 'Actualites officielles et contacts utiles de l association.',
        ),
        const SizedBox(height: 16),
        ...announcements.map(
          (announcement) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final categoryChip = Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: announcement.highlighted
                                ? const Color(0xFFF3E6C8)
                                : const Color(0xFFE4EFEA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            announcement.category,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        );

                        final dateText = Text(
                          formatShortDate(announcement.publishedOn),
                        );

                        if (constraints.maxWidth < 360) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              categoryChip,
                              const SizedBox(height: 8),
                              dateText,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            categoryChip,
                            const Spacer(),
                            dateText,
                          ],
                        );
                      },
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
        const SizedBox(height: 18),
        const SectionHeader(
          title: 'Contacts utiles',
          subtitle: 'Pour joindre rapidement les responsables de l association.',
        ),
        const SizedBox(height: 14),
        ...contacts.map(
          (contact) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contact.role,
                      style: const TextStyle(
                        color: Color(0xFF1D5A4A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ContactLine(
                      icon: Icons.call_outlined,
                      value: contact.phone,
                    ),
                    const SizedBox(height: 10),
                    _ContactLine(
                      icon: Icons.mail_outline_rounded,
                      value: contact.email,
                    ),
                    const SizedBox(height: 10),
                    _ContactLine(
                      icon: Icons.schedule_rounded,
                      value: contact.availability,
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

class _ContactLine extends StatelessWidget {
  const _ContactLine({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6D6F6B)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
