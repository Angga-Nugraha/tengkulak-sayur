import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tengkulak_sayur/data/datasource/user_remote_data_source.dart';
import 'package:tengkulak_sayur/data/datasource/product_remote_data_source.dart';
import 'package:tengkulak_sayur/data/repositories/user_repository_impl.dart';
import 'package:tengkulak_sayur/data/repositories/product_repository_impl.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/me.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_all_product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_product_category.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/login.dart';
import 'package:tengkulak_sayur/domain/usecases/product/search_product.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/signup.dart';
import 'package:tengkulak_sayur/presentation/authentication/bloc/login_bloc.dart';
import 'package:tengkulak_sayur/presentation/authentication/bloc/profile_me_bloc.dart';
import 'package:tengkulak_sayur/presentation/authentication/bloc/signup_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_category_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/search_product_bloc.dart';

final locator = GetIt.instance;

void init() {
  // Bloc Product
  locator.registerFactory(
    () => GetAllProductBloc(getAllProduct: locator()),
  );

  locator.registerFactory(
    () => SearchProductBloc(locator()),
  );
  locator.registerFactory(
    () => CategoryProductBloc(locator()),
  );

  locator.registerFactory(
    () => LoginBloc(login: locator()),
  );
  locator.registerFactory(
    () => SignUpBloc(signUp: locator()),
  );
  locator.registerFactory(
    () => ProfileMeBloc(me: locator()),
  );

  // Usecase product
  locator.registerLazySingleton(() => GetAllProduct(locator()));
  locator.registerLazySingleton(() => SearchProduct(locator()));
  locator.registerLazySingleton(() => GetCategoryProduct(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => Me(locator()));

  // Repositories
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: locator()));

  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositositoryImpl(authentication: locator()));

  // Datasource
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<Authentication>(
      () => AuthenticationImpl(locator()));

  // external http
  locator.registerLazySingleton(() => http.Client());
}
