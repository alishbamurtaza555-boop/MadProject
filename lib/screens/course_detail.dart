import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseCode;
  final String courseTitle;
  final String instructor;

  const CourseDetailScreen({
    super.key,
    this.courseCode = 'CS · 301 · 4th Semester',
    this.courseTitle = 'Data Structures',
    this.instructor = 'Dr. Sarah Khan · Mon, Wed, Fri 8:00 AM',
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAiSummaryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryDarkNavy,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.auto_awesome,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uni-AI Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        'Lecture 01-05: Tree Traversal Algorithms',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(height: 28),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAiSummaryBullet(
                      'Core Concept',
                      'Trees are non-linear, hierarchical data structures. Unlike arrays or linked lists, traversal visits nodes hierarchically instead of linearly.',
                    ),
                    const SizedBox(height: 14),
                    _buildAiSummaryBullet(
                      'DFS (Depth-First Search)',
                      'Includes Inorder (Left-Root-Right), Preorder (Root-Left-Right), and Postorder (Left-Right-Root). Typically implemented with Call Stack or recursion.',
                    ),
                    const SizedBox(height: 14),
                    _buildAiSummaryBullet(
                      'BFS (Breadth-First Search)',
                      'Traverses level-by-level using a FIFO Queue. Time Complexity is O(V + E), ideal for finding shortest unweighted paths.',
                    ),
                    const SizedBox(height: 14),
                    _buildAiSummaryBullet(
                      'Key Exam Takeaways',
                      'Remember that Inorder traversal of a Binary Search Tree (BST) produces strictly sorted keys in ascending order.',
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.safeGreenLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppTheme.safeGreen.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.lightbulb_outline,
                              color: AppTheme.safeGreen),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Tip: Review Practice Problem 5.2 on Page 84 before tomorrow\'s lab.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E564E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiSummaryBullet(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryDarkNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textDark,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Dark Header Card
            _buildTopCourseBanner(),

            // Tab Bar
            _buildTabBar(),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSyllabusTab(),
                  _buildMaterialsTab(),
                  _buildAssignmentsTab(),
                  _buildExamsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: -1),
    );
  }

  Widget _buildTopCourseBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF261922),
            Color(0xFF381F30),
            Color(0xFF1A1F3A),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button Pill
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(AppTheme.pillRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Course Code
          Text(
            widget.courseCode,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),

          // Course Title
          Text(
            widget.courseTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),

          // Instructor & Schedule
          Text(
            widget.instructor,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 14),

          // Badges row: Active Course, 3 Credit Hours, 70% Done
          Row(
            children: [
              _buildCourseBadge(
                'Active Course',
                textColor: const Color(0xFF64DFDF),
                bgColor: Colors.white.withOpacity(0.12),
              ),
              const SizedBox(width: 8),
              _buildCourseBadge(
                '3 Credit Hours',
                textColor: Colors.white.withOpacity(0.9),
                bgColor: Colors.white.withOpacity(0.12),
              ),
              const SizedBox(width: 8),
              _buildCourseBadge(
                '70% Done',
                textColor: Colors.white.withOpacity(0.8),
                bgColor: Colors.white.withOpacity(0.12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseBadge(String text,
      {required Color textColor, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppTheme.pillRadius),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppTheme.backgroundLight,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF2E232B),
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: const Color(0xFF8C3A56),
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        tabs: const [
          Tab(text: 'Syllabus'),
          Tab(text: 'Materials'),
          Tab(text: 'Assignments'),
          Tab(text: 'Exams'),
        ],
      ),
    );
  }

  Widget _buildMaterialsTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item 1: PDF
          _buildMaterialCard(
            fileType: 'PDF',
            badgeBgColor: const Color(0xFFE54B4B),
            fileName: 'Lecture 01–05 — Trees &\nGraphs.pdf',
            meta: '2.4 MB · Week 1–3',
            actionIcon: Icons.arrow_downward_rounded,
          ),
          const SizedBox(height: 12),

          // Item 2: PPTX
          _buildMaterialCard(
            fileType: 'PPTX',
            badgeBgColor: const Color(0xFFE76F51),
            fileName: 'Week 4 Slides — Hash\nTables.pptx',
            meta: '5.1 MB · Week 4',
            actionIcon: Icons.arrow_downward_rounded,
          ),
          const SizedBox(height: 12),

          // Item 3: MP4
          _buildMaterialCard(
            fileType: 'MP4',
            badgeBgColor: const Color(0xFF2E222A),
            fileName: 'Recorded Lecture — BFS & DFS',
            meta: '142 MB · 48 min · Week 5',
            actionIcon: Icons.play_arrow_rounded,
          ),
          const SizedBox(height: 18),

          // Quick Preview Card matching PDF
          _buildQuickPreviewCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMaterialCard({
    required String fileType,
    required Color badgeBgColor,
    required String fileName,
    required String meta,
    required IconData actionIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        children: [
          // File format square tag
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                fileType,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Action button (Download / Play)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.cardBorder),
              shape: BoxShape.circle,
            ),
            child: Icon(
              actionIcon,
              size: 20,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.description_outlined,
                      size: 18, color: AppTheme.textDark),
                  SizedBox(width: 8),
                  Text(
                    'Quick Preview',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
              const Text(
                'Lecture 01–\n05.pdf',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                  height: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Preview content box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F1EC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Chapter 5: Tree Traversal Algorithms',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Trees are hierarchical data structures with a root node and subtrees of children... Tap "Ask AI" to get a full summary.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Ask AI Button matching PDF
          GestureDetector(
            onTap: _showAiSummaryModal,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E222A),
                    Color(0xFF5A2744),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5A2744).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Ask AI to Summarize',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllabusTab() {
    final modules = [
      {'title': 'Module 1: Asymptotic Analysis', 'weeks': 'Week 1–2', 'done': true},
      {'title': 'Module 2: Linked Lists & Stacks', 'weeks': 'Week 3–4', 'done': true},
      {'title': 'Module 3: Queues & Heaps', 'weeks': 'Week 5–6', 'done': true},
      {'title': 'Module 4: Trees, BST & AVL', 'weeks': 'Week 7–9', 'done': false},
      {'title': 'Module 5: Graphs, BFS & DFS', 'weeks': 'Week 10–13', 'done': false},
      {'title': 'Module 6: Dynamic Programming', 'weeks': 'Week 14–16', 'done': false},
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: modules.length,
      itemBuilder: (ctx, i) {
        final item = modules[i];
        final done = item['done'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: AppTheme.softShadow,
          ),
          child: Row(
            children: [
              Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? AppTheme.safeGreen : AppTheme.textMuted,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item['weeks'] as String,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssignmentsTab() {
    final assignments = [
      {
        'title': 'Lab 5: Balanced BST & AVL Rotation',
        'due': 'Tomorrow · 11:59 PM',
        'status': 'Urgent',
        'isUrgent': true,
      },
      {
        'title': 'Programming Project 1: Graph Pathfinding',
        'due': 'Oct 12 · 11:59 PM',
        'status': 'Pending',
        'isUrgent': false,
      },
      {
        'title': 'Assignment 2: Hash Collision Resolution',
        'due': 'Submitted',
        'status': 'Graded 94/100',
        'isUrgent': false,
      },
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (ctx, i) {
        final a = assignments[i];
        final isUrgent = a['isUrgent'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: AppTheme.softShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      a['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUrgent
                          ? AppTheme.urgentRedLight
                          : AppTheme.surfaceWarm,
                      borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                    ),
                    child: Text(
                      a['status'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isUrgent
                            ? AppTheme.urgentRed
                            : AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Due: ${a['due']}',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExamsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Midterm Exam',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.urgentRedLight,
                        borderRadius:
                            BorderRadius.circular(AppTheme.pillRadius),
                      ),
                      child: const Text(
                        '3 days left',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.urgentRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Date: Sep 21, 2026 · 09:00 AM\nVenue: Hall B · Seat 42',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.school, size: 16),
                  label: const Text('Download Past Papers'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
