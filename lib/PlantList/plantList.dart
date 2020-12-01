import 'package:Control_Cultivos/PlantList/bloc/bloc_plants_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Plant.dart';
import '../Items/item_plant.dart';

class PlantList extends StatefulWidget {
  final List<Plant> plants;
  PlantList({Key key, this.plants}) : super(key: key);
  @override
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  BlocPlantsBloc bloc;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plantas disponibles"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) {
            bloc = BlocPlantsBloc()..add(GetDataEvent());
            return bloc;
          },
          child: BlocListener<BlocPlantsBloc, BlocPlantsState>(
            listener: (context, state) {
              if (state is CloudStoreGetData) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Obteniendo lista de plantas"),
                    ),
                  );
              } else if (state is CloudStoreGetDataError) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("${state.errorMessage}"),
                    ),
                  );
              } else if (state is CloudStoreRemoved) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Se ha eliminado el elemento."),
                    ),
                  );
              }
            },
            child: BlocBuilder<BlocPlantsBloc, BlocPlantsState>(
                builder: (context, state) {
              if (state is BlocPlantsInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .85,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: bloc.getPlantsList.length != null
                          ? bloc.getPlantsList.length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemPlant(
                          plant: bloc.getPlantsList[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
