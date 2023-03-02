import 'dart:async';
import 'package:app1/presentation/base/baseviewmodel.dart';
import 'package:app1/presentation/common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs,LoginViewModelOutputs{

 final StreamController _userNameStreamController = StreamController<String>.broadcast();
 final StreamController _passwordStreamController = StreamController<String>.broadcast();
 final StreamController _areAllInputsValidStreamController = StreamController<void>.broadcast();
  var loginObject=LoginObject("","");
  /*final LoginUseCase _loginUseCase;
 LoginViewModel(this._loginUseCase);*/
 LoginViewModel();
  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {

  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

 @override
 Sink get inputUserName => _userNameStreamController.sink;

 @override
 Sink get inputAreAllDataValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject =loginObject.copyWith(password: password);
    inputAreAllDataValid.add(null);
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject =loginObject.copyWith(userName: username);
    inputAreAllDataValid.add(null);

  }


  @override
  login() async{
 /*   ( await _loginUseCase.execute(LoginUseCaseInput
      (loginObject.userName, loginObject.password)
    )).fold((failure) => {
      // left -> failure
      print(failure.message)
    }, (data) => {
      // right -> data (success)
      print(data.customer?.name)
    });*/

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

 @override

 Stream<bool> get outAreAllInputsValid =>
     _areAllInputsValidStreamController.stream
         .map((_) =>  _areAllInputsValid());

  bool _isPasswordValid(String password){
    return password.isNotEmpty;

  }
 bool _isUserNameValid(String username){
   return username.isNotEmpty;

 }
 bool _areAllInputsValid() {

    return _isPasswordValid(loginObject.password)
        &&_isUserNameValid(loginObject.userName);
 }
}


abstract class LoginViewModelInputs{
  setUserName(String username);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllDataValid;

}

abstract class LoginViewModelOutputs{

  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputsValid;

}