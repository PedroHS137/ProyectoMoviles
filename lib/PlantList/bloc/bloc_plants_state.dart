part of 'bloc_plants_bloc.dart';

@immutable
abstract class BlocPlantsState {}

class BlocPlantsInitial extends BlocPlantsState {}

class CloudStoreGetData extends BlocPlantsState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetDataError extends BlocPlantsState {
  final String errorMessage;

  CloudStoreGetDataError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends BlocPlantsState {
  @override
  List<Object> get props => [];
}

