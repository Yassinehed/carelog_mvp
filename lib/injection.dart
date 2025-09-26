import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'features/machine/data/datasources/machine_api_datasource.dart';
import 'features/machine/data/repositories/machine_repository_impl.dart';
import 'features/machine/domain/repositories/i_machine_repository.dart';
import 'features/machine/domain/usecases/get_machine_status.dart';
import 'features/signalement/data/datasources/signalement_firestore_datasource.dart';
import 'features/signalement/data/repositories/firestore_signalement_repository.dart';
import 'features/signalement/domain/repositories/i_signalement_repository.dart';
import 'features/signalement/domain/usecases/create_signalement.dart';
import 'features/signalement/domain/usecases/list_signalements.dart';
import 'features/signalement/domain/usecases/update_signalement_status.dart';
import 'features/of_order/data/datasources/of_order_firestore_datasource.dart';
import 'features/of_order/data/repositories/of_order_repository.dart';
import 'features/of_order/domain/repositories/i_of_order_repository.dart';
import 'features/of_order/domain/usecases/create_of_order.dart';
import 'features/of_order/domain/usecases/list_of_orders.dart';
import 'features/of_order/domain/usecases/update_of_order_status.dart';
import 'features/auth/data/datasources/firebase_auth_datasource.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/i_auth_repository.dart';
import 'data/repositories/material_repository_impl.dart';
import 'domain/repositories/material_repository.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
}

@LazySingleton(as: ISignalementRepository)
class FirestoreSignalementRepositoryImpl
    extends FirestoreSignalementRepository {
  FirestoreSignalementRepositoryImpl(super.datasource);
}

@injectable
class SignalementFirestoreDatasourceImpl
    extends SignalementFirestoreDatasource {
  SignalementFirestoreDatasourceImpl(super.firestore);
}

@injectable
class CreateSignalementUseCaseImpl extends CreateSignalementUseCase {
  CreateSignalementUseCaseImpl(super.repository);
}

@injectable
class ListSignalementsUseCaseImpl extends ListSignalementsUseCase {
  ListSignalementsUseCaseImpl(super.repository);
}

@injectable
class UpdateSignalementStatusUseCaseImpl
    extends UpdateSignalementStatusUseCase {
  UpdateSignalementStatusUseCaseImpl(super.repository);
}

@LazySingleton(as: IOfOrderRepository)
class OfOrderRepositoryImpl extends OfOrderRepository {
  OfOrderRepositoryImpl(super.datasource);
}

@injectable
class OfOrderFirestoreDatasourceImpl extends OfOrderFirestoreDatasource {
  OfOrderFirestoreDatasourceImpl(super.firestore);
}

@LazySingleton(as: CreateOfOrderUseCase)
class CreateOfOrderUseCaseImpl extends CreateOfOrderUseCase {
  CreateOfOrderUseCaseImpl(super.repository);
}

@LazySingleton(as: GetOfOrdersUseCase)
class GetOfOrdersUseCaseImpl extends GetOfOrdersUseCase {
  GetOfOrdersUseCaseImpl(super.repository);
}

@LazySingleton(as: UpdateOfOrderStatusUseCase)
class UpdateOfOrderStatusUseCaseImpl extends UpdateOfOrderStatusUseCase {
  UpdateOfOrderStatusUseCaseImpl(super.repository);
}

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(super.datasource);
}

@injectable
class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  FirebaseAuthDatasourceImpl(super.firebaseAuth);
}

@LazySingleton(as: MaterialRepository)
class MaterialRepositoryImplInjection extends MaterialRepositoryImpl {
  MaterialRepositoryImplInjection(super.firestoreDataSource);
}

@LazySingleton(as: UserRepository)
class UserRepositoryImplInjection extends UserRepositoryImpl {
  UserRepositoryImplInjection(super.firestoreDataSource);
}

@LazySingleton(as: MachineApiDatasource)
class MachineApiDatasourceImpl extends MachineApiDatasource {
  MachineApiDatasourceImpl(Dio dio) : super(dio);
}

@LazySingleton(as: IMachineRepository)
class MachineRepositoryInjection extends MachineRepositoryImpl {
  MachineRepositoryInjection(super.datasource);
}

@LazySingleton(as: GetMachineStatus)
class GetMachineStatusInjection extends GetMachineStatus {
  GetMachineStatusInjection(super.repository);
}
