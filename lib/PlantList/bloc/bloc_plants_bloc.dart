import 'dart:async';

import 'package:Control_Cultivos/Models/Plant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'bloc_plants_event.dart';
part 'bloc_plants_state.dart';

class BlocPlantsBloc extends Bloc<BlocPlantsEvent, BlocPlantsState> {
  final Firestore firestoreInstance = Firestore.instance;
  List<Plant> plantList;
  List<DocumentSnapshot> documentsList;
  List<Plant> get getPlantsList => plantList;

  BlocPlantsBloc() : super(BlocPlantsInitial());

  @override
  BlocPlantsState get initialState => BlocPlantsInitial();

  @override
  Stream<BlocPlantsState> mapEventToState(
    BlocPlantsEvent event,
  ) async* {
    if (event is GetDataEvent) {
      bool dataRetrieved = await _getData();
      if (dataRetrieved) {
        yield CloudStoreGetData();
      } else {
        yield CloudStoreGetDataError(
            errorMessage: "No se pudo obtener la lista de plantas");
      }
    } else if (event is RemoveDataEvent) {
      try {
        await documentsList[event.index].reference.delete();
        documentsList.removeAt(event.index);
        plantList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreGetDataError(
          errorMessage: "Error al borrar la planta",
        );
      }
    }
  }

  Future<bool> _getData() async {
    try {
      var plants =
          await firestoreInstance.collection("MisPlantas").getDocuments();
      plantList = plants.documents
          .map((plant) => Plant(
                name: plant["name"],
                annotations: plant["annotations"],
                family: plant["family"],
                image: plant["image"],
              ))
          .toList();
      documentsList = plants.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
