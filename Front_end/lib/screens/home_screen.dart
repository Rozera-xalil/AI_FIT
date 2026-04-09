import 'package:flutter/material.dart';
import '../widgets/common/bottom_nav.dart';
import 'dashboard_page.dart';
import 'recommend_page.dart';
import 'tasks_page.dart'; // تأكد من وجود هذا الملف واستيراده بشكل صحيح
import 'progress_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DashboardPage(),
      const RecommendPage(),
      const TasksPage(), // تأكد من أن هذا الكلاس موجود ومستورد بشكل صحيح
      const ProgressPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF0E0B16),
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: BottomNav(
        current: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}