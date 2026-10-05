import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Reusable bottom navigation bar matching the Uni-Sphere PDF design.
/// Features 4 main navigation tabs and a prominent central '+' action button.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNav({super.key, required this.currentIndex, this.onTap});

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/timetable');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/lost_found');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Uni-Sphere Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Direct access to campus tools & student resources',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 20),
              _buildActionTile(
                ctx,
                icon: Icons.search_rounded,
                title: 'Report / Find Lost Item',
                subtitle: 'Submit lost belongings to campus board',
                color: AppTheme.primaryBlue,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(context, '/lost_found');
                },
              ),
              _buildActionTile(
                ctx,
                icon: Icons.menu_book_rounded,
                title: 'Data Structures Course Hub',
                subtitle: 'Materials, slides & AI summary',
                color: AppTheme.primaryDarkNavy,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(context, '/course_detail');
                },
              ),
              _buildActionTile(
                ctx,
                icon: Icons.pie_chart_outline_rounded,
                title: 'Attendance & Performance',
                subtitle: 'Check 89% threshold & GPA analytics',
                color: AppTheme.safeGreen,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(context, '/attendance');
                },
              ),
              _buildActionTile(
                ctx,
                icon: Icons.calendar_today_rounded,
                title: 'Timetable & Class Schedule',
                subtitle: 'View lecture venues, timings & exam halls',
                color: AppTheme.cyan,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(context, '/timetable');
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.home_rounded,
                outlinedIcon: Icons.home_outlined,
                label: 'Home',
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.grid_view_rounded,
                outlinedIcon: Icons.grid_view,
                label: 'Timetable',
              ),
              // Prominent central '+' button matching PDF
              GestureDetector(
                onTap: () => _showQuickActionSheet(context),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2E232B),
                        Color(0xFF452A3B),
                        AppTheme.primaryDarkNavy,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E232B).withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.chat_bubble_rounded,
                outlinedIcon: Icons.chat_bubble_outline_rounded,
                label: 'Lost & Found',
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.person_rounded,
                outlinedIcon: Icons.person_outline_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData outlinedIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AppTheme.primaryDarkNavy : AppTheme.textMuted;

    return InkWell(
      onTap: () => _handleTap(context, index),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? icon : outlinedIcon, color: color, size: 24),
            const SizedBox(height: 2),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryDarkNavy
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
