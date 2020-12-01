part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class AddPlantState extends LoginState {}

class ReloadAddPlantState extends LoginState {}
