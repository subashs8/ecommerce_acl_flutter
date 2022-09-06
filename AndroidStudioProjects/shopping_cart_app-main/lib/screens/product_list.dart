import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/model/item_model.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:shopping_cart_app/database/db_helper.dart';
import 'package:shopping_cart_app/model/cart_model.dart';
import 'package:shopping_cart_app/screens/cart_screen.dart';
import 'package:shopping_cart_app/screens/constants.dart';
import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:shopping_cart_app/backend/parse_products.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();
  Products? productItems;

  // List<Item> products = [
  //   Item(
  //       name: '1989 Batwing', price: 200, image: 'assets/images/image12.jpg'),
  //   Item(
  //       name: '1989 Batwing', price: 200, image: 'assets/images/image12.jpg'),
  //   Item(
  //       name: '1989 Batwing', price: 200, image: 'assets/images/image12.jpg'),
  //   Item(
  //       name: '1989 Batwing', price: 200, image: 'assets/images/image12.jpg'),
  // ];
  Future loadApiData() async{
    try{
      final response = await http.get(Uri.parse("https://ecommerce-acl-digital.herokuapp.com/product"));
      if(response.statusCode == 200){
        final jsonBody = json.decode(response.body);
        final products = productsFromJson(jsonBody);
        return products;
      }
    }
    catch(e){
      print(e);
    }
  }
  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadApiData().then((products){
      productItems = products;
    });
  }
  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: productItems[index].name,
          initialPrice: productItems[index].price,
          productPrice: productItems[index].price,
          quantity: ValueNotifier(1),
          image: 'assets/images/image12.jpg',
        ),
      )
          .then((value) {
        cart.addTotalPrice(productItems[index].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    Widget productCard(int index){
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Constants.ROUTE_PRODUCT_DETAIL);
        },
        child: Card(
          color: Colors.white70,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                  height: 80,
                  width: 80,
                  image: AssetImage('assets/images/image12.jpg'),
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0),
                            children: [
                              TextSpan(
                                  text:
                                  '${productItems[index].name.toString()}\n',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                      RichText(
                        maxLines: 1,
                        text: TextSpan(
                            text: '' r"$",
                            style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0),
                            children: [
                              TextSpan(
                                  text:
                                  '${productItems[index].price.toString()}\n',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent),
                    onPressed: () {
                      saveData(index);
                    },
                    child: const Text('Add to Cart')),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          shrinkWrap: true,
          itemCount: productItems.length,
          itemBuilder: (context, index) {
            return productCard(index);
          }),
    );
  }
}
