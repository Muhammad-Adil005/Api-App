import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/ApiService.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getCart('1'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List products = snapshot.data['products'];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: ApiService()
                      .getSingleProduct(products[index]['productId']),
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        title: Text(asyncSnapshot.data['title']),
                        leading: Image.network(asyncSnapshot.data['image'],
                            height: 40),
                        subtitle: Text("Quantity - " +
                            products[index]['quantity'].toString()),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      );
                    }
                    return LinearProgressIndicator();
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.green,
        child: Center(
          child: Text(
            "ORDER NOW",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
            ),
          ),
        ),
      ),
    );
  }
}
