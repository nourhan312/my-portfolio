/// Represents a skill category shown in the portfolio.
class SkillCategory {
  final String label;
  final String icon;
  final List<String> skills;

  const SkillCategory({
    required this.label,
    required this.icon,
    required this.skills,
  });
}

/// Represents a work/internship experience entry.
class Experience {
  final String role;
  final String company;
  final String period;
  final String description;
  final bool isPrimary;

  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.isPrimary = false,
  });
}

/// Represents a project in the portfolio.
class Project {
  final String number;
  final String title;
  final String description;
  final List<String> tags;
  final String? githubUrl;
  final String? demoUrl;
  final String emoji;

  const Project({
    required this.number,
    required this.title,
    required this.description,
    required this.tags,
    required this.emoji,
    this.githubUrl,
    this.demoUrl,
  });
}

/// Represents an achievement or volunteering entry.
class Achievement {
  final String icon;
  final String title;
  final String description;

  const Achievement({
    required this.icon,
    required this.title,
    required this.description,
  });
}

/// Top-level portfolio data entity.
class PortfolioData {
  final String name;
  final String title;
  final String? photoUrl;
  final String bio;
  final String location;
  final String email;
  final String phone;
  final String linkedIn;
  final String github;
  final String cgpa;
  final String classRank;
  final List<SkillCategory> skills;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<Achievement> achievements;

  const PortfolioData({
    required this.name,
    required this.title,
    this.photoUrl,
    required this.bio,
    required this.location,
    required this.email,
    required this.phone,
    required this.linkedIn,
    required this.github,
    required this.cgpa,
    required this.classRank,
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.achievements,
  });
}
