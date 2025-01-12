part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterConfirmedPasswordChanged extends RegisterEvent {
  const RegisterConfirmedPasswordChanged(this.confirmedPassword);
  final String confirmedPassword;

  @override
  List<Object> get props => [confirmedPassword];
}

class RegisterFormSubmitted extends RegisterEvent {}
