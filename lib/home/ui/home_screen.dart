import 'package:chat_app/home/cubit/fetch_users_cubit.dart';
import 'package:chat_app/home/repository/home_repository.dart';
import 'package:chat_app/home/ui/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchUsersCubit(
        repository: context.read<HomeRepository>(),
      )..fetchUsers(),
      child: HomeWidget(),
    );
  }
}
