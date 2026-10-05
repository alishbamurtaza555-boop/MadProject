import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uni_sphere/screens/student_dashboard.dart';
import 'package:uni_sphere/screens/course_detail.dart';
import 'package:uni_sphere/screens/attendance_performance.dart';
import 'package:uni_sphere/screens/timetable.dart';
import 'package:uni_sphere/screens/lost_found.dart';
import 'package:uni_sphere/screens/student_profile.dart';

void main() {
  testWidgets('All 6 student screens instantiate and render properly',
      (WidgetTester tester) async {
    // 1. Dashboard
    await tester.pumpWidget(const MaterialApp(home: StudentDashboardScreen()));
    expect(find.text('Hello, Zara!'), findsOneWidget);

    // 2. Course Detail
    await tester.pumpWidget(const MaterialApp(home: CourseDetailScreen()));
    expect(find.text('Data Structures'), findsOneWidget);
    expect(find.text('Materials'), findsOneWidget);

    // 3. Attendance & Performance
    await tester.pumpWidget(const MaterialApp(home: AttendancePerformanceScreen()));
    expect(find.text('Performance'), findsOneWidget);
    expect(find.text('ATTENDANCE OVERVIEW'), findsOneWidget);

    // 4. Timetable
    await tester.pumpWidget(const MaterialApp(home: TimetableScreen()));
    expect(find.text('Timetable'), findsOneWidget);
    expect(find.text("Today's Schedule"), findsOneWidget);

    // 5. Lost & Found
    await tester.pumpWidget(const MaterialApp(home: LostFoundScreen()));
    expect(find.text('Lost & Found'), findsOneWidget);
    expect(find.text('Campus Board'), findsOneWidget);

    // 6. Student Profile
    await tester.pumpWidget(const MaterialApp(home: StudentProfileScreen()));
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Zara Ahmed'), findsOneWidget);
  });
}
