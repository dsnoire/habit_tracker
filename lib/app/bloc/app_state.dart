part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({UserModel user = UserModel.empty})
      : this._(
          user: user,
          status: user == UserModel.empty ? AppStatus.unauthenticated : AppStatus.authenticated,
        );

  const AppState._({
    this.user = UserModel.empty,
    required this.status,
  });

  final UserModel user;
  final AppStatus status;

  @override
  List<Object> get props => [user, status];
}
