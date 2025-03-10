part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppUserSubscriptionRequested extends AppEvent {}

final class AppLogOutPressed extends AppEvent {}
