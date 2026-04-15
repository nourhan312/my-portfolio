import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/skill_tag_chip.dart';
import '../../domain/entities/portfolio_entities.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final cols = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            key: const ValueKey('projects-header'),
            slideY: 0.05,
            child: const SectionHeader(
              label: 'Portfolio',
              titlePlain: 'Featured',
              titleAccent: 'Projects',
            ),
          ),
          const SizedBox(height: 40),
          _ProjectsGrid(projects: projects, cols: cols),
        ],
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<Project> projects;
  final int cols;

  const _ProjectsGrid({required this.projects, required this.cols});

  @override
  Widget build(BuildContext context) {
    final rows = <List<Project>>[];
    for (var i = 0; i < projects.length; i += cols) {
      rows.add(projects.sublist(i, (i + cols).clamp(0, projects.length)));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final row = rowEntry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: row.asMap().entries.map((cardEntry) {
                final cardIndex = cardEntry.key;
                final project = cardEntry.value;
                final globalIndex = rowIndex * cols + cardIndex;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: cardIndex == 0 ? 0 : 12,
                      right: cardIndex == row.length - 1 ? 0 : 12,
                    ),
                    child: RevealOnScroll(
                      key: ValueKey('project-card-$globalIndex'),
                      delay: Duration(milliseconds: globalIndex * 80),
                      slideY: 0.05,
                      child: _ProjectCard(project: project),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        // ← No Expanded here — card sizes to content, IntrinsicHeight handles row height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header strip
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: colors.bg2,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.project.number,
                    style: GoogleFonts.syne(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      // Use a fixed muted color — don't call withOpacity(4)
                      color: colors.textPrimary.withOpacity(0.12),
                      letterSpacing: -0.04,
                    ),
                  ),
                  Text(
                    widget.project.emoji,
                    style: const TextStyle(fontSize: 26),
                  ),
                ],
              ),
            ),

            // Body — no Expanded, just padding + column
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.project.description,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: colors.textSecondary,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.tags
                        .map((t) => SkillTagChip(label: t))
                        .toList(),
                  ),
                  const SizedBox(height: 14),
                  _ProjectLinks(project: widget.project),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectLinks extends StatelessWidget {
  final Project project;
  const _ProjectLinks({required this.project});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasLinks = project.githubUrl != null || project.demoUrl != null;

    if (!hasLinks) {
      return Text(
        project.number == '06' ? 'Graduation Project' : 'Team Project',
        style: GoogleFonts.dmSans(
          fontSize: 12,
          color: colors.textHint,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        if (project.githubUrl != null)
          _LinkChip(
            label: 'GitHub',
            icon: Icons.code,
            onTap: () => _launch(project.githubUrl!),
          ),
        if (project.demoUrl != null)
          _LinkChip(
            label: 'Live Demo',
            icon: Icons.open_in_new,
            onTap: () => _launch(project.demoUrl!),
          ),
      ],
    );
  }
}

class _LinkChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _LinkChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: colors.accent),
              const SizedBox(width: 5),
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: colors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
