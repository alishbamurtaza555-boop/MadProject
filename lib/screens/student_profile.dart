import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  String _activeTab = 'Badges'; // Portfolio, Badges, Settings
  bool _notifications = true;

  String _name = 'Zara Ahmed';
  String _major = 'Computer Science · 4th Semester';
  String _rollNo = 'Roll No. CS-21-0142 · NUCES';

  void _showEditProfileDialog() {
    final nameCtrl = TextEditingController(text: _name);
    final majorCtrl = TextEditingController(text: _major);
    final rollCtrl = TextEditingController(text: _rollNo);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Edit Student Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: majorCtrl,
                decoration: const InputDecoration(labelText: 'Program & Term'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: rollCtrl,
                decoration: const InputDecoration(labelText: 'Roll Number & Uni'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _name = nameCtrl.text;
                _major = majorCtrl.text;
                _rollNo = rollCtrl.text;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Top Bar
              _buildTopBar(),
              const SizedBox(height: 16),

              // Large Avatar "ZA"
              _buildAvatar(),
              const SizedBox(height: 14),

              // Student Info
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _major,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _rollNo,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 14),

              // Edit Profile Button
              OutlinedButton.icon(
                onPressed: _showEditProfileDialog,
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Edit Profile'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textDark,
                  side: const BorderSide(color: AppTheme.cardBorder, width: 1.2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                ),
              ),
              const SizedBox(height: 20),

              // 4-Column Stats Card
              _buildStatsCard(),
              const SizedBox(height: 20),

              // Segmented Tabs: Portfolio, Badges, Settings
              _buildSegmentedTabs(),
              const SizedBox(height: 18),

              // Tab Content
              if (_activeTab == 'Badges') ...[
                _buildBadgesRow(),
              ] else if (_activeTab == 'Portfolio') ...[
                _buildPortfolioSection(),
              ] else ...[
                _buildSettingsSection(),
              ],
              const SizedBox(height: 20),

              // Settings Cards matching PDF
              _buildSettingsCards(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              shape: BoxShape.circle,
              boxShadow: AppTheme.cardShadow,
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: AppTheme.textDark,
            ),
          ),
        ),
        const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 104,
      height: 104,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD4C9BF), width: 2),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF381F30),
              Color(0xFF5A2342),
              Color(0xFF2E222A),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'ZA',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildProfileStat('72', 'CREDITS'),
          _buildStatDivider(),
          _buildProfileStat('3.7', 'GPA', color: const Color(0xFFC84B5B)),
          _buildStatDivider(),
          _buildProfileStat('6', 'COURSES'),
          _buildStatDivider(),
          _buildProfileStat('14', 'BADGES'),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String val, String lbl, {Color? color}) {
    return Column(
      children: [
        Text(
          val,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color ?? AppTheme.textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          lbl,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 28,
      width: 1,
      color: AppTheme.cardBorder,
    );
  }

  Widget _buildSegmentedTabs() {
    final tabs = ['Portfolio', 'Badges', 'Settings'];

    return Row(
      children: tabs.map((tab) {
        final isSelected = _activeTab == tab;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _activeTab = tab;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2E222A) // Dark pill as in PDF
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTheme.pillRadius),
              ),
              child: Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBadgesRow() {
    return Row(
      children: [
        // Badge 1: Merit Scholar (orange/amber icon)
        Expanded(
          child: _buildBadgeCard(
            icon: Icons.military_tech_rounded,
            iconBg: const Color(0xFFE76F51),
            title: 'Merit Scholar',
            subtitle: 'Fall 2025',
          ),
        ),
        const SizedBox(width: 10),
        // Badge 2: Code Sprint Winner (dark icon)
        Expanded(
          child: _buildBadgeCard(
            icon: Icons.bolt,
            iconBg: const Color(0xFF2E222A),
            title: 'Code Sprint\nWinner',
            subtitle: 'Apr 2026',
          ),
        ),
        const SizedBox(width: 10),
        // Badge 3: 100% Attendance (slate icon)
        Expanded(
          child: _buildBadgeCard(
            icon: Icons.check,
            iconBg: const Color(0xFF38404B),
            title: '100% Attendance',
            subtitle: 'Sem 3',
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
              height: 1.15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Featured Student Projects',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            '• Uni-Sphere Campus Flutter Client (Lead UI)\n• AVL Balanced Search Visualizer (C++)\n• IoT Smart Library Seat Occupancy (Python/Flask)',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Academic & Campus Services',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.primaryDarkNavy.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.school_outlined,
                  color: AppTheme.primaryDarkNavy, size: 20),
            ),
            title: const Text('Degree Audit & Major Roadmap',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            subtitle: const Text('BS Computer Science · 72 of 120 credits',
                style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Degree Audit: 60% completion on track')),
              );
            },
          ),
          const Divider(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.safeGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.description_outlined,
                  color: AppTheme.safeGreen, size: 20),
            ),
            title: const Text('Official Grade Report & Transcript',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            subtitle: const Text('Download Fall 2026 certified PDF',
                style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transcript ready for download')),
              );
            },
          ),
          const Divider(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.support_agent_outlined,
                  color: AppTheme.primaryBlue, size: 20),
            ),
            title: const Text('Academic Advisor & Help Desk',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            subtitle: const Text('Dr. Sarah Khan · Office hours Mon 11 AM',
                style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contacting Academic Advisor...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCards() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: AppTheme.softShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 20,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    Text(
                      'Assignments & deadlines',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: _notifications,
                activeTrackColor: const Color(0xFF2E222A),
                onChanged: (val) {
                  setState(() {
                    _notifications = val;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
