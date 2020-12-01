part of 'bloc_plants_bloc.dart';

@immutable
abstract class BlocPlantsEvent {}

class GetDataEvent extends BlocPlantsEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends BlocPlantsEvent {
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}