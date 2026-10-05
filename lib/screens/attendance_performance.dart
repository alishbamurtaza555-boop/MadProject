import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class AttendancePerformanceScreen extends StatelessWidget {
  const AttendancePerformanceScreen({super.key});

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
              // Header Row with Close 'X' button
              _buildHeader(context),
              const SizedBox(height: 18),

              // Attendance Overview Card
              _buildAttendanceOverviewCard(),
              const SizedBox(height: 22),

              // Subject Breakdown Heading
              const Text(
                'Subject Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14),

              // Subject 1: Data Structures
              _buildSubjectCard(
                title: 'Data Structures',
                grade: 'A- · 3.7',
                attendancePercent: 0.82,
                attendanceText: '82% attendance · 78/100 marks',
                progressColor: const Color(0xFF9C6644), // Warm amber/brown as in PDF
              ),
              const SizedBox(height: 12),

              // Subject 2: UI/UX Design
              _buildSubjectCard(
                title: 'UI/UX Design',
                grade: 'A · 4.0',
                attendancePercent: 0.95,
                attendanceText: '95% attendance · 91/100 marks',
                progressColor: const Color(0xFFC6A15B), // Golden tan as in PDF
              ),
              const SizedBox(height: 12),

              // Subject 3: Computer Networks (attendance risk)
              _buildSubjectCard(
                title: 'Computer Networks',
                grade: 'B+ · 3.3',
                attendancePercent: 0.68,
                attendanceText: '68% attendance · 65/100 marks',
                progressColor: const Color(0xFFD64560), // Warning coral/pink
                isWarning: true,
              ),
              const SizedBox(height: 20),

              // AI Study Tip Card matching PDF
              _buildAiStudyTipCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: -1),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Semester 6 · Fall 2026',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Performance',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        // Close 'X' Button in soft rounded circle
        GestureDetector(
          onTap: () => Navigator.pop(context),
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
              Icons.close_rounded,
              color: AppTheme.textDark,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ATTENDANCE OVERVIEW',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Circular progress dial
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: _AttendanceRingPainter(
                    percentage: 0.89,
                    progressColor: const Color(0xFF9D654E), // Match PDF brown/terracotta
                    backgroundColor: const Color(0xFFEBE6DD),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '89%',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Attended',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 28),
              // Stats on right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Present',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '89 / 100',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF9D654E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Absent',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '11 days',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4A1A2E), // Dark wine as in PDF
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // SAFE ZONE pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7F2),
                        borderRadius:
                            BorderRadius.circular(AppTheme.pillRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'SAFE ZONE',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: Color(0xFF1E7B68),
                            ),
                          ),
                          Text(
                            'Min 75% required',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E7B68),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard({
    required String title,
    required String grade,
    required double attendancePercent,
    required String attendanceText,
    required Color progressColor,
    bool isWarning = false,
  }) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                grade,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isWarning
                      ? const Color(0xFFD64560)
                      : AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: attendancePercent,
              minHeight: 6,
              backgroundColor: const Color(0xFFEDE8E1),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            attendanceText,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiStudyTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF2E222A),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.layers_outlined,
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
                  'AI STUDY TIP',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your Networks attendance is at risk. Attend next 3 lectures to stay above 75% threshold.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textDark,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the circular progress gauge matching the PDF
class _AttendanceRingPainter extends CustomPainter {
  final double percentage;
  final Color progressColor;
  final Color backgroundColor;

  _AttendanceRingPainter({
    required this.percentage,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle track
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from -90 degrees (top)
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AttendanceRingPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.progressColor != progressColor;
  }
}
