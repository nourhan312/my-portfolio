import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../cubit/portfolio_cubit.dart';
import '../cubit/portfolio_state.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_navbar.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  bool _showMoveToTop = false;

  // Section keys for scroll-to navigation
  final _heroKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<PortfolioCubit>().load();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final shouldShow = _scrollController.offset > 360;
    if (shouldShow != _showMoveToTop) {
      setState(() => _showMoveToTop = shouldShow);
    }
  }

  Future<void> _scrollToTop() async {
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollTo(String section) {
    final key = switch (section) {
      'About' => _heroKey,
      'Skills' => _skillsKey,
      'Experience' => _experienceKey,
      'Projects' => _projectsKey,
      'Contact' => _contactKey,
      _ => _heroKey,
    };

    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main scroll content
          _PortfolioBody(
            scrollController: _scrollController,
            heroKey: _heroKey,
            skillsKey: _skillsKey,
            experienceKey: _experienceKey,
            projectsKey: _projectsKey,
            contactKey: _contactKey,
          ),

          // Navbar pinned on top — only theme toggle needs Bloc access
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BlocSelector<PortfolioCubit, PortfolioState, bool>(
              selector: (state) => state is PortfolioLoaded && state.isDark,
              builder: (context, isDark) => PortfolioNavBar(
                isDark: isDark,
                onThemeToggle: () =>
                    context.read<PortfolioCubit>().toggleTheme(),
                onNavTap: _scrollTo,
              ),
            ),
          ),
          Positioned(
            right: context.isMobile ? 20 : 28,
            bottom: context.isMobile ? 20 : 28,
            child: _MoveToTopButton(
              visible: _showMoveToTop,
              onTap: _scrollToTop,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoveToTopButton extends StatefulWidget {
  final bool visible;
  final VoidCallback onTap;

  const _MoveToTopButton({required this.visible, required this.onTap});

  @override
  State<_MoveToTopButton> createState() => _MoveToTopButtonState();
}

class _MoveToTopButtonState extends State<_MoveToTopButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return IgnorePointer(
      ignoring: !widget.visible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        offset: widget.visible ? Offset.zero : const Offset(0, 0.5),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: widget.visible ? 1 : 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors.accent,
                      colors.accent.withValues(alpha: 0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.accent.withValues(alpha: 0.35),
                      blurRadius: _hovered ? 18 : 14,
                      offset: Offset(0, _hovered ? 8 : 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.keyboard_double_arrow_up_rounded,
                  color: Colors.white,
                  size: _hovered ? 28 : 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Body — separated to keep build() lean ────────────────────────────────────

class _PortfolioBody extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey heroKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const _PortfolioBody({
    required this.scrollController,
    required this.heroKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        return switch (state) {
          PortfolioInitial() || PortfolioLoading() => const _LoadingView(),
          PortfolioError(:final message) => _ErrorView(message: message),
          PortfolioLoaded(:final data) => SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Offset for navbar height
                  const SizedBox(height: 60),

                  SizedBox(key: heroKey, child: HeroSection(data: data)),
                  SizedBox(
                    key: skillsKey,
                    child: SkillsSection(skills: data.skills),
                  ),
                  SizedBox(
                    key: experienceKey,
                    child: ExperienceSection(experiences: data.experiences),
                  ),
                  SizedBox(
                    key: projectsKey,
                    child: ProjectsSection(projects: data.projects),
                  ),
                  EducationSection(data: data),
                  AchievementsSection(achievements: data.achievements),
                  SizedBox(
                    key: contactKey,
                    child: ContactSection(data: data),
                  ),
                  _Footer(),
                ],
              ),
            ),
        };
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: colors.accent, strokeWidth: 2),
            const SizedBox(height: 16),
            Text(
              'Loading portfolio...',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: colors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colors.accent, size: 40),
            const SizedBox(height: 12),
            Text(
              message,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.read<PortfolioCubit>().load(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isMobile = context.isMobile;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2025 Nourhan Ayman · Flutter Developer · Banha, Egypt',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: colors.textHint,
            ),
          ),
          if (!isMobile)
            Text(
              'Built with Flutter 💙',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: colors.textHint,
              ),
            ),
        ],
      ),
    );
  }
}
