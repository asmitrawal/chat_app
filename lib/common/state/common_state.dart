// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommonState {}

class CommonSuccessState<T> extends CommonState {
  final T item;
  CommonSuccessState({
    required this.item,
  });
}

class CommonErrorState extends CommonState {
  final String? message;

  CommonErrorState({required this.message});
}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}
