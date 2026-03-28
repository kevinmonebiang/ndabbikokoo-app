import 'package:flutter/material.dart';

import '../config/app_config.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 64,
    this.showRing = false,
  });

  final double size;
  final bool showRing;

  @override
  Widget build(BuildContext context) {
    final padding = showRing ? size * 0.08 : size * 0.04;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: showRing ? const Color(0xFFD7E8E1) : const Color(0x14FFFFFF),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1714322A),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          AppConfig.logoAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _FallbackMark(size: size - padding * 2),
        ),
      ),
    );
  }
}

class _FallbackMark extends StatelessWidget {
  const _FallbackMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD9F0FF),
            Color(0xFFEFF7FF),
            Color(0xFFF7E3B5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size * 0.5,
              height: size * 0.28,
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF8ED2FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size * 0.38,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF1B654),
                    Color(0xFFE08E2B),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Align(
            child: Icon(
              Icons.park_rounded,
              size: size * 0.42,
              color: const Color(0xFF1F6E4F),
            ),
          ),
        ],
      ),
    );
  }
}
