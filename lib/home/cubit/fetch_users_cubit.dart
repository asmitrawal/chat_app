// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/common/state/common_state.dart';
import 'package:chat_app/home/repository/home_repository.dart';

class FetchUsersCubit extends Cubit<CommonState> {
  final HomeRepository repository;
  FetchUsersCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchUsers() async {
    emit(CommonLoadingState());
    final res = repository.fetchUsersList();
    res.fold((err) {
      emit(CommonErrorState(message: err));
    }, (stream) async {
      stream.listen(
        (snapshot) {
          if (snapshot.isEmpty) {
            emit(CommonErrorState(message: "No data found"));
          } else {
            emit(CommonSuccessState(item: snapshot));
          }
        },
        onError: (err) {
          emit(CommonErrorState(
              message: err ?? "error while fetching snapshot"));
        },
      );
    });
  }
}
