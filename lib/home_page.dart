import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iide_project/bloc/cubit/product_handler_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductHandlerCubit, ProductHandlerState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.products[index].productName),
                trailing: state.products[index].inCart
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item Added to the cart'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),
                            ),
                          );
                          BlocProvider.of<ProductHandlerCubit>(context)
                              .addToCart(productId: state.products[index].id);
                        },
                        child: const Icon(Icons.add_shopping_cart_outlined,
                            color: Colors.blue),
                      ),
              );
            },
            itemCount: state.products.length,
          );
        },
      ),
    ));
  }
}
