import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/auth/ui/login/login_screen.dart';
import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:chat_app/common/theme/my_theme_data.dart';
import 'package:chat_app/home/repository/home_repository.dart';
import 'package:chat_app/home/ui/home_screen.dart';
import 'package:chat_app/settings/cubit/theme_check_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider(
          create: (context) => ChatRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => ThemeCheckCubit(),
        child: BlocBuilder<ThemeCheckCubit, ThemeData>(
          builder: (context, state) {
            return GlobalLoaderOverlay(
              child: MaterialApp(
                title: 'Chat App by Narco',
                theme: state,
                home: HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
