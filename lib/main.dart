import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/models/user_model.dart';
import 'data/models/course_model.dart';
import 'data/models/assignment_model.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/course_repository.dart';
import 'logic/cubits/auth_cubit.dart';
import 'logic/cubits/course_cubit.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CourseModelAdapter());
  Hive.registerAdapter(AssignmentModelAdapter());

  // Open Boxes
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<CourseModel>('courses');
  await Hive.openBox<AssignmentModel>('assignments');
  await Hive.openBox('settings');

  // Set system UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => CourseRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CourseCubit(
              context.read<CourseRepository>(),
            )..loadCourses(),
          ),
        ],
        child: MaterialApp(
          title: 'EduHub',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              titleTextStyle: GoogleFonts.poppins(
                color: const Color(0xFF1A1D1F),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              iconTheme: const IconThemeData(color: Color(0xFF1A1D1F)),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}