// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/common/state/common_state.dart';

class SignInCubit extends Cubit<CommonState> {
  AuthRepository repository;
  SignInCubit({
    required this.repository,
  }) : super(CommonInitialState());

  signIn({
    required String email,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final res = await repository.signIn(
      email: email,
      password: password,
    );
    res.fold(
      (err) {
        emit(CommonErrorState(message: err));
      },
      (data) {
        emit(CommonSuccessState(item: data));
      },
    );
  }
}
