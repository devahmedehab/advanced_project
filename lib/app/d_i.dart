import 'package:app1/app/app_prefs.dart';
import 'package:app1/data/data_source/remote_data_source.dart';
import 'package:app1/data/network/app_api.dart';
import 'package:app1/data/network/dio_factory.dart';
import 'package:app1/data/network/network_info.dart';
import 'package:app1/data/repository/repository_impl.dart';
import 'package:app1/domain/repository/repository.dart';
import 'package:app1/domain/usecase/login_usecase.dart';
import 'package:app1/presentation/login/viewmodel/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module, its a module where we put all generic dependencies

  // shard prefs instance
  final shardPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => shardPrefs);
  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  // dio factory
  instance
      .registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

// Remote data source
  instance
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));

  // repository
  instance
      .registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));

}


   initLoginModule() {
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
