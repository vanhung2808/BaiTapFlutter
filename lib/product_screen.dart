import 'package:baitap_product/buy_product.dart';
import 'package:baitap_product/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> lsProduct;
  void initState() {
    super.initState();
    lsProduct = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black38,
          title: Text("LIST PRODUCT"),
        ),
        body: FutureBuilder(
            future: Product.fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Product product = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          product.title,
                          style: TextStyle(fontSize: 24, color: Colors.black87),
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          product.description,
                          style: TextStyle(fontSize: 15),
                          maxLines: 3,
                        ),
                        leading: Image.network(
                          product.image,
                          width: 100,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("\$${product.price}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.red)),
                            BuyProduct()
                          ],
                        ),
                        isThreeLine: true,
                        horizontalTitleGap: 10,
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
