import 'package:flutter/material.dart';

import '../models/member.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    this.compact = false,
  });

  final MemberStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isUpToDate = status == MemberStatus.upToDate;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 14,
        vertical: compact ? 6 : 9,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUpToDate
              ? const [
                  Color(0xFFDDF5E8),
                  Color(0xFFCAEEDB),
                ]
              : const [
                  Color(0xFFFCE7D6),
                  Color(0xFFF9D6B9),
                ],
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isUpToDate
              ? const Color(0xFFB4E2C9)
              : const Color(0xFFF0BE95),
        ),
      ),
      child: Text(
        isUpToDate ? 'A jour' : 'En retard',
        style: TextStyle(
          color: isUpToDate ? scheme.primary : const Color(0xFF9B4A1C),
          fontWeight: FontWeight.w700,
          fontSize: compact ? 12 : 13,
        ),
      ),
    );
  }
}
