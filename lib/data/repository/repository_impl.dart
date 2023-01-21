
import 'package:app1/data/data_source/remote_data_source.dart';
import 'package:app1/data/mapper/mapper.dart';
import 'package:app1/data/network/failure.dart';
import 'package:app1/data/network/network_info.dart';
import 'package:app1/data/network/requests.dart';
import 'package:app1/domain/models.dart';
import 'package:app1/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._networkInfo, this._remoteDataSource);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if(await _networkInfo.isConnected){
        //call API
      final response =await _remoteDataSource.login(loginRequests);

      if (response.status ==0){
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      }else{
        //return either left
        //failure -- business error
        return Left(Failure(409, response.message ?? "business error"));
      }

    }else{
      return Left(Failure(501,  "please check your internet connection"));
      //return either left
      //return internet connection error
    }

  }

}