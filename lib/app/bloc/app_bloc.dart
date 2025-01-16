import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._userRepository) : super(AppState(user: _userRepository.currentUser ?? UserModel.empty)) {
    on<AppUserSubscriptionRequested>(_onAppUserSubscriptionRequested);
  }

  final UserRepository _userRepository;

  Future<void> _onAppUserSubscriptionRequested(AppUserSubscriptionRequested event, Emitter<AppState> emit) {
    return emit.onEach(
      _userRepository.userStream,
      onData: (user) {
        emit(
          AppState(user: user),
        );
        print(user);
      },
      onError: addError,
    );
  }
}
