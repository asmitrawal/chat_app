import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:chat_app/common/state/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutCubit extends Cubit<CommonState> {
  AuthRepository repository = AuthRepository();
  SignOutCubit() : super(CommonInitialState());

  signOut(
      {required String email,
      required String password,
      required String? fullName}) async {
    emit(CommonLoadingState());
    final res = await repository.signOut();
    res.fold(
      (err) {
        emit(CommonErrorState(message: err));
      },
      (data) {
        emit(CommonSuccessState(item: null));
      },
    );
  }
}
