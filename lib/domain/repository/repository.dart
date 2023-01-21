import 'package:app1/data/network/failure.dart';
import 'package:app1/domain/models.dart';
import 'package:dartz/dartz.dart';
import 'package:app1/data/network/requests.dart';

abstract class Repository{
 Future <Either<Failure, Authentication>> login(LoginRequests loginRequests);
}