import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/ApiService.dart';

class ProductDetail extends StatelessWidget {
  final int id;
  ProductDetail(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      snapshot.data['image'],
                      height: 200.h,
                      width: double.infinity,
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        "\$" + snapshot.data['price'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      snapshot.data['title'],
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.blueAccent,
                      ),
                    ),
                    // Chip tag is used for tagging or hash tag just like the Electronic etc
                    Chip(
                      backgroundColor: Colors.blueGrey,
                      label: Text(
                        snapshot.data['category'].toString(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      snapshot.data['description'],
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_outlined),
        onPressed: () {},
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
