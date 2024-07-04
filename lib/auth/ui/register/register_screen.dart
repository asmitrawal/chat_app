import 'package:chat_app/auth/cubit/sign_up_cubit.dart';
import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/auth/ui/register/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpCubit(repository: context.read<AuthRepository>()),
      child: RegisterWidget(),
    );
  }
}
