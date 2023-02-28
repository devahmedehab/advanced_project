
import 'dart:async';

import 'package:app1/presentation/base/baseviewmodel.dart';
import 'package:app1/presentation/common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs,LoginViewModelOutputs{

 final StreamController _userNameStreamController = StreamController<String>.broadcast();
 final StreamController _passwordStreamController = StreamController<String>.broadcast();
  var loginObject=LoginObject("","");
  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {

  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

 @override
 Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject =loginObject.copyWith(password: password);
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject =loginObject.copyWith(userName: username);

  }


  @override
  login() {
    throw UnimplementedError();
  }
  //outputs
  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordStreamController.stream.map((password) =>
          _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid =>
      _userNameStreamController.stream.map((userName) =>
          _isUserNameValid(userName));

  bool _isPasswordValid(String password){
    return password.isNotEmpty;

  }
 bool _isUserNameValid(String username){
   return username.isNotEmpty;

 }

}
abstract class LoginViewModelInputs{
  setUserName(String username);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

}

abstract class LoginViewModelOutputs{

  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

}