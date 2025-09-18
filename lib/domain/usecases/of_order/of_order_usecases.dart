import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/of_order.dart';
import '../../../domain/repositories/of_order_repository.dart';

/// Use case for getting order by ID
@injectable
class GetOfOrderById {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrderById(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(String orderId) async {
    return await _ofOrderRepository.getById(orderId);
  }
}

/// Use case for getting all orders
@injectable
class GetAllOfOrders {
  final OfOrderRepository _ofOrderRepository;

  GetAllOfOrders(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call() async {
    return await _ofOrderRepository.getAll();
  }
}

/// Use case for creating a new order
@injectable
class CreateOfOrder {
  final OfOrderRepository _ofOrderRepository;

  CreateOfOrder(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(OfOrder order) async {
    return await _ofOrderRepository.create(order);
  }
}

/// Use case for updating order
@injectable
class UpdateOfOrder {
  final OfOrderRepository _ofOrderRepository;

  UpdateOfOrder(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(OfOrder order) async {
    return await _ofOrderRepository.update(order);
  }
}

/// Use case for deleting order
@injectable
class DeleteOfOrder {
  final OfOrderRepository _ofOrderRepository;

  DeleteOfOrder(this._ofOrderRepository);

  Future<Either<Failure, Unit>> call(String orderId) async {
    return await _ofOrderRepository.delete(orderId);
  }
}

/// Use case for getting orders by status
@injectable
class GetOfOrdersByStatus {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersByStatus(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call(OfOrderStatus status) async {
    return await _ofOrderRepository.getByStatus(status);
  }
}

/// Use case for getting orders by priority
@injectable
class GetOfOrdersByPriority {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersByPriority(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call(OfOrderPriority priority) async {
    return await _ofOrderRepository.getByPriority(priority);
  }
}

/// Use case for getting orders by supervisor
@injectable
class GetOfOrdersBySupervisor {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersBySupervisor(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call(String supervisorId) async {
    return await _ofOrderRepository.getBySupervisor(supervisorId);
  }
}

/// Use case for getting orders by production line
@injectable
class GetOfOrdersByProductionLine {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersByProductionLine(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call(String productionLine) async {
    return await _ofOrderRepository.getByProductionLine(productionLine);
  }
}

/// Use case for updating order status
@injectable
class UpdateOfOrderStatus {
  final OfOrderRepository _ofOrderRepository;

  UpdateOfOrderStatus(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(
    String orderId,
    OfOrderStatus newStatus,
    String updatedBy,
  ) async {
    return await _ofOrderRepository.updateStatus(
      orderId,
      newStatus,
      updatedBy,
    );
  }
}

/// Use case for updating production progress
@injectable
class UpdateOfOrderProgress {
  final OfOrderRepository _ofOrderRepository;

  UpdateOfOrderProgress(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(
    String orderId, {
    int? progressPercentage,
    int? actualQuantity,
    int? goodQuantity,
    int? rejectedQuantity,
    double? actualCost,
    String? updatedBy,
  }) async {
    return await _ofOrderRepository.updateProgress(
      orderId,
      progressPercentage: progressPercentage,
      actualQuantity: actualQuantity,
      goodQuantity: goodQuantity,
      rejectedQuantity: rejectedQuantity,
      actualCost: actualCost,
      updatedBy: updatedBy,
    );
  }
}

/// Use case for adding production note
@injectable
class AddOfOrderProductionNote {
  final OfOrderRepository _ofOrderRepository;

  AddOfOrderProductionNote(this._ofOrderRepository);

  Future<Either<Failure, OfOrder>> call(
    String orderId,
    String note,
    String authorId,
  ) async {
    return await _ofOrderRepository.addProductionNote(
      orderId,
      note,
      authorId,
    );
  }
}

/// Use case for getting orders by date range
@injectable
class GetOfOrdersByDateRange {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersByDateRange(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _ofOrderRepository.getByDateRange(startDate, endDate);
  }
}

/// Use case for getting orders due today
@injectable
class GetOfOrdersDueToday {
  final OfOrderRepository _ofOrderRepository;

  GetOfOrdersDueToday(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call() async {
    return await _ofOrderRepository.getDueToday();
  }
}

/// Use case for getting overdue orders
@injectable
class GetOverdueOfOrders {
  final OfOrderRepository _ofOrderRepository;

  GetOverdueOfOrders(this._ofOrderRepository);

  Future<Either<Failure, List<OfOrder>>> call() async {
    return await _ofOrderRepository.getOverdue();
  }
}
