import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/db/firebase_options.dart';
import 'app/router/app_route.dart';
import 'app/theme/app_theme.dart' as AppTheme;
import 'features/auth/presentation/controllers/auth_bloc.dart';
import 'features/home/presentation/pages/home_custom.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.isDarkMode,
      builder: (context, darkMode, child) {
        return MaterialApp(
          onGenerateRoute: AppRoute.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
          ),
          themeMode:
          darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const HomeCustom(),
        );
      },
    );
  }
}