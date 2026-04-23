import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeroAnimatedBackground extends StatefulWidget {
  final Color dotColor;
  final Color glowColor;
  final int dotCount;

  const HeroAnimatedBackground({
    super.key,
    required this.dotColor,
    required this.glowColor,
    this.dotCount = 84,
  });

  @override
  State<HeroAnimatedBackground> createState() => _HeroAnimatedBackgroundState();
}

class _HeroAnimatedBackgroundState extends State<HeroAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (disableAnimations) {
      return CustomPaint(
        painter: _DotsPainter(
          progress: 0,
          dotColor: widget.dotColor,
          glowColor: widget.glowColor,
          dotCount: widget.dotCount,
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _DotsPainter(
            progress: _controller.value,
            dotColor: widget.dotColor,
            glowColor: widget.glowColor,
            dotCount: widget.dotCount,
          ),
        );
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color dotColor;
  final Color glowColor;
  final int dotCount;

  const _DotsPainter({
    required this.progress,
    required this.dotColor,
    required this.glowColor,
    required this.dotCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < dotCount; i++) {
      final seed = i + 1;
      final baseX = ((seed * 37) % 1000) / 1000.0;
      final baseY = ((seed * 91) % 1000) / 1000.0;
      final speed = 0.012 + (i % 7) * 0.003;
      final drift = math.sin((progress * 2 * math.pi) + (i * 0.72)) * 0.028;

      final xFactor = (baseX + (progress * speed)) % 1;
      var yFactor = (baseY + drift) % 1;
      if (yFactor < 0) yFactor += 1;

      final offset = Offset(xFactor * size.width, yFactor * size.height);
      final radius = 0.9 + (i % 4) * 0.55;

      final alpha = 0.12 + (math.sin((progress * 2 * math.pi) + i) + 1) * 0.05;
      paint.color = dotColor.withValues(alpha: alpha);
      canvas.drawCircle(offset, radius, paint);

      if (i % 8 == 0) {
        paint.color = glowColor.withValues(alpha: 0.12);
        canvas.drawCircle(offset, radius + 1.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotsPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.dotColor != dotColor ||
        oldDelegate.glowColor != glowColor ||
        oldDelegate.dotCount != dotCount;
  }
}
