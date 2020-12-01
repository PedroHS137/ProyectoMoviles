import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Control_Cultivos/Models/UserAccount.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Firestore _firestore = Firestore.instance;
  List<UserAccount> _list = List();
  List<UserAccount> get getUserAccount => _list;
  File _chooseImage;
  String _url;

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InitEvent) {
      if (await _getData()) {
        yield LoginInitial();
      }
    } else if (event is CreateNewPlatEvent) {
      yield AddPlantState();
    }
  }

  //functions

  Future<bool> _getData() async {
    try {
      var x = await _firestore.collection("UserDate").getDocuments();
      _list = x.documents
          .map(
            (x) => UserAccount(
              email: x["email"],
              password: x["password"],
            ),
          )
          .toList();

      for (var item in _list) {
        print(item.email);
        print(item.password);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
