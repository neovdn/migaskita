import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_migaskita/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_migaskita/data/datasources/remote/user_remote_data_source.dart';
import 'package:flutter_migaskita/data/repositories/auth_repository_impl.dart';
import 'package:flutter_migaskita/domain/repositories/auth_repository.dart'; // Impor AuthRepository
import 'package:flutter_migaskita/domain/usecases/auth/sign_in.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_up.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_out.dart';
import 'package:flutter_migaskita/presentation/providers/auth_provider.dart'
    as presentationAuth;

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton<SignIn>(() => SignIn(sl()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl()));
  sl.registerLazySingleton<SignOut>(() => SignOut(sl()));

  // Providers
  sl.registerLazySingleton<presentationAuth.AuthProvider>(
    () => presentationAuth.AuthProvider(
      sl<SignIn>(),
      sl<SignUp>(),
      sl<SignOut>(),
    ),
  );
}
