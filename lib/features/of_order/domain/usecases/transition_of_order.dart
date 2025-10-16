import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';
import '../services/of_workflow_service.dart';

@injectable
class TransitionOfOrderUseCase {
  final OfWorkflowService _workflowService;

  TransitionOfOrderUseCase(this._workflowService);

  Future<Either<OfOrderFailure, OfOrder>> call(String ofId, OfOrderStatus newStatus, {String? updatedBy}) {
    return _workflowService.transition(ofId, newStatus, updatedBy: updatedBy);
  }
}
