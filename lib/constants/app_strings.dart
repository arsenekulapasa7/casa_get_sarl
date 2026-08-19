import '../models/project_models.dart';

class AppStrings {
  static const String languageEn = 'EN';
  static const String languageFr = 'FR';

  static List<String> navItems(String language) {
    if (language == languageFr) {
      return const [
        'Accueil',
        'À propos',
        'Services',
        'Projets',
        'Loisirs',
        'Blog',
        'Contact',
      ];
    }

    return const [
      'Home',
      'About',
      'Services',
      'Projects',
      'Leisure',
      'Blog',
      'Contact',
    ];
  }

  static List<String> sectionTitles(String language) {
    if (language == languageFr) {
      return const [
        'À propos',
        'Services',
        'Projets',
        'Loisirs',
        'Blog',
        'Contact',
      ];
    }

    return const [
      'About',
      'Services',
      'Projects',
      'Leisure',
      'Blog',
      'Contact',
    ];
  }

  static String leisureBlogTitle(String language) {
    return language == languageFr ? 'Loisirs & Blog' : 'Leisure & Blog';
  }

  static String leisureBlogSubtitle(String language) {
    return language == languageFr
        ? 'Des moments de détente, des idées inspirantes et des contenus qui accompagnent notre vision.'
        : 'Moments of balance, inspiring ideas and content that support our vision.';
  }

  static List<LeisureHighlight> leisureHighlights(String language) {
    if (language == languageFr) {
      return const [
        LeisureHighlight(
          title: 'Nature & aventure',
          description: 'Des escapades, randonnées et découvertes qui renforcent l’équilibre entre travail et bien-être.',
          icon: '🌿',
        ),
        LeisureHighlight(
          title: 'Culture & société',
          description: 'Un regard sur les dynamiques locales, les traditions et les initiatives qui font avancer les communautés.',
          icon: '🎶',
        ),
        LeisureHighlight(
          title: 'Innovation & mode de vie',
          description: 'Des inspirations pratiques pour mieux vivre, mieux construire et mieux accompagner les projets humains.',
          icon: '💡',
        ),
      ];
    }

    return const [
      LeisureHighlight(
        title: 'Nature & adventure',
        description: 'Outings, hikes and discoveries that strengthen the balance between work and well-being.',
        icon: '🌿',
      ),
      LeisureHighlight(
        title: 'Culture & society',
        description: 'A lens on local dynamics, traditions and initiatives driving community progress.',
        icon: '🎶',
      ),
      LeisureHighlight(
        title: 'Innovation & lifestyle',
        description: 'Practical inspiration to live better, build better and support meaningful projects.',
        icon: '💡',
      ),
    ];
  }

  static List<BlogPost> blogPosts(String language) {
    if (language == languageFr) {
      return const [
        BlogPost(
          title: 'Comment bâtir des structures durables au cœur des communautés',
          excerpt: 'Une analyse des choix de conception et des bonnes pratiques qui favorisent la résilience.',
          category: 'Construction',
          date: '12 août 2026',
          readTime: '4 min',
        ),
        BlogPost(
          title: 'L’importance d’une infrastructure locale pensée pour l’avenir',
          excerpt: 'Les leviers qui permettent de créer des sites plus fonctionnels, plus sûrs et plus accessibles.',
          category: 'Infrastructure',
          date: '28 juillet 2026',
          readTime: '5 min',
        ),
        BlogPost(
          title: 'Quand l’innovation et les besoins terrain se rejoignent',
          excerpt: 'Des idées concrètes pour concevoir des solutions qui répondent à des réalités très différentes.',
          category: 'Innovation',
          date: '10 juillet 2026',
          readTime: '3 min',
        ),
      ];
    }

    return const [
      BlogPost(
        title: 'How to build sustainable structures at the heart of communities',
        excerpt: 'A look at design choices and best practices that improve resilience and long-term value.',
        category: 'Construction',
        date: '12 Aug 2026',
        readTime: '4 min',
      ),
      BlogPost(
        title: 'Why local infrastructure must be designed for the future',
        excerpt: 'The levers that create safer, more functional and more accessible work environments.',
        category: 'Infrastructure',
        date: '28 Jul 2026',
        readTime: '5 min',
      ),
      BlogPost(
        title: 'When innovation and field realities meet',
        excerpt: 'Practical ideas for building solutions that respond to highly varied operational needs.',
        category: 'Innovation',
        date: '10 Jul 2026',
        readTime: '3 min',
      ),
    ];
  }

  static String aboutTitle(String language) {
    return language == languageFr ? 'À propos' : 'About Us';
  }

  static String aboutDescription(String language) {
    return language == languageFr
        ? 'CASA GET SARL est une société de construction et d’infrastructure spécialisée dans les solutions modulaires, les énergies renouvelables et les projets d’impact en Afrique.'
        : 'CASA GET SARL is a construction and infrastructure company specializing in modular buildings, renewable energy integration, and mining support solutions across Africa.';
  }

