import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_productos_app/models/models.dart';
import 'package:flutter_productos_app/screens/screens.dart';
import 'package:flutter_productos_app/services/services.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productService.selectedProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
            product: productService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = Product(
            available: false,
            name: '',
            price: 0,
          );
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
