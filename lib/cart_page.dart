import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iide_project/bloc/cubit/product_handler_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocBuilder<ProductHandlerCubit, ProductHandlerState>(
          builder: (context, state) {
            if (state.products.every((element) => element.inCart == false)) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_cart),
                    Text("No Items in the cart"),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return state.products[index].inCart
                      ? ListTile(
                          title: Text(state.products[index].productName),
                          trailing: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item Removed from the cart'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              BlocProvider.of<ProductHandlerCubit>(context)
                                  .removeFromCart(
                                      productId: state.products[index].id);
                            },
                            child: const Icon(
                              Icons.remove_shopping_cart_outlined,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container();
                },
                itemCount: state.products.length,
              );
            }
          },
        ),
      ),
    );
  }
}
