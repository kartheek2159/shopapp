import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreeen extends StatefulWidget {
  @override
  State<ProductsOverviewScreeen> createState() =>
      _ProductsOverviewScreeenState();
}

class _ProductsOverviewScreeenState extends State<ProductsOverviewScreeen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Only Favourites'),
                        value: FilterOptions.Favourites),
                    PopupMenuItem(
                        child: Text('Show All'), value: FilterOptions.All),
                  ])
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
