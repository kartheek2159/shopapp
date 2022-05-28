import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../providers/products.dart';

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
  var _isLoading = false;

  // var _isInit = true;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    //if we dont care about context this is fine

    //but if we are concerned about context
    // Future.delayed(Duration.zero).then((_) =>
    //     {Provider.of<Products>(context, listen: false).fetchAndSetProducts()});

    super.initState();
  }
  //or we can use didchangedependencies

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

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
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemcount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
