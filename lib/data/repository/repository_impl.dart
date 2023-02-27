
import 'package:app1/data/data_source/remote_data_source.dart';
import 'package:app1/data/mapper/mapper.dart';
import 'package:app1/data/network/error_handler.dart';
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

      try{
        final response =await _remoteDataSource.login(loginRequests);

        if (response.status ==ApiInternalStatus.SUCCESS){
          //success
          //return either right
          //return data
          return Right(response.toDomain());
        }else{
          //return either left
          //failure -- business error
          return Left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }

      }catch(error){
        return Left(ErrorHandler.handle(error).failure);

      }
        //call API


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      //return either left
      //return internet connection error
    }

  }

}