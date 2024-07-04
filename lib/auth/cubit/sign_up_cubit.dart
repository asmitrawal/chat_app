// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/common/state/common_state.dart';

class SignUpCubit extends Cubit<CommonState> {
  AuthRepository repository;
  SignUpCubit({
    required this.repository,
  }) : super(CommonInitialState());

  signUp(
      {required String email,
      required String password,
      required String? fullName}) async {
    emit(CommonLoadingState());
    final res = await repository.signUp(
        email: email, password: password, fullName: fullName);
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
