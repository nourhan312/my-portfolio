import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/skill_tag_chip.dart';
import '../../domain/entities/portfolio_entities.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Portfolio',
            titlePlain: 'Featured',
            titleAccent: 'Projects',
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              final cols =
                  constraints.maxWidth > 900 ? 3 : (isMobile ? 1 : 2);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.2 : 0.9,
                ),
                itemCount: projects.length,
                itemBuilder: (context, i) => _ProjectCard(project: projects[i])
                    .animate()
                    .fadeIn(delay: (i * 80).ms, duration: 400.ms)
                    .slideY(begin: 0.15, end: 0),
              );
            },
          ),
        ],
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: colors.bg2,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.project.number,
                    style: GoogleFonts.syne(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: colors.border.withOpacity(4),
                      letterSpacing: -0.04,
                    ),
                  ),
                  Text(
                    widget.project.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: Padding(
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: colors.textSecondary,
                          height: 1.65,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.tags
                          .map((t) => SkillTagChip(label: t))
                          .toList(),
                    ),

                    const SizedBox(height: 12),

                    // Links
                    _ProjectLinks(project: widget.project),
                  ],
                ),
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
    final hasLinks =
        project.githubUrl != null || project.demoUrl != null;

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
      children: [
        if (project.githubUrl != null)
          _LinkButton(
            label: 'GitHub',
            icon: Icons.code,
            onTap: () => _launch(project.githubUrl!),
          ),
        if (project.demoUrl != null)
          _LinkButton(
            label: 'Live Demo',
            icon: Icons.open_in_new,
            onTap: () => _launch(project.demoUrl!),
          ),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _LinkButton({
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
