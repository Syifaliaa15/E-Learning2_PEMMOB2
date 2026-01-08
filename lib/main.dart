import 'package:flutter/material.dart';
import 'list_page.dart';
import 'form_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning 2',
      theme: ThemeData(
        useMaterial3: true,
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB6C1), 
          primary: const Color(0xFFFF69B4),    
          secondary: const Color(0xFFFFDAB9),  
          surface: const Color(0xFFFFF5F7),   
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF69B4),
          foregroundColor: Colors.white,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF69B4),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListPage(),
        '/form': (context) {
          final arg = ModalRoute.of(context)?.settings.arguments;
          if (arg is Map<String, dynamic>) return FormPage(user: arg);
          return const FormPage();
        },
      },
    );
  }
}