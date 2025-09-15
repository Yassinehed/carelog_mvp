// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:carelog_mvp/data/datasources/remote/firestore_datasource.dart'
    as _i462;
import 'package:carelog_mvp/data/repositories/material_repository_impl.dart'
    as _i400;
import 'package:carelog_mvp/data/repositories/of_order_repository_impl.dart'
    as _i392;
import 'package:carelog_mvp/data/repositories/signalement_repository_impl.dart'
    as _i57;
import 'package:carelog_mvp/data/repositories/user_repository_impl.dart'
    as _i725;
import 'package:carelog_mvp/domain/repositories/material_repository.dart'
    as _i174;
import 'package:carelog_mvp/domain/repositories/of_order_repository.dart'
    as _i174;
import 'package:carelog_mvp/domain/repositories/signalement_repository.dart'
    as _i132;
import 'package:carelog_mvp/domain/repositories/user_repository.dart' as _i372;
import 'package:carelog_mvp/domain/usecases/material/material_usecases.dart'
    as _i8;
import 'package:carelog_mvp/domain/usecases/of_order/of_order_usecases.dart'
    as _i572;
import 'package:carelog_mvp/domain/usecases/signalement/signalement_usecases.dart'
    as _i559;
import 'package:carelog_mvp/domain/usecases/user/user_usecases.dart' as _i180;
import 'package:carelog_mvp/features/auth/data/datasources/firebase_auth_datasource.dart'
    as _i894;
import 'package:carelog_mvp/features/auth/domain/repositories/i_auth_repository.dart'
    as _i462;
import 'package:carelog_mvp/features/auth/domain/usecases/get_current_user.dart'
    as _i1054;
import 'package:carelog_mvp/features/auth/domain/usecases/reset_password.dart'
    as _i1045;
import 'package:carelog_mvp/features/auth/domain/usecases/sign_in.dart'
    as _i923;
import 'package:carelog_mvp/features/auth/domain/usecases/sign_out.dart'
    as _i413;
import 'package:carelog_mvp/features/auth/domain/usecases/sign_up.dart'
    as _i154;
import 'package:carelog_mvp/features/of_order/data/datasources/of_order_firestore_datasource.dart'
    as _i767;
import 'package:carelog_mvp/features/of_order/domain/repositories/i_of_order_repository.dart'
    as _i479;
import 'package:carelog_mvp/features/of_order/domain/usecases/create_of_order.dart'
    as _i868;
import 'package:carelog_mvp/features/of_order/domain/usecases/list_of_orders.dart'
    as _i125;
import 'package:carelog_mvp/features/of_order/domain/usecases/update_of_order_status.dart'
    as _i58;
import 'package:carelog_mvp/features/signalement/data/datasources/signalement_firestore_datasource.dart'
    as _i737;
import 'package:carelog_mvp/features/signalement/domain/repositories/i_signalement_repository.dart'
    as _i608;
import 'package:carelog_mvp/injection.dart' as _i290;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.factory<_i737.SignalementFirestoreDatasource>(() =>
        _i737.SignalementFirestoreDatasource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i290.SignalementFirestoreDatasourceImpl>(() =>
        _i290.SignalementFirestoreDatasourceImpl(
            gh<_i974.FirebaseFirestore>()));
    gh.factory<_i290.OfOrderFirestoreDatasourceImpl>(() =>
        _i290.OfOrderFirestoreDatasourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i290.FirebaseAuthDatasourceImpl>(
        () => _i290.FirebaseAuthDatasourceImpl(gh<_i59.FirebaseAuth>()));
    gh.factory<_i559.GetSignalementById>(
        () => _i559.GetSignalementById(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetAllSignalements>(
        () => _i559.GetAllSignalements(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.CreateSignalement>(
        () => _i559.CreateSignalement(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.UpdateSignalement>(
        () => _i559.UpdateSignalement(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.DeleteSignalement>(
        () => _i559.DeleteSignalement(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetSignalementsByStatus>(
        () => _i559.GetSignalementsByStatus(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetSignalementsByPriority>(() =>
        _i559.GetSignalementsByPriority(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetSignalementsAssignedTo>(() =>
        _i559.GetSignalementsAssignedTo(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetSignalementsCreatedBy>(() =>
        _i559.GetSignalementsCreatedBy(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.UpdateSignalementStatus>(
        () => _i559.UpdateSignalementStatus(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.AssignSignalement>(
        () => _i559.AssignSignalement(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.AddSignalementComment>(
        () => _i559.AddSignalementComment(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetSignalementsDueToday>(
        () => _i559.GetSignalementsDueToday(gh<_i132.SignalementRepository>()));
    gh.factory<_i559.GetOverdueSignalements>(
        () => _i559.GetOverdueSignalements(gh<_i132.SignalementRepository>()));
    gh.factory<_i572.GetOfOrderById>(
        () => _i572.GetOfOrderById(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetAllOfOrders>(
        () => _i572.GetAllOfOrders(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.CreateOfOrder>(
        () => _i572.CreateOfOrder(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.UpdateOfOrder>(
        () => _i572.UpdateOfOrder(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.DeleteOfOrder>(
        () => _i572.DeleteOfOrder(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersByStatus>(
        () => _i572.GetOfOrdersByStatus(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersByPriority>(
        () => _i572.GetOfOrdersByPriority(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersBySupervisor>(
        () => _i572.GetOfOrdersBySupervisor(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersByProductionLine>(
        () => _i572.GetOfOrdersByProductionLine(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.UpdateOfOrderStatus>(
        () => _i572.UpdateOfOrderStatus(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.UpdateOfOrderProgress>(
        () => _i572.UpdateOfOrderProgress(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.AddOfOrderProductionNote>(
        () => _i572.AddOfOrderProductionNote(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersByDateRange>(
        () => _i572.GetOfOrdersByDateRange(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOfOrdersDueToday>(
        () => _i572.GetOfOrdersDueToday(gh<_i174.OfOrderRepository>()));
    gh.factory<_i572.GetOverdueOfOrders>(
        () => _i572.GetOverdueOfOrders(gh<_i174.OfOrderRepository>()));
    gh.lazySingleton<_i608.ISignalementRepository>(() =>
        _i290.FirestoreSignalementRepositoryImpl(
            gh<_i737.SignalementFirestoreDatasource>()));
    gh.factory<_i767.OfOrderFirestoreDatasource>(
        () => _i767.OfOrderFirestoreDatasource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i462.FirestoreDataSource>(
        () => _i462.FirestoreDataSource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i894.FirebaseAuthDatasource>(
        () => _i894.FirebaseAuthDatasource(gh<_i59.FirebaseAuth>()));
    gh.factory<_i400.MaterialRepositoryImpl>(
        () => _i400.MaterialRepositoryImpl(gh<_i462.FirestoreDataSource>()));
    gh.factory<_i392.OfOrderRepositoryImpl>(
        () => _i392.OfOrderRepositoryImpl(gh<_i462.FirestoreDataSource>()));
    gh.factory<_i57.SignalementRepositoryImpl>(
        () => _i57.SignalementRepositoryImpl(gh<_i462.FirestoreDataSource>()));
    gh.factory<_i725.UserRepositoryImpl>(
        () => _i725.UserRepositoryImpl(gh<_i462.FirestoreDataSource>()));
    gh.lazySingleton<_i462.IAuthRepository>(
        () => _i290.AuthRepositoryImpl(gh<_i894.FirebaseAuthDatasource>()));
    gh.factory<_i1054.GetCurrentUserUseCase>(
        () => _i1054.GetCurrentUserUseCase(gh<_i462.IAuthRepository>()));
    gh.factory<_i1045.ResetPasswordUseCase>(
        () => _i1045.ResetPasswordUseCase(gh<_i462.IAuthRepository>()));
    gh.factory<_i923.SignInUseCase>(
        () => _i923.SignInUseCase(gh<_i462.IAuthRepository>()));
    gh.factory<_i413.SignOutUseCase>(
        () => _i413.SignOutUseCase(gh<_i462.IAuthRepository>()));
    gh.factory<_i154.SignUpUseCase>(
        () => _i154.SignUpUseCase(gh<_i462.IAuthRepository>()));
    gh.lazySingleton<_i174.MaterialRepository>(() =>
        _i290.MaterialRepositoryImplInjection(gh<_i462.FirestoreDataSource>()));
    gh.lazySingleton<_i372.UserRepository>(() =>
        _i290.UserRepositoryImplInjection(gh<_i462.FirestoreDataSource>()));
    gh.factory<_i180.GetCurrentUser>(
        () => _i180.GetCurrentUser(gh<_i372.UserRepository>()));
    gh.factory<_i180.GetUserById>(
        () => _i180.GetUserById(gh<_i372.UserRepository>()));
    gh.factory<_i180.GetUserByEmail>(
        () => _i180.GetUserByEmail(gh<_i372.UserRepository>()));
    gh.factory<_i180.CheckEmailAvailability>(
        () => _i180.CheckEmailAvailability(gh<_i372.UserRepository>()));
    gh.factory<_i180.UpdateUserProfile>(
        () => _i180.UpdateUserProfile(gh<_i372.UserRepository>()));
    gh.factory<_i180.UpdateUserRole>(
        () => _i180.UpdateUserRole(gh<_i372.UserRepository>()));
    gh.factory<_i180.GetUsersByRole>(
        () => _i180.GetUsersByRole(gh<_i372.UserRepository>()));
    gh.factory<_i180.GetAdminUsers>(
        () => _i180.GetAdminUsers(gh<_i372.UserRepository>()));
    gh.factory<_i180.SearchUsers>(
        () => _i180.SearchUsers(gh<_i372.UserRepository>()));
    gh.factory<_i180.GetActiveUsersCount>(
        () => _i180.GetActiveUsersCount(gh<_i372.UserRepository>()));
    gh.factory<_i8.GetMaterialById>(
        () => _i8.GetMaterialById(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetAllMaterials>(
        () => _i8.GetAllMaterials(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.CreateMaterial>(
        () => _i8.CreateMaterial(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.UpdateMaterial>(
        () => _i8.UpdateMaterial(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.DeleteMaterial>(
        () => _i8.DeleteMaterial(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetMaterialsByType>(
        () => _i8.GetMaterialsByType(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetMaterialsByCategory>(
        () => _i8.GetMaterialsByCategory(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetMaterialsByStockStatus>(
        () => _i8.GetMaterialsByStockStatus(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetLowStockMaterials>(
        () => _i8.GetLowStockMaterials(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetOutOfStockMaterials>(
        () => _i8.GetOutOfStockMaterials(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetMaterialsNeedingReorder>(
        () => _i8.GetMaterialsNeedingReorder(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.UpdateMaterialStock>(
        () => _i8.UpdateMaterialStock(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.StockInMaterial>(
        () => _i8.StockInMaterial(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.StockOutMaterial>(
        () => _i8.StockOutMaterial(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.UpdateMaterialInfo>(
        () => _i8.UpdateMaterialInfo(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetMaterialStatistics>(
        () => _i8.GetMaterialStatistics(gh<_i174.MaterialRepository>()));
    gh.factory<_i8.GetStockAlerts>(
        () => _i8.GetStockAlerts(gh<_i174.MaterialRepository>()));
    gh.factory<_i290.CreateSignalementUseCaseImpl>(() =>
        _i290.CreateSignalementUseCaseImpl(gh<_i608.ISignalementRepository>()));
    gh.factory<_i290.ListSignalementsUseCaseImpl>(() =>
        _i290.ListSignalementsUseCaseImpl(gh<_i608.ISignalementRepository>()));
    gh.factory<_i290.UpdateSignalementStatusUseCaseImpl>(() =>
        _i290.UpdateSignalementStatusUseCaseImpl(
            gh<_i608.ISignalementRepository>()));
    gh.lazySingleton<_i479.IOfOrderRepository>(() =>
        _i290.OfOrderRepositoryImpl(gh<_i767.OfOrderFirestoreDatasource>()));
    gh.lazySingleton<_i868.CreateOfOrderUseCase>(
        () => _i290.CreateOfOrderUseCaseImpl(gh<_i479.IOfOrderRepository>()));
    gh.lazySingleton<_i125.GetOfOrdersUseCase>(
        () => _i290.GetOfOrdersUseCaseImpl(gh<_i479.IOfOrderRepository>()));
    gh.lazySingleton<_i58.UpdateOfOrderStatusUseCase>(() =>
        _i290.UpdateOfOrderStatusUseCaseImpl(gh<_i479.IOfOrderRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i290.RegisterModule {}
