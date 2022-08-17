import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:iide_project/data/product_model.dart';

part 'product_handler_state.dart';

List<ProductModel> intialProductList = List.generate(
  20,
  (index) => ProductModel(
    productName: 'ProductName - $index',
    id: (index + 10).toString(),
    inCart: false,
  ),
);

class ProductHandlerCubit extends Cubit<ProductHandlerState> {
  ProductHandlerCubit()
      : super(
          ProductHandlerInitial(
            products: intialProductList,
          ),
        );
  void loading() => emit(ProductHandlerLoading(products: state.products));
  void addToCart({required String productId}) {
    loading();
    List<ProductModel> intialProducts = state.products;
    int index = intialProducts.indexWhere((element) => element.id == productId);
    ProductModel initalProduct = intialProducts[index];
    ProductModel updatedProduct = ProductModel(
      productName: initalProduct.productName,
      id: initalProduct.id,
      inCart: true,
    );
    List<ProductModel> updatedProducts = List.from(intialProducts);
    updatedProducts[index] = updatedProduct;

    return emit(
      ProductHandlerAddToCart(
        products: updatedProducts,
      ),
    );
  }

  void removeFromCart({required String productId}) {
    loading();
    List<ProductModel> intialProducts = state.products;
    int index = intialProducts.indexWhere((element) => element.id == productId);
    ProductModel initalProduct = intialProducts[index];
    ProductModel updatedProduct = ProductModel(
      productName: initalProduct.productName,
      id: initalProduct.id,
      inCart: false,
    );
    List<ProductModel> updatedProducts = List.from(intialProducts);
    updatedProducts[index] = updatedProduct;
    return emit(
      ProductHandlerRemoveFromCart(
        products: updatedProducts,
      ),
    );
  }
}
