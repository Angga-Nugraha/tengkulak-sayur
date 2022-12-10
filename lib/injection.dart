import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:tengkulak_sayur/data/datasource/authentication.dart';
import 'package:tengkulak_sayur/data/datasource/product_data_source.dart';

import 'package:tengkulak_sayur/data/repositories/user_repository_impl.dart';
import 'package:tengkulak_sayur/data/repositories/product_repository_impl.dart';

import 'package:tengkulak_sayur/domain/usecases/auth/login.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/logout.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_product_by_id.dart';
import 'package:tengkulak_sayur/domain/usecases/user/add_user.dart';
import 'package:tengkulak_sayur/domain/usecases/user/delete_user.dart';
import 'package:tengkulak_sayur/domain/usecases/user/edit_user.dart';
import 'package:tengkulak_sayur/domain/usecases/user/get_user_by_id.dart';
import 'package:tengkulak_sayur/domain/usecases/product/add_to_cart.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_list_cart.dart';
import 'package:tengkulak_sayur/domain/usecases/product/search_product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_all_product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/remove_from_cart.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_product_category.dart';

import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';

import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  // Bloc Product
  locator.registerFactory(
    () => ProductBloc(getAllProduct: locator()),
  );
  locator.registerFactory(
    () => CategoryProductBloc(getCategoryProduct: locator()),
  );
  locator.registerFactory(
    () => GetProductIdBloc(getProductById: locator()),
  );
  locator.registerFactory(
    () => SearchProductBloc(searchProduct: locator()),
  );
  locator.registerFactory(
    () => CartBloc(
        addToCart: locator(),
        getListCart: locator(),
        removeFromCart: locator()),
  );

  locator.registerFactory(
    () => LoginBloc(login: locator()),
  );

  locator.registerFactory(
    () => CheckInLoginBloc(getUserById: locator()),
  );

  locator.registerFactory(
    () => LogoutBloc(logout: locator()),
  );
  locator.registerFactory(
    () => AddUserBloc(signUp: locator()),
  );
  locator.registerFactory(
    () => GetUserBloc(getUserById: locator()),
  );
  locator.registerFactory(
    () => DeleteUserBloc(deleteUser: locator()),
  );
  locator.registerFactory(
    () => EditUserBloc(editUser: locator()),
  );

  // Usecase product
  locator.registerLazySingleton(() => GetAllProduct(locator()));
  locator.registerLazySingleton(() => SearchProduct(locator()));
  locator.registerLazySingleton(() => GetCategoryProduct(locator()));
  locator.registerLazySingleton(() => GetProductById(locator()));
  locator.registerLazySingleton(() => AddToCart(locator()));
  locator.registerLazySingleton(() => RemoveFromCart(locator()));
  locator.registerLazySingleton(() => GetListCart(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Logout(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => GetUserById(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));
  locator.registerLazySingleton(() => EditUser(locator()));

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
