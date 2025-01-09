part of 'store_cubit.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class GetProductsLoading extends StoreState {}

final class GetProductsLoaded extends StoreState {
  final List<ProductsModel> products;

  GetProductsLoaded({required this.products});
}

final class GetProductsFailure extends StoreState {
  final String errMessage;

  GetProductsFailure(this.errMessage);
}
