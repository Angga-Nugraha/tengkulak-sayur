import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tengkulak_sayur/data/datasource/product_remote_data_source.dart';
import 'package:tengkulak_sayur/data/repositories/product_repository_impl.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';
import 'package:tengkulak_sayur/domain/usecases/get_all_product.dart';
import 'package:tengkulak_sayur/domain/usecases/get_product_category.dart';
import 'package:tengkulak_sayur/domain/usecases/search_product.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_category_product.dart';
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

  // Usecase product
  locator.registerLazySingleton(() => GetAllProduct(locator()));
  locator.registerLazySingleton(() => SearchProduct(locator()));
  locator.registerLazySingleton(() => GetCategoryProduct(locator()));

  // Repositories
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: locator()));

  // Datasource
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(locator()));

  // external http
  locator.registerLazySingleton(() => http.Client());
}
