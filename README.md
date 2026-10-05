# Uni-Sphere — Student Section (Mobile App)

A modern, responsive university mobile application built with **Flutter** and **Dart** using **Material 3**. Designed to follow the **Uni-Sphere** design specifications.

---

## 🎨 Theme & Color Palette

Defined in [`lib/theme/app_theme.dart`](lib/theme/app_theme.dart):

* **Primary Dark Navy**: `#03045E`
* **Primary Blue**: `#0077B6`
* **Cyan**: `#00B4D8`
* **Light Cyan**: `#90E0EF`
* **Very Light Cyan**: `#CAF0F8`
* **Warm Canvas Background**: `#F7F5F0` (matches the PDF soft oat/cream background)
* **Surface White**: `#FFFFFF` with 22px rounded corners and ambient soft drop-shadows

---

## 📱 The 6 Student Screens

### 1. Student Dashboard ([`lib/screens/student_dashboard.dart`](lib/screens/student_dashboard.dart))
* **Header**: "Friday, Sep 18", "Hello, Zara!", "3 tasks due today · Stay focused", circular avatar `ZA`, notification bell with badge.
* **Academic Highlights**:
  * `72` Credits of 120
  * `3.7` GPA (Dean's List)
  * `89%` Attendance (This term) — *Tapping navigates to Attendance & Performance*.
* **Weekly Date Selector**: Days row (M 15 through S 21) with active dark pill on THU 18.
* **My Courses**:
  * `CS · 301` — Data Structures (Dr. Sarah Khan, 70% Complete) — *Tapping navigates to Course Detail*.
  * `DES · 205` — UI/UX Design (Prof. M. Chen, 45% Complete).
* **AI Insights**:
  * Assignment Due Tomorrow (Data Structures Lab · 11:59 PM, Urgent)
  * Exam Reminder (Algorithms Final · Nov 15 at 9:00 AM, 28 days)
  * Class Starting Soon (UI/UX Workshop · Today at 2:00 PM, 2h away)
* **Bottom Navigation**: Docked floating bar with Home active.

---

### 2. Course Detail ([`lib/screens/course_detail.dart`](lib/screens/course_detail.dart))
* **Header Banner**: Dark gradient card with `< Back` button, `CS · 301 · 4th Semester`, `Data Structures`, `Dr. Sarah Khan · Mon, Wed, Fri 8:00 AM`, and badges: *Active Course*, *3 Credit Hours*, *70% Done*.
* **Interactive Tabs**: `Syllabus`, `Materials` (active), `Assignments`, `Exams`.
* **Materials List**:
  * `PDF`: Lecture 01-05 — Trees & Graphs.pdf (2.4 MB · Week 1–3)
  * `PPTX`: Week 4 Slides — Hash Tables.pptx (5.1 MB · Week 4)
  * `MP4`: Recorded Lecture — BFS & DFS (142 MB · 48 min · Week 5)
* **Quick Preview Card**: Chapter 5: Tree Traversal Algorithms with preview excerpt.
* **Ask AI to Summarize**: Interactive button opening a bottom sheet with structured bullet summaries and study takeaways.

---

### 3. Attendance & Performance ([`lib/screens/attendance_performance.dart`](lib/screens/attendance_performance.dart))
* **Header**: `Semester 6 · Fall 2026`, `Performance`, and `✕` close button.
* **Attendance Overview**:
  * Circular progress ring showing `89% Attended`.
  * `Present 89 / 100` and `Absent 11 days`.
  * `SAFE ZONE` badge with `Min 75% required`.
* **Subject Breakdown**:
  * `Data Structures`: A- · 3.7 | 82% attendance · 78/100 marks (visual progress bar)
  * `UI/UX Design`: A · 4.0 | 95% attendance · 91/100 marks (visual progress bar)
  * `Computer Networks`: B+ · 3.3 | 68% attendance · 65/100 marks (coral warning bar)
* **AI Study Tip**: Attendance risk warning for Computer Networks ("Attend next 3 lectures to stay above 75% threshold").

---

### 4. Timetable ([`lib/screens/timetable.dart`](lib/screens/timetable.dart))
* **Header**: `Fall 2026`, `Timetable`.
* **Day Selector**: MON 15, TUE 16, WED 17, THU 18 (active pill), FRI 19, SAT 20, SUN 21.
* **Today's Schedule (3 classes)**:
  * `08:00` — Data Structures (LT-04 · Dr. Sarah Khan · Done · 08:00 – 09:30 AM)
  * `10:00` — UI/UX Design (Lab-2B · Dr. Aisha Raza · Now · 10:00 – 11:30 AM)
  * `13:00` — Computer Networks (LT-01 · Prof. M. Asif · Next · 01:00 – 02:30 PM)
* **Upcoming Exam Card**:
  * Calendar icon, `Data Structures Mid` (Sep 21 · Hall B · Seat 42), `3 days left`, and `Prep` button with checklist modal.

---

### 5. Lost & Found ([`lib/screens/lost_found.dart`](lib/screens/lost_found.dart))
* **Header**: `Campus Board`, `Lost & Found`, notification bell.
* **Real-time Search**: Search field to filter items by name and campus location.
* **Category Filters**: `All`, `Electronics`, `Accessories`, `Books`.
* **Counter Summary**: `23 Lost`, `14 Found`, `9 Returned`.
* **2x2 Grid of Belongings**:
  * `HP Laptop Bag` · CS Block · Sep 17 · **LOST**
  * `Samsung Earpods` · Cafeteria · Sep 18 · **FOUND**
  * `DBMS Textbook` · Library · Sep 16 · **LOST**
  * `ID Card Wallet` · Admin Block · Sep 15 · **RETURNED**
* **+ Report Item**: Floating pill button opening a full modal form (Item name, Category, Campus Location, Date, Lost/Found toggle, and Description). Submissions dynamically update the board in real time.

---

### 6. Student Profile ([`lib/screens/student_profile.dart`](lib/screens/student_profile.dart))
* **Header**: `<` Back, `My Profile`, dark mode toggle icon.
* **Avatar & Details**: Circular `ZA` monogram, `Zara Ahmed`, `Computer Science · 4th Semester`, `Roll No. CS-21-0142 · NUCES`.
* **Edit Profile**: Interactive dialog to update name and student information.
* **Stats Card**: 4 columns (`72 Credits`, `3.7 GPA`, `6 Courses`, `14 Badges`).
* **Interactive Tabs**: `Portfolio`, `Badges` (active), `Settings`.
* **Badges Grid**:
  * Merit Scholar · Fall 2025
  * Code Sprint Winner · Apr 2026
  * 100% Attendance · Sem 3
* **Preferences & Settings**:
  * Dark Mode switch
  * Notifications switch
  * Quick link to the Style Guide screen

---

## 🧭 Navigation & Routing

The app provides persistent bottom navigation via [`lib/widgets/app_bottom_nav.dart`](lib/widgets/app_bottom_nav.dart):
* **Home** ➔ [`/dashboard`](lib/screens/student_dashboard.dart)
* **Timetable** ➔ [`/timetable`](lib/screens/timetable.dart)
* **Center '+' Quick Action Button** ➔ Opens a quick actions drawer with direct links to all campus tools
* **Lost & Found** ➔ [`/lost_found`](lib/screens/lost_found.dart)
* **Profile** ➔ [`/profile`](lib/screens/student_profile.dart)

Additional named routes:
* [`/course_detail`](lib/screens/course_detail.dart)
* [`/attendance`](lib/screens/attendance_performance.dart)

---

## 🚀 How to Run the App

1. Ensure Flutter is installed and clone/navigate to the project directory:
   ```bash
   cd projectmad
   ```

2. Fetch all dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app on your mobile device or emulator:
   ```bash
   flutter run
   ```

4. Or run the app in Google Chrome:
   ```bash
   flutter run -d chrome
   ```

5. Run test suite:
   ```bash
   flutter test
   ```
