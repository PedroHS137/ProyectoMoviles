part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitEvent extends LoginEvent {}

class CreateNewPlatEvent extends LoginEvent {}

class ReloadCreateNewPlatEvent extends LoginEvent {}
