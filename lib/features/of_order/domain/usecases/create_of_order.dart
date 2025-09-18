import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';

/// Use case for creating a new OfOrder.
class CreateOfOrderUseCase {
  final IOfOrderRepository repository;

  const CreateOfOrderUseCase(this.repository);

  Future<Either<OfOrderFailure, Unit>> call(CreateOfOrderParams params) {
    final ofOrder = OfOrder(
      id: params.id,
      client: params.client,
      product: params.product,
      quantity: params.quantity,
      status: OfOrderStatus.materialReception,
      createdAt: DateTime.now(),
      description: params.description,
    );
    return repository.createOfOrder(ofOrder);
  }
}

/// Parameters for creating an OfOrder.
class CreateOfOrderParams extends Equatable {
  final String id;
  final String client;
  final String product;
  final int quantity;
  final String? description;

  const CreateOfOrderParams({
    required this.id,
    required this.client,
    required this.product,
    required this.quantity,
    this.description,
  });

  @override
  List<Object?> get props => [id, client, product, quantity, description];
}
