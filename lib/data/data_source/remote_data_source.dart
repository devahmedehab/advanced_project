
import 'package:app1/data/network/app_api.dart';
import 'package:app1/data/network/requests.dart';
import 'package:app1/data/responses/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

class RemoteDataSourceImpl implements RemoteDataSource{

  final AppServiceClient _appServiceClient ;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async{

    return await _appServiceClient.login(loginRequests.email, loginRequests.password);

  }

}