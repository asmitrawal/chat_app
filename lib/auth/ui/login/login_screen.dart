import 'package:chat_app/auth/cubit/sign_in_cubit.dart';
import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/auth/ui/login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignInCubit(repository: context.read<AuthRepository>()),
      child: LoginWidget(),
    );
  }
}
