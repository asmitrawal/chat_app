// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:chat_app/common/state/common_state.dart';

class SendMessageCubit extends Cubit<CommonState> {
  ChatRepository repository;
  SendMessageCubit({
    required this.repository,
  }) : super(CommonInitialState());

  sendMessages({required String receiverId, required String message}) async {
    emit(CommonLoadingState());
    final res =
        await repository.sendMessage(receiverId: receiverId, message: message);
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
