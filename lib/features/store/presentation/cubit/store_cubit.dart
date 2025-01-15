import 'package:auto_car/core/api/api_consumer.dart';
import 'package:auto_car/core/api/end_points.dart';
import 'package:auto_car/core/api/exceptions.dart';
import 'package:auto_car/features/store/data/products_model/products_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  ApiConsumer api;
  StoreCubit(
    this.api,
  ) : super(StoreInitial());
  List<ProductsModel> products = [];
  getProducts() async {
    emit(GetProductsLoading());
    try {
      final response = await api.get(ApiKeys.products);
      products = (response as List)
          .map((item) => ProductsModel.fromJson(item))
          .toList();
      emit(GetProductsLoaded(products: products));
    } on ServerException catch (e) {
      emit(GetProductsFailure(e.errModel.errorMessage));
    }
  }
}
