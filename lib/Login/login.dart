import 'package:Control_Cultivos/Home/home.dart';
import 'package:Control_Cultivos/Login/createAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Control_Cultivos/Login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginBloc _bloc;
  @override
  void initState() {
    super.initState();
    //inicializamos el bloc
    _bloc = LoginBloc()..add(InitEvent());
  }

  Widget build(BuildContext context) {
    //variables para los tamaños
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocProvider(
          create: (context) {
            return _bloc;
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginInitial) {
                return Column(
                  children: [
                    SizedBox(
                      height: heigth * .05,
                    ),
                    CircleAvatar(
                      minRadius: heigth * .05,
                      maxRadius: width * .15,
                      backgroundImage: NetworkImage(
                        "https://scontent.fgdl5-2.fna.fbcdn.net/v/t31.0-8/17492966_959961907473788_1175562466240134332_o.jpg?_nc_cat=101&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFI19Ex_xcKQsB0wmr-esrHEVdOqbP_b0kRV06ps_9vSWYLrqfQht2lfw02bvnyePbn5EXDP5h4qJIkuEILfsSD&_nc_ohc=cG4YBP9BNFsAX8oSFJK&_nc_ht=scontent.fgdl5-2.fna&oh=8e611e7d7d5b7c021bf83fef2746c6a4&oe=5FE98B12",
                      ),
                    ),
                    SizedBox(
                      height: heigth * .02,
                    ),
                    Text(
                      "Ingrese sus datos",
                      style: TextStyle(fontSize: heigth * .04),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        width * .1,
                        heigth * .02,
                        width * .1,
                        heigth * .05,
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: email_controller,
                            decoration: InputDecoration(
                              hintText: 'correo electronico',
                            ),
                          ),
                          TextField(
                            controller: password_controller,
                            decoration: InputDecoration(
                              hintText: 'contraseña',
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (email_controller.text == "" ||
                            password_controller.text == "") {
                          final snackBar = SnackBar(
                              content: Text(
                                  'Error al ingresar (falta llenar campos)'));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                          email_controller.text = "";
                          password_controller.text = "";
                        } else if (_loginUser(
                            email_controller.text, password_controller.text)) {
                          //como validamos que los campos estan llenos, los registramos
                          //await _checkAccount();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => Home(),
                            ),
                          );
                          email_controller.text = "";
                          password_controller.text = "";
                        } else {
                          final snackBar = SnackBar(
                              content: Text('Error desconocido al ingresar'));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                          email_controller.text = "";
                          password_controller.text = "";
                        }
                      }, //validation function
                      color: Colors.blueGrey,
                      child: Text(
                        "Ingresar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: heigth * .1,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => CreateNewAccount(),
                          ),
                        );
                      }, //go to register page
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_add,
                            size: heigth * .07,
                          ),
                          Text(
                            "Crear cuenta",
                            style: TextStyle(fontSize: heigth * .03),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  bool _loginUser(email, password) {
    for (var i = 0; i < _bloc.getUserAccount.length; i++) {
      if (_bloc.getUserAccount[i].email == email &&
          _bloc.getUserAccount[i].password == password) return true;
    }
    return false;
  }
}
