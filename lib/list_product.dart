import 'package:baitap_product/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImageProduct extends StatefulWidget {
  const ListImageProduct({Key? key}) : super(key: key);

  @override
  _ListImageProductState createState() => _ListImageProductState();
}

class _ListImageProductState extends State<ListImageProduct> {
  late Future<List<Product>> lsProduct;

  void initState() {
    super.initState();
    lsProduct = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Product"),
        ),
        body: FutureBuilder(
            future: lsProduct,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider.builder(
                        itemBuilder: (context, index, realIndex) {
                          Product dt = snapshot.data[index];
                          print(dt);
                          return _buildBody(dt);
                        },

                        //Slider Container properties
                        options: CarouselOptions(
                          height: 550,
                          enlargeCenterPage: true,
                          // autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1000),
                          viewportFraction: 0.8,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                        ),
                        itemCount: snapshot.data.length,
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

Widget _buildBody(Product product) {
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Image.network(
          product.image,
          width: Get.width * 0.9,
          fit: BoxFit.fill,
          height: 300,
        ),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Column(
          children: [
            Text(
              product.title,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "\Rating: ${product.rating.rate}",
              style: TextStyle(fontSize: 18, color: Colors.red),
              maxLines: 1,
            ),
            Text(
              "\Price: \$${product.price}",
              style: TextStyle(fontSize: 18, color: Colors.red),
            )
          ],
        ))
      ],
    ),
  );
}
