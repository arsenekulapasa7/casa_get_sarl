import '../models/project_models.dart';
import '../services/content_store.dart';

class AppStrings {
  static const String languageEn = 'EN';
  static const String languageFr = 'FR';

  static List<String> navItems(String language) {
    if (language == languageFr) {
      return [
        'Accueil',
        'Services',
        'Projets',
        'Actualités',
        'Loisirs',
        'Contact',
      ];
    }

    return const ['Home', 'Services', 'Projects', 'News', 'Leisure', 'Contact'];
  }

  static List<String> sectionTitles(String language) {
    if (language == languageFr) {
      return ['À propos', 'Services', 'Projets', 'Loisirs', 'Blog', 'Contact'];
    }

    return ['About', 'Services', 'Projects', 'Leisure', 'Blog', 'Contact'];
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
          description:
              'Des escapades, randonnées et découvertes qui renforcent l’équilibre entre travail et bien-être.',
          icon: '🌿',
        ),
        LeisureHighlight(
          title: 'Culture & société',
          description:
              'Un regard sur les dynamiques locales, les traditions et les initiatives qui font avancer les communautés.',
          icon: '🎶',
        ),
        LeisureHighlight(
          title: 'Innovation & mode de vie',
          description:
              'Des inspirations pratiques pour mieux vivre, mieux construire et mieux accompagner les projets humains.',
          icon: '💡',
        ),
      ];
    }

    return const [
      LeisureHighlight(
        title: 'Nature & adventure',
        description:
            'Outings, hikes and discoveries that strengthen the balance between work and well-being.',
        icon: '🌿',
      ),
      LeisureHighlight(
        title: 'Culture & society',
        description:
            'A lens on local dynamics, traditions and initiatives driving community progress.',
        icon: '🎶',
      ),
      LeisureHighlight(
        title: 'Innovation & lifestyle',
        description:
            'Practical inspiration to live better, build better and support meaningful projects.',
        icon: '💡',
      ),
    ];
  }

  static List<BlogPost> blogPosts(String language) {
    if (language == languageFr) {
      return const [
        BlogPost(
          title:
              'Comment bâtir des structures durables au cœur des communautés',
          excerpt:
              'Une analyse des choix de conception et des bonnes pratiques qui favorisent la résilience.',
          category: 'Construction',
          date: '12 août 2026',
          readTime: '4 min',
        ),
        BlogPost(
          title:
              'L’importance d’une infrastructure locale pensée pour l’avenir',
          excerpt:
              'Les leviers qui permettent de créer des sites plus fonctionnels, plus sûrs et plus accessibles.',
          category: 'Infrastructure',
          date: '28 juillet 2026',
          readTime: '5 min',
        ),
        BlogPost(
          title: 'Quand l’innovation et les besoins terrain se rejoignent',
          excerpt:
              'Des idées concrètes pour concevoir des solutions qui répondent à des réalités très différentes.',
          category: 'Innovation',
          date: '10 juillet 2026',
          readTime: '3 min',
        ),
      ];
    }

    return const [
      BlogPost(
        title:
            'How to build sustainable structures at the heart of communities',
        excerpt:
            'A look at design choices and best practices that improve resilience and long-term value.',
        category: 'Construction',
        date: '12 Aug 2026',
        readTime: '4 min',
      ),
      BlogPost(
        title: 'Why local infrastructure must be designed for the future',
        excerpt:
            'The levers that create safer, more functional and more accessible work environments.',
        category: 'Infrastructure',
        date: '28 Jul 2026',
        readTime: '5 min',
      ),
      BlogPost(
        title: 'When innovation and field realities meet',
        excerpt:
            'Practical ideas for building solutions that respond to highly varied operational needs.',
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
        {
          'title': 'Expertise locale',
          'text':
              'Une compréhension fine des enjeux terrain et des besoins de nos clients.',
        },
        {
          'title': 'Qualité durable',
          'text': 'Des standards rigoureux et des matériaux conçus pour durer.',
        },
        {
          'title': 'Impact social',
          'text':
              'Des infrastructures pensées pour renforcer les communautés locales.',
        },
      ];
    }

    return const [
      {
        'title': 'Local expertise',
        'text': 'A deep understanding of field challenges and client needs.',
      },
      {
        'title': 'Sustainable quality',
        'text':
            'Strict standards and materials designed for long-term performance.',
      },
      {
        'title': 'Social impact',
        'text': 'Infrastructure designed to strengthen local communities.',
      },
    ];
  }

  static List<Map<String, String>> serviceCards(String language) {
    if (language == languageFr) {
      return const [
        {
          'title': 'Construction civile',
          'text':
              'Conception et exécution de structures résilientes et durables.',
        },
        {
          'title': 'Infrastructures',
          'text':
              'Routes, camps, réseaux et installations techniques pour les zones exigeantes.',
        },
        {
          'title': 'Solar Power Integration',
          'text':
              'Systèmes solaires pour l’alimentation fiable, durable et accessible de vos sites et installations.',
        },
        {
          'title': 'Conseil & management',
          'text':
              'Pilotage de projets, supervision et optimisation des performances.',
        },
        {
          'title': 'Crédit maison',
          'text':
              'Des solutions de financement pour concrétiser vos projets immobiliers.',
        },
      ];
    }

    return const [
      {
        'title': 'Civil construction',
        'text': 'Design and execution of resilient, long-lasting structures.',
      },
      {
        'title': 'Infrastructure',
        'text':
            'Roads, camps, utilities and technical facilities for demanding environments.',
      },
      {
        'title': 'Solar Power Integration',
        'text':
            'Solar systems that deliver dependable, sustainable and accessible power for sites and facilities.',
      },
      {
        'title': 'Consulting & management',
        'text': 'Project governance, supervision and performance optimization.',
      },
      {
        'title': 'Home financing',
        'text':
            'Financing solutions to help bring your property projects to life.',
      },
    ];
  }

  static List<Project> projectCards(String language) {
    if (language == languageFr) {
      return [
        Project(
          title: 'Camp minier modulable',
          summary:
              'Logements et services conçus pour les environnements difficiles.',
          description:
              'Ce projet propose une solution modulaire complète pour accueillir les équipes et les services essentiels sur un site minier. Les espaces sont pensés pour être installés rapidement, entretenus facilement et adaptés aux contraintes du terrain.\n\nLe camp intègre des logements, des espaces communs et des zones de service afin d’offrir un environnement fonctionnel, sûr et durable aux équipes opérationnelles.',
          imagePath: _projectImage(0, 'images/Projet/projet.jpeg'),
          gallery: ['images/Projet/projet.jpeg', 'images/Projet/projet 2.jpeg'],
        ),
        Project(
          title: 'Infrastructures routières',
          summary:
              'Solutions de mobilité et d’accès adaptées aux besoins opérationnels.',
          description:
              'Ce projet accompagne l’amélioration des accès et de la mobilité autour des zones d’activité. L’approche tient compte des flux, de la résistance des ouvrages et des besoins des usagers.\n\nLes travaux visent à rendre les déplacements plus sûrs et plus réguliers, tout en renforçant la liaison entre les sites de production, les communautés et les services essentiels.',
          imagePath: _projectImage(1, 'images/Projet/projet 2.jpeg'),
          gallery: [
            'images/Projet/projet 2.jpeg',
            'images/Projet/project.jpeg',
          ],
        ),
        Project(
          title: 'Installations communautaires',
          summary:
              'Bâtiments publics et espaces utiles au développement local.',
          description:
              'Ces installations sont conçues pour répondre aux besoins concrets des communautés locales. Elles offrent des espaces accessibles, fonctionnels et adaptés aux activités éducatives, sociales et administratives.\n\nChaque intervention cherche à créer une valeur durable pour les habitants en associant qualité de construction, simplicité d’usage et intégration dans l’environnement local.',
          imagePath: _projectImage(2, 'images/Projet/project.jpeg'),
          gallery: ['images/Projet/project.jpeg', 'images/Projet/proj.jpeg'],
        ),
      ];
    }

    return [
      Project(
        title: 'Modular mining camp',
        summary:
            'Housing and support facilities designed for demanding environments.',
        description:
            'This project delivers a complete modular solution for teams and essential services on a mining site. The spaces are designed for fast installation, easy maintenance and adaptation to demanding field conditions.\n\nThe camp includes housing, shared spaces and service areas to provide a functional, safe and sustainable environment for operational teams.',
        imagePath: _projectImage(0, 'images/Projet/projet.jpeg'),
        gallery: ['images/Projet/projet.jpeg', 'images/Projet/projet 2.jpeg'],
      ),
      Project(
        title: 'Road infrastructure',
        summary: 'Mobility and access solutions adapted to operational needs.',
        description:
            'This project improves access and mobility around activity areas. The approach considers traffic flows, structural resilience and the needs of all users.\n\nThe work makes travel safer and more reliable while strengthening connections between production sites, communities and essential services.',
        imagePath: _projectImage(1, 'images/Projet/projet 2.jpeg'),
        gallery: ['images/Projet/projet 2.jpeg', 'images/Projet/project.jpeg'],
      ),
      Project(
        title: 'Community facilities',
        summary: 'Public buildings and spaces that support local development.',
        description:
            'These facilities are designed around the practical needs of local communities. They provide accessible, functional spaces suited to educational, social and administrative activities.\n\nEach intervention aims to create lasting value by combining construction quality, ease of use and integration with the local environment.',
        imagePath: _projectImage(2, 'images/Projet/project.jpeg'),
        gallery: ['images/Projet/project.jpeg', 'images/Projet/proj.jpeg'],
      ),
    ];
  }

  static String servicesTitle(String language) {
    return language == languageFr ? 'Nos 4 services' : 'Our 5 Services';
  }

  static String _projectImage(int index, String fallback) {
    final value = ContentStore.instance.value('project.image_$index');
    return value.isEmpty ? fallback : value;
  }

  static String servicesSubtitle(String language) {
    return language == languageFr
        ? 'Des solutions complètes pour la construction, l’infrastructure et les projets d’impact.'
        : 'Complete solutions for construction, infrastructure and high-impact projects.';
  }

  static String projectsTitle(String language) {
    return language == languageFr ? 'Projet phare' : 'Featured Project';
  }

  static String newsTitle(String language) {
    return language == languageFr ? 'Nos actualités' : 'Our News';
  }

  static String newsSubtitle(String language) {
    return language == languageFr
        ? 'Les dernières nouvelles de nos formations, de nos réussites et de nos initiatives pour la jeunesse.'
        : 'The latest news about our training programs, achievements and initiatives for young people.';
  }

  static List<BlogPost> newsPosts(String language) {
    if (language == languageFr) {
      final posts = <BlogPost>[
        BlogPost(
          title: 'Nouvelle session de formation en informatique',
          excerpt:
              'Les inscriptions sont ouvertes pour une formation pratique en bureautique, numérique et outils professionnels.',
          content:
              'CASA GET ouvre une nouvelle session de formation en informatique destinée aux jeunes, aux étudiants et à toute personne souhaitant renforcer ses compétences numériques.\n\nLa formation couvre la bureautique, la navigation professionnelle, la création de documents et les outils numériques utilisés au quotidien dans les entreprises. Les participants bénéficient d’un accompagnement pratique et progressif, adapté à leur niveau.\n\nLes places étant limitées, les inscriptions sont ouvertes dès maintenant auprès de notre équipe.',
          category: 'Formation',
          date: '05 sept. 2026',
          readTime: '3 min',
          imagePath: 'images/Projet/projet.jpeg',
        ),
        BlogPost(
          title: 'Célébration de la remise des certificats',
          excerpt:
              'CASA GET félicite les apprenants pour leur engagement et leur parcours vers de nouvelles opportunités.',
          content:
              'La cérémonie de remise des certificats a réuni les apprenants, leurs familles et l’équipe de CASA GET autour d’un moment de fierté et de partage.\n\nCes certificats récompensent plusieurs semaines de travail, de présence et de progression. Ils représentent une étape importante pour les bénéficiaires qui souhaitent poursuivre leurs études, intégrer le monde professionnel ou développer leur propre activité.\n\nNous adressons toutes nos félicitations aux lauréats et leur souhaitons beaucoup de réussite pour la suite.',
          category: 'Réussite',
          date: '22 août 2026',
          readTime: '2 min',
          imagePath: 'images/Projet/projet 2.jpeg',
        ),
        BlogPost(
          title: 'L’école de football prépare sa nouvelle saison',
          excerpt:
              'Les jeunes talents se retrouvent autour du sport, de la discipline et d’un accompagnement de qualité.',
          content:
              'L’école de football prépare activement sa nouvelle saison avec une ambition claire : accompagner les jeunes talents dans leur progression sportive et humaine.\n\nLes entraînements mettent l’accent sur la technique, la condition physique, l’esprit d’équipe et le respect. Chaque jeune est encouragé à développer son potentiel dans un cadre structuré, tout en poursuivant ses efforts à l’école.\n\nLa nouvelle saison sera également l’occasion de renforcer les rencontres sportives et les activités qui rapprochent l’académie des familles et de la communauté.',
          category: 'École de foot',
          date: '14 août 2026',
          readTime: '4 min',
          imagePath: 'images/logofoot.jpeg',
        ),
      ];
      return _appendAdminNews(posts, language);
    }

    final posts = <BlogPost>[
      BlogPost(
        title: 'New computer training session',
        excerpt:
            'Registration is open for practical training in office tools, digital skills and professional software.',
        content:
            'CASA GET is opening a new computer training session for young people, students and anyone looking to strengthen their digital skills.\n\nThe program covers office tools, professional browsing, document creation and the digital solutions used every day by organizations. Participants receive practical and progressive support adapted to their level.\n\nPlaces are limited, and registration is now open through our team.',
        category: 'Training',
        date: '05 Sep 2026',
        readTime: '3 min',
        imagePath: 'images/Projet/projet.jpeg',
      ),
      BlogPost(
        title: 'Celebrating our certificate graduates',
        excerpt:
            'CASA GET congratulates every learner for their commitment and journey toward new opportunities.',
        content:
            'The certificate ceremony brought learners, families and the CASA GET team together for a proud moment of recognition and sharing.\n\nThese certificates celebrate several weeks of work, attendance and progress. They are an important step for beneficiaries who want to continue their studies, enter the professional world or develop their own activity.\n\nWe congratulate every graduate and wish them continued success.',
        category: 'Achievement',
        date: '22 Aug 2026',
        readTime: '2 min',
        imagePath: 'images/Projet/projet 2.jpeg',
      ),
      BlogPost(
        title: 'The football academy prepares for a new season',
        excerpt:
            'Young talents come together through sport, discipline and quality coaching and support.',
        content:
            'The football academy is actively preparing for its new season with a clear ambition: supporting young talents in their sporting and personal development.\n\nTraining focuses on technique, fitness, teamwork and respect. Every young player is encouraged to develop their potential in a structured environment while continuing to work hard at school.\n\nThe new season will also strengthen sporting encounters and activities that bring the academy closer to families and the community.',
        category: 'Football academy',
        date: '14 Aug 2026',
        readTime: '4 min',
        imagePath: 'images/logofoot.jpeg',
      ),
    ];
    return _appendAdminNews(posts, language);
  }

  static List<BlogPost> _appendAdminNews(
    List<BlogPost> posts,
    String language,
  ) {
    final prefix = language == languageFr ? 'fr' : 'en';
    final title = ContentStore.instance.value('news.$prefix.title');
    final excerpt = ContentStore.instance.value('news.$prefix.excerpt');
    final image = ContentStore.instance.value('news.$prefix.image');
    if (title.isEmpty || excerpt.isEmpty || image.isEmpty) return posts;

    final adminPost = BlogPost(
      title: title,
      excerpt: excerpt,
      content: excerpt,
      category: language == languageFr ? 'Actualité' : 'News',
      date: ContentStore.instance.value('news.$prefix.date'),
      readTime: '2 min',
      imagePath: image,
    );

    final allPosts = [adminPost, ...posts];
    return allPosts.length > 3 ? allPosts.take(3).toList() : allPosts;
  }

  static String leisureVideo(int index, String fallback) {
    final value = ContentStore.instance.value('leisure.video_$index');
    return value.isEmpty ? fallback : value;
  }

  static String leisureVideoDescription(int index, String fallback) {
    final value = ContentStore.instance.value(
      'leisure.video_description_$index',
    );
    return value.isEmpty ? fallback : value;
  }

  static String investorsTitle(String language) {
    return language == languageFr ? 'Investisseurs' : 'Investors';
  }

  static String contactTitle(String language) {
    return language == languageFr ? 'Contact' : 'Contact';
  }

  static String contactSubtitle(String language) {
    final saved = language == languageFr
        ? ContentStore.instance.contactSubtitleFr
        : ContentStore.instance.contactSubtitleEn;
    return saved.isNotEmpty
        ? saved
        : language == languageFr
        ? 'Parlons de votre prochain projet.'
        : 'Let’s discuss your next project.';
  }

  static String contactEmail(String language) {
    return language == languageFr ? 'contact@casaget.cd' : 'contact@casaget.cd';
  }

  static String contactPhone(String language) {
    return language == languageFr
        ? '+243 815 887 612/+243 988 431 960'
        : '+243 815 887 612/+243 988 431 960';
  }

  static String footerLegal(String language) {
    return language == languageFr ? 'Mentions légales' : 'Legal notices';
  }

  static String footerRegistration(String language) {
    return language == languageFr
        ? 'RCCM : CD/KIN/RCCM/14-B-12345'
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
    final saved = language == languageFr
        ? ContentStore.instance.heroTitleFr
        : ContentStore.instance.heroTitleEn;
    return saved.isNotEmpty
        ? saved
        : language == languageFr
        ? 'Construisons vite, durable,\npour le peuple africain.'
        : 'Build fast, build sustainably,\nbuild for the African people.';
  }

  static String heroSubtitle(String language) {
    final saved = language == languageFr
        ? ContentStore.instance.heroSubtitleFr
        : ContentStore.instance.heroSubtitleEn;
    return saved.isNotEmpty
        ? saved
        : language == languageFr
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
