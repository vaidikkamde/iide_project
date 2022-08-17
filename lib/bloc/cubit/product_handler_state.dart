part of 'product_handler_cubit.dart';

abstract class ProductHandlerState extends Equatable {
  const ProductHandlerState({required this.products});
  final List<ProductModel> products;
  @override
  List<Object> get props => [];
}

class ProductHandlerInitial extends ProductHandlerState {
  const ProductHandlerInitial({required List<ProductModel> products})
      : super(products: products);
}

class ProductHandlerLoading extends ProductHandlerState {
  const ProductHandlerLoading({required List<ProductModel> products})
      : super(products: products);
}

class ProductHandlerAddToCart extends ProductHandlerState {
  const ProductHandlerAddToCart({required List<ProductModel> products})
      : super(products: products);
}

class ProductHandlerRemoveFromCart extends ProductHandlerState {
  const ProductHandlerRemoveFromCart({required List<ProductModel> products})
      : super(products: products);
}
