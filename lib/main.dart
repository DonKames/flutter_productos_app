import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_productos_app/screens/screens.dart';
import 'package:flutter_productos_app/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'checking',
      routes: {
        'checking': (_) => const CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'product': (_) => const ProductScreen(),
        'register': (_) => const RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
    );
  }
}
