import '../../domain/entities/portfolio_entities.dart';

/// Local data source — all portfolio content lives here.
/// Errors are caught at this boundary and never bubble up raw.
class PortfolioLocalDataSource {
  PortfolioData getPortfolioData() {
    return const PortfolioData(
      name: 'Nourhan Ayman',
      title: 'Flutter Developer',
      bio:
          'Flutter developer from Egypt, ranked #1 in my class at Benha University with a 3.95 GPA. '
          'I build scalable cross-platform apps with Clean Architecture, BLoC, and pixel-perfect UIs.',
      location: 'Banha, Egypt',
      email: 'nourhanayman3120@gmail.com',
      phone: '+20 106 233 0858',
      linkedIn: 'https://linkedin.com/in/Nourhan',
      github: 'https://github.com/Nourhan',
      cgpa: '3.73',
      classRank: '#1',
      skills: [
        SkillCategory(
          label: 'Mobile Development',
          icon: '📱',
          skills: [
            'Flutter',
            'Dart',
            'Android',
            'Java',
            'BLoC',
            'Provider',
            'Clean Architecture',
            'Dependency Injection',
          ],
        ),
        SkillCategory(
          label: 'Backend & Storage',
          icon: '🔌',
          skills: [
            'RESTful APIs',
            'Firebase',
            'SQLite',
            'Hive',
            'Shared Preferences',
            'Pagination',
          ],
        ),
        SkillCategory(
          label: 'UI & Integration',
          icon: '✨',
          skills: [
            'Responsive UI',
            'Deep Links',
            'Notifications',
            'Google Maps',
            'Payment Integration',
          ],
        ),
        SkillCategory(
          label: 'CS Fundamentals',
          icon: '🧩',
          skills: [
            'OOP',
            'SOLID Principles',
            'Data Structures',
            'Algorithms',
            'C++',
            'Python',
            'SQL',
          ],
        ),
        SkillCategory(
          label: 'AI & Machine Learning',
          icon: '🤖',
          skills: [
            'Machine Learning',
            'Neural Networks',
            'Computer Vision',
            'DSP',
          ],
        ),
        SkillCategory(
          label: 'Tools',
          icon: '🛠️',
          skills: ['Git', 'GitHub', 'Linux', 'Postman', 'FlutterFlow'],
        ),
      ],
      experiences: [
        Experience(
          role: 'Flutter Developer Intern',
          company: 'Link Development · Remote',
          period: 'Dec 2025 – Feb 2026',
          description:
              'Contributed to 3andy — a multi-role service & e-commerce ecosystem. Developed ~40% of the app, collaborating with the team to improve performance and UX.',
          isPrimary: true,
        ),
        Experience(
          role: 'Flutter Developer Intern',
          company: 'DRB · Remote',
          period: 'Oct 2025 – Dec 2025',
          description:
              'Led a team of 5 building a Courier Delivery System using Flutter in 1 month, accelerating the development lifecycle by 75%.',
          isPrimary: true,
        ),
        Experience(
          role: 'Session Lead – DECI Program',
          company: 'Udacity · Remote',
          period: 'July 2025 – Present',
          description:
              'Led weekly sessions for the Programming Fundamentals Nanodegree. Supported 91.7% of students to graduate with a feedback score of 9.4/10.',
          isPrimary: true,
        ),
        Experience(
          role: 'Flutter Instructor',
          company: '3C Creative Children Community · Remote',
          period: 'Nov 2025 – Present',
          description:
              'Teaching Flutter development via interactive sessions, guiding students in building and debugging mobile apps.',
          isPrimary: false,
        ),
        Experience(
          role: 'Multiple Training Programs (ITIDA · DEPI · ITI)',
          company: 'MCIT · Remote',
          period: 'Apr 2024 – Apr 2025',
          description:
              'ITIDA: Trained ML models for Parkinson\'s Detection with 97%+ accuracy. DEPI: Passed with "Excellent". ITI: Built scalable apps with BLoC & RESTful APIs.',
          isPrimary: false,
        ),
        Experience(
          role: 'Flutter Developer Intern',
          company: 'Code Casa · Remote',
          period: 'Oct 2023 – Nov 2023',
          description:
              'Developed 3 responsive Flutter applications focusing on clean UI/UX and state management.',
          isPrimary: false,
        ),
        Experience(
          role: 'Software Fundamentals Trainee',
          company: 'Orange Digital Center · On-site',
          period: 'Aug 2023 – Sep 2023',
          description:
              'Completed the Techiekit Software program gaining hands-on software engineering experience.',
          isPrimary: false,
        ),
      ],
      projects: [
        Project(
          number: '01',
          title: '3andy — Multi-Role E-Commerce Ecosystem',
          description:
              'Scalable Flutter app with 4 roles: User, Company, Technician, and Delegate. Built with Clean Architecture and BLoC.',
          tags: ['Flutter', 'BLoC', 'Clean Architecture'],
          emoji: '🛍️',
        ),
        Project(
          number: '02',
          title: 'Trackify — Smart Courier Delivery',
          description:
              'Dual-app system with real-time tracking, payments, route navigation, and earnings management.',
          tags: ['Flutter', 'Real-time', 'Google Maps'],
          emoji: '🚚',
          githubUrl: 'https://github.com/Nourhan',
        ),
        Project(
          number: '03',
          title: 'Movie App',
          description:
              'Movie browser with TMDb API, Cubit state, Hive local storage, YouTube trailers, and advanced search.',
          tags: ['Cubit', 'Hive', 'TMDb API'],
          emoji: '🎬',
          githubUrl: 'https://github.com/Nourhan',
        ),
        Project(
          number: '04',
          title: 'Fashion Store App',
          description:
              'Full-featured e-commerce app with Firebase, secure auth, product browsing, and order management.',
          tags: ['Firebase', 'Flutter', 'E-commerce'],
          emoji: '👗',
          githubUrl: 'https://github.com/Nourhan',
        ),
        Project(
          number: '05',
          title: 'Balanced Meal App',
          description:
              'Health-focused meal ordering with calorie/budget customization, real-time calculations, and form validation.',
          tags: ['FlutterFlow', 'Health'],
          emoji: '🥗',
          demoUrl: '#',
        ),
        Project(
          number: '06',
          title: 'EEG Smart Assistant — A+',
          description:
              'Graduation project: EEG signal capture, DSP preprocessing, ML classification of hand movements, and 4DOF robotic arm control.',
          tags: ['ML', 'DSP', 'Embedded Systems'],
          emoji: '🧠',
        ),
      ],
      achievements: [
        Achievement(
          icon: '⚖️',
          title: 'Technical Judge — Codeavour Egypt',
          description:
              'Judged Robotics & AI projects in the largest Egyptian competition for children (March 2024)',
        ),
        Achievement(
          icon: '💻',
          title: 'ECPC Contestant',
          description:
              '10th place among BFCAI teams, 30th overall in Egypt\'s Collegiate Programming Contest (Aug 2023)',
        ),
        Achievement(
          icon: '👩‍🏫',
          title: 'Flutter Core Team — GDG Benha',
          description:
              'Mentored 10–25 students during GDG Flutter Bootcamp with structured sessions (2023–2025)',
        ),
        Achievement(
          icon: '📋',
          title: 'Logistics Core Team — GDG Benha',
          description:
              'Supported organization and execution of various tech events and bootcamps (2022–2023)',
        ),
      ],
    );
  }
}
