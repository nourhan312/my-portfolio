import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../domain/entities/portfolio_entities.dart';
import 'hero/hero_background.dart';
import 'hero/hero_portrait.dart';
import 'hero/hero_text_content.dart';

class HeroSection extends StatelessWidget {
  final PortfolioData data;

  const HeroSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 680),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: HeroBackground(isMobile: isMobile),
          ),
          Center(
            child: isMobile
                ? HeroTextContent(
                    data: data,
                    isMobile: true,
                    keyPrefix: 'hero-mobile',
                    afterHeadline: HeroPortrait(data: data),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: HeroTextContent(
                            data: data,
                            isMobile: false,
                            keyPrefix: 'hero-desktop',
                          ),
                        ),
                      ),
                      SizedBox(width: isTablet ? 28 : 56),
                      Expanded(
                        flex: 4,
                        child: RevealOnScroll(
                          key: const ValueKey('hero-photo-desktop'),
                          delay: const Duration(milliseconds: 220),
                          slideY: 0.06,
                          child: HeroPortrait(data: data),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
