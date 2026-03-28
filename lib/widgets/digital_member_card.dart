import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../models/member.dart';
import '../utils/app_formatters.dart';
import 'brand_mark.dart';
import 'status_badge.dart';

class DigitalMemberCard extends StatelessWidget {
  const DigitalMemberCard({
    super.key,
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF123B2F),
            Color(0xFF165D47),
            Color(0xFF2B9271),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26124336),
            blurRadius: 34,
            offset: Offset(0, 20),
          ),
        ],
        border: Border.all(
          color: const Color(0x40F4D18A),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -12,
            child: Container(
              width: 124,
              height: 124,
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -42,
            left: -26,
            child: Container(
              width: 144,
              height: 144,
              decoration: const BoxDecoration(
                color: Color(0x22F7C873),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 68,
            right: -8,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0x14FFFFFF),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandMark(size: 58),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppConfig.appName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                      ),
                    ),
                  ),
                  StatusBadge(status: member.status, compact: true),
                ],
              ),
              const SizedBox(height: 26),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0x1AFFFFFF),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0x26FFFFFF)),
                ),
                child: Text(
                  member.roleLabel,
                  style: const TextStyle(
                    color: Color(0xFFF6E2B6),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                member.fullName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                member.memberNumber,
                style: const TextStyle(
                  color: Color(0xFFE8D8B8),
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _CardInfo(
                      label: 'Communaute',
                      value: member.community,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CardInfo(
                      label: 'Valable jusqu au',
                      value: formatShortDate(member.validUntil),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: List.generate(
                  16,
                  (index) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? const Color(0xFFF7C873)
                          : const Color(0xAAFFFFFF),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  const _CardInfo({
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
            color: Color(0xCCFFFFFF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
