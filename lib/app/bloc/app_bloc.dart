import 'package:authentication_repository/authentication_repository.dart';
import 'package:database_client/database_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    this._userRepository,
    this._authenticationRepository,
  ) : super(AppState(user: _userRepository.currentUser ?? UserModel.empty)) {
    on<AppUserSubscriptionRequested>(_onAppUserSubscriptionRequested);
    on<AppLogOutPressed>(_onAppLogOutPressed);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _onAppUserSubscriptionRequested(
      AppUserSubscriptionRequested event, Emitter<AppState> emit) {
    return emit.onEach(
      _userRepository.userStream,
      onData: (user) {
        emit(
          AppState(user: user),
        );
      },
      onError: addError,
    );
  }

  void _onAppLogOutPressed(AppLogOutPressed event, Emitter<AppState> emit) {
    _authenticationRepository.logOut();
  }
}