  static List<Map<String, String>> aboutValues(String language) {
    if (language == languageFr) {
      return const [
        {'title': 'Expertise locale', 'text': 'Une compréhension fine des enjeux terrain et des besoins de nos clients.'},
        {'title': 'Qualité durable', 'text': 'Des standards rigoureux et des matériaux conçus pour durer.'},
        {'title': 'Impact social', 'text': 'Des infrastructures pensées pour renforcer les communautés locales.'},
      ];
    }

    return const [
      {'title': 'Local expertise', 'text': 'A deep understanding of field challenges and client needs.'},
      {'title': 'Sustainable quality', 'text': 'Strict standards and materials designed for long-term performance.'},
      {'title': 'Social impact', 'text': 'Infrastructure designed to strengthen local communities.'},
    ];
  }

  static List<Map<String, String>> serviceCards(String language) {
    if (language == languageFr) {
      return const [
        {'title': 'Construction civile', 'text': 'Conception et exécution de structures résilientes et durables.'},
        {'title': 'Infrastructures', 'text': 'Routes, camps, réseaux et installations techniques pour les zones exigeantes.'},
        {'title': 'Solar Power Integration', 'text': 'Systèmes solaires pour l’alimentation fiable, durable et accessible de vos sites et installations.'},
        {'title': 'Conseil & management', 'text': 'Pilotage de projets, supervision et optimisation des performances.'},
      ];
    }

    return const [
      {'title': 'Civil construction', 'text': 'Design and execution of resilient, long-lasting structures.'},
      {'title': 'Infrastructure', 'text': 'Roads, camps, utilities and technical facilities for demanding environments.'},
      {'title': 'Solar Power Integration', 'text': 'Solar systems that deliver dependable, sustainable and accessible power for sites and facilities.'},
      {'title': 'Consulting & management', 'text': 'Project governance, supervision and performance optimization.'},
    ];
  }

  static List<Map<String, String>> projectCards(String language) {
    if (language == languageFr) {
      return const [
        {'title': 'Camp minier modulable', 'text': 'Logements et services conçus pour les environnements difficiles.'},
        {'title': 'Infrastructures routières', 'text': 'Solutions de mobilité et d’accès adaptées aux besoins opérationnels.'},
        {'title': 'Installations communautaires', 'text': 'Bâtiments publics et espaces utiles au développement local.'},
      ];
    }

    return const [
      {'title': 'Modular mining camp', 'text': 'Housing and support facilities designed for demanding environments.'},
      {'title': 'Road infrastructure', 'text': 'Mobility and access solutions adapted to operational needs.'},
      {'title': 'Community facilities', 'text': 'Public buildings and spaces that support local development.'},
    ];
  }

  static String servicesTitle(String language) {
    return language == languageFr ? 'Nos 4 services' : 'Our 4 Services';
  }

  static String servicesSubtitle(String language) {
    return language == languageFr
        ? 'Des solutions complètes pour la construction, l’infrastructure et les projets d’impact.'
        : 'Complete solutions for construction, infrastructure and high-impact projects.';
  }

  static String projectsTitle(String language) {
    return language == languageFr ? 'Projet phare' : 'Featured Project';
  }

  static String investorsTitle(String language) {
    return language == languageFr ? 'Investisseurs' : 'Investors';
  }

  static String contactTitle(String language) {
    return language == languageFr ? 'Contact' : 'Contact';
  }

  static String contactSubtitle(String language) {
    return language == languageFr
        ? 'Parlons de votre prochain projet.'
        : 'Let’s discuss your next project.';
  }

  static String contactEmail(String language) {
    return language == languageFr ? 'contact@casaget.com' : 'contact@casaget.com';
  }

  static String contactPhone(String language) {
    return language == languageFr ? '+243 000 000 000' : '+243 000 000 000';
  }

  static String footerLegal(String language) {
    return language == languageFr ? 'Mentions légales' : 'Legal notices';
  }

  static String footerRegistration(String language) {
    return language == languageFr
        ? 'RCCM : cd/KIN/RCCM/14-B-12345'
        : 'RCCM: cd/KIN/RCCM/14-B-12345';
  }

  static String footerAddress(String language) {
    return language == languageFr ? 'Adresse : Durba' : 'Address: Durba';
  }

  static String footerCopyright(String language) {
    return language == languageFr
        ? '© 2026 CASA GET SARL. Tous droits réservés.'
        : '© 2026 CASA GET SARL. All rights reserved.';
  }

  static String footerTagline(String language) {
    return language == languageFr
        ? 'Construisons vite, durablement pour le peuple africain.'
        : 'Build fast, sustainably for the African people.';
  }

  static String brandSubtitle(String language) {
    return language == languageFr
        ? 'Construction et infrastructures'
        : 'Construction & Infrastructures';
  }

  static String heroTitle(String language) {
    return language == languageFr
        ? 'Construisons vite, durable,\npour le peuple africain.'
        : 'Build fast, build sustainably,\nbuild for the African people.';
  }

  static String heroSubtitle(String language) {
    return language == languageFr
        ? 'Nous concevons des camps modulaires résilients et des infrastructures durables pour l’exploitation minière et les communautés à travers la RDC.'
        : 'Engineering resilient modular camps and sustainable infrastructure solutions for mining & communities across the DRC.';
  }

  static String primaryButton(String language) {
    return language == languageFr ? 'Nous contacter' : 'Contact Us';
  }

  static String secondaryButton(String language) {
    return language == languageFr ? 'Nos projets' : 'Our Projects';
  }
}
