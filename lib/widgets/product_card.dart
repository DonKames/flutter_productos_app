import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),
            _ProductDetails(product),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(product.price),
            ),
            //TODO: Mostrar de manera condicional
            if (!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable(),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black38,
            offset: Offset(0, 7),
          ),
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      height: 70,
      width: 100,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$price',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.id.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? const Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url ?? 'assets/no-image.png'),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
