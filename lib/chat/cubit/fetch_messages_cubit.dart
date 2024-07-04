// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:chat_app/common/state/common_state.dart';

class FetchMessagesCubit extends Cubit<CommonState> {
  final ChatRepository repository;
  FetchMessagesCubit({
    required this.repository,
  }) : super(CommonInitialState());

  fetchMessages({required userId, required otherUserId}) async {
    emit(CommonLoadingState());
    final res =
        repository.fetchMessages(userId: userId, otherUserId: otherUserId);
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
