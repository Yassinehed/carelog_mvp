import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
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
import 'core/services/pdf_service.dart';
import 'core/services/real_time_tracking_service.dart';
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
}

@LazySingleton(as: ISignalementRepository)
class FirestoreSignalementRepositoryImpl
    extends FirestoreSignalementRepository {
  FirestoreSignalementRepositoryImpl(super.datasource);
}

// Register concrete domain-level SignalementRepository type expected by usecases
@LazySingleton(as: SignalementRepository)
class SignalementRepositoryImplInjection extends SignalementRepositoryImpl {
  SignalementRepositoryImplInjection(super.firestoreDataSource);
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

// Register concrete domain-level OfOrderRepository type expected by usecases
@LazySingleton(as: OfOrderRepository)
class OfOrderRepositoryDomainInjection extends OfOrderRepositoryImpl {
  OfOrderRepositoryDomainInjection(super._firestoreDataSource);
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

@LazySingleton()
class PdfServiceImpl extends PdfService {
  PdfServiceImpl() : super();
}

@LazySingleton()
class RealTimeTrackingServiceImpl extends RealTimeTrackingService {
  RealTimeTrackingServiceImpl() : super();
}
