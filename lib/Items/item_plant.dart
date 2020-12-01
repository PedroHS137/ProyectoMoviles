import 'package:Control_Cultivos/PlantList/bloc/bloc_plants_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Plant.dart';

class ItemPlant extends StatefulWidget {
  final Plant plant;
  final int index;
  ItemPlant({Key key, this.index, this.plant}) : super(key: key);

  @override
  _ItemPlantState createState() => _ItemPlantState();
}

class _ItemPlantState extends State<ItemPlant> {
  void _delete() {
    BlocProvider.of<BlocPlantsBloc>(context).add(
      RemoveDataEvent(index: widget.index),
    );
  }

  _dialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Eliminar planta",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child:
                      Text("¿Desea eliminar la planta ${widget.plant.name}?"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  child: new Text("Aceptar"),
                  onPressed: () {
                    _delete();
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: GestureDetector(
        onTap: () {
          //_detail(widget.hamburguesa);
        },
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(5),
          color: Colors.lime[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment(0, 0),
                width: MediaQuery.of(context).size.width * 0.25,
                child: ClipOval(
                  child: Image.network(
                    '${widget.plant.image}',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 0),
                  width: MediaQuery.of(context).size.width * 0.27,
                  child: Text(
                    '${widget.plant.name}',
                    textAlign: TextAlign.center,
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${widget.plant.family}'),
                    ],
                  )),
              Container(
                alignment: Alignment(0, 0),
                width: MediaQuery.of(context).size.width * 0.15,
                child: Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _dialog();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
