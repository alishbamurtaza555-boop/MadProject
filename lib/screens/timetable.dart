import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDayIndex = 3; // THU 18 by default as in PDF

  final List<Map<String, String>> _days = [
    {'day': 'MON', 'date': '15'},
    {'day': 'TUE', 'date': '16'},
    {'day': 'WED', 'date': '17'},
    {'day': 'THU', 'date': '18'},
    {'day': 'FRI', 'date': '19'},
    {'day': 'SAT', 'date': '20'},
    {'day': 'SUN', 'date': '21'},
  ];

  void _showPrepModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const Text(
              'Exam Prep · Data Structures Mid',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Sep 21, 2026 · Hall B · Seat 42',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            _buildPrepChecklistItem(
              'Review BST Rotations & AVL balancing rules',
              true,
            ),
            _buildPrepChecklistItem(
              'Re-solve Lab 3 & 4 recursion problem sets',
              true,
            ),
            _buildPrepChecklistItem(
              'Print Student Roll Slip (CS-21-0142)',
              false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: AppTheme.primaryDarkNavy,
              ),
              child: const Text('Got it, ready to prep'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrepChecklistItem(String title, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: checked ? AppTheme.safeGreen : AppTheme.textMuted,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textDark,
                decoration: checked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 18),

              // Horizontal Days Bar
              _buildDaysBar(),
              const SizedBox(height: 24),

              // Today's Schedule Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Schedule",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Text(
                    '3 classes',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Class 1: 08:00 Data Structures (Done)
              _buildScheduleRow(
                timeLabel: '08:00',
                title: 'Data Structures',
                instructor: 'LT-04 · Dr. Sarah Khan',
                timing: '08:00 – 09:30 AM',
                badgeText: 'Done',
                badgeTextColor: AppTheme.textSecondary,
                badgeBgColor: const Color(0xFFE8E5DF),
              ),
              const SizedBox(height: 16),

              // Class 2: 10:00 UI/UX Design (Now)
              _buildScheduleRow(
                timeLabel: '10:00',
                title: 'UI/UX Design',
                instructor: 'Lab-2B · Dr. Aisha Raza',
                timing: '10:00 – 11:30 AM · Room 2B, CS Block',
                badgeText: 'Now',
                badgeTextColor: Colors.white,
                badgeBgColor: const Color(0xFF2E222A),
                isCurrent: true,
              ),
              const SizedBox(height: 16),

              // Class 3: 13:00 Computer Networks (Next)
              _buildScheduleRow(
                timeLabel: '13:00',
                title: 'Computer Networks',
                instructor: 'LT-01 · Prof. M. Asif',
                timing: '01:00 – 02:30 PM',
                badgeText: 'Next',
                badgeTextColor: const Color(0xFF1E7B68),
                badgeBgColor: const Color(0xFFE2F4EE),
              ),
              const SizedBox(height: 24),

              // Upcoming Exam Card
              _buildUpcomingExamCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Fall 2026',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Timetable',
          style: TextStyle(
            color: AppTheme.textDark,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDaysBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_days.length, (index) {
        final isSelected = _selectedDayIndex == index;
        final d = _days[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDayIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2E222A) : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Text(
                  d['day']!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.8)
                        : AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  d['date']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScheduleRow({
    required String timeLabel,
    required String title,
    required String instructor,
    required String timing,
    required String badgeText,
    required Color badgeTextColor,
    required Color badgeBgColor,
    bool isCurrent = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left time column
        SizedBox(
          width: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              timeLabel,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: isCurrent ? AppTheme.textDark : AppTheme.textSecondary,
              ),
            ),
          ),
        ),
        // Class card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2E222A).withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : AppTheme.softShadow,
              border: isCurrent
                  ? Border.all(
                      color: const Color(0xFF2E222A).withValues(alpha: 0.15),
                      width: 1.2,
                    )
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(
                          AppTheme.pillRadius,
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: badgeTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  instructor,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timing,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingExamCard() {
    return Container(
      width: double.infinity,
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
                'UPCOMING EXAM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: AppTheme.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF4ED),
                  borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                ),
                child: const Text(
                  '3 days left',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFD47C2F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Calendar icon in dark square
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A1A2E), // Wine dark square as in PDF
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Data Structures Mid',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Sep 21 · Hall B · Seat 42',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Prep Button
              TextButton(
                onPressed: _showPrepModal,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  backgroundColor: AppTheme.backgroundLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.pillRadius),
                  ),
                ),
                child: const Text(
                  'Prep',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
