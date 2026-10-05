import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/student_dashboard.dart';
import 'screens/course_detail.dart';
import 'screens/attendance_performance.dart';
import 'screens/timetable.dart';
import 'screens/lost_found.dart';
import 'screens/student_profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar styling to match the clean light theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const UniSphereApp());
}

class UniSphereApp extends StatelessWidget {
  const UniSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni-Sphere',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/dashboard',
      builder: (context, child) {
        // Professional mobile responsive wrapper:
        // Keeps phone proportions centered when running on Chrome/desktop,
        // and scales naturally to 100% width on mobile screens.
        return Container(
          color: const Color(0xFFE4E1DB),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: ClipRect(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
      routes: {
        '/': (context) => const StudentDashboardScreen(),
        '/dashboard': (context) => const StudentDashboardScreen(),
        '/course_detail': (context) => const CourseDetailScreen(),
        '/attendance': (context) => const AttendancePerformanceScreen(),
        '/timetable': (context) => const TimetableScreen(),
        '/lost_found': (context) => const LostFoundScreen(),
        '/profile': (context) => const StudentProfileScreen(),
      },
    );
  }
}
