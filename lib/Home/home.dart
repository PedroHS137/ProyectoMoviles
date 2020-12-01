import 'package:flutter/material.dart';

import 'package:Control_Cultivos/AddPlant/addPlant.dart';

import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../PlantList/plantList.dart';
import '../Utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Control de cultivos"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlantList(
                          plants: constPlants,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: heigth * .05,
                    child: Container(
                      height: heigth * .2,
                      width: width * .9,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * .05,
                          ),
                          CircleAvatar(
                            minRadius: heigth * .05,
                            maxRadius: width * .15,
                            backgroundImage: NetworkImage(
                              "https://www.landuum.com/wp-content/uploads/2018/11/calendario-cultivo-huerto-verdecora_sinderechos-1024x683.jpg",
                            ),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Text(
                            "Mis plantas",
                            style: TextStyle(fontSize: width * .06),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _createEmail();
                  },
                  child: Card(
                    elevation: heigth * .05,
                    child: Container(
                      height: heigth * .2,
                      width: width * .9,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * .05,
                          ),
                          CircleAvatar(
                            minRadius: heigth * .05,
                            maxRadius: width * .15,
                            backgroundImage: NetworkImage(
                              "https://tidegroup.org/wp-content/uploads/2018/05/asesoria-descripcion.jpg",
                            ),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Text(
                            "Solicitar asesoria",
                            style: TextStyle(fontSize: width * .04),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPlanta(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: heigth * .05,
                    child: Container(
                      height: heigth * .2,
                      width: width * .9,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * .05,
                          ),
                          CircleAvatar(
                            minRadius: heigth * .05,
                            maxRadius: width * .15,
                            backgroundImage: NetworkImage(
                                "https://www.expoknews.com/wp-content/uploads/2019/06/3909065_n_vir3.jpg"),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Text(
                            "Añadir planta",
                            style: TextStyle(fontSize: width * .05),
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createEmail() async {
    const emailaddress =
        'mailto:inge_agronomo@ClaseMoviles2020.com?subject=Asesoria Subject&body=Correo para el ingeniero';
    await launch(emailaddress);
  }
}
