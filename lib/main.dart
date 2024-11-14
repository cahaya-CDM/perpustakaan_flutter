import 'package:flutter/material.dart';
import 'package:perpustakaan/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hugdtxtttxgimkrqqtxc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh1Z2R0eHR0dHhnaW1rcnFxdHhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NTQ5MjMsImV4cCI6MjA0NzEzMDkyM30.TDROAEyQ4T7G-8-rSJoYHl05nCkQFx0uF2sFkc94Mo0',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perpustakaan',
      debugShowCheckedModeBanner: false,
      home: BookListPage(),
    );
  }
}
