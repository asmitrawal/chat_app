import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/common/components/my_drawer.dart';
import 'package:chat_app/common/components/user_tile.dart';
import 'package:chat_app/common/state/common_state.dart';
import 'package:chat_app/home/cubit/fetch_users_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HOME"),
          centerTitle: true,
          // backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        drawer: MyDrawer(),
        body: BlocBuilder<FetchUsersCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<List<Map<String, dynamic>>>) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (state.item[index]["userId"] !=
                      context.read<AuthRepository>().currentUser!.uid) {
                    return UserTile(
                      fullName: state.item[index]["fullName"],
                      email: state.item[index]["email"],
                      userId: state.item[index]["userId"],
                      otherUserId: FirebaseAuth.instance.currentUser!.uid,
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: state.item.length,
              );
            } else {
              return CircularProgressIndicator.adaptive();
            }
          },
        ));
  }
}
