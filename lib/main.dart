import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lgzfrrxuwwgbzklhrufh.supabase.co',
    anonKey: 'sb_publishable_1q39qlA8boXOngvXLJlNRQ_pGCX7sYo',
  );

  runApp(const DayTaskApp());
}

class DayTaskApp extends StatelessWidget {
  const DayTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DayTask',
      home: const OnboardingScreen(),
    );
  }
}
