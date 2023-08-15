import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/ApiService.dart';
import 'product_detail_screen.dart';

class CategoryProductScreen extends StatelessWidget {
  final String categoryName;
  CategoryProductScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ApiService().getProductByCategory(categoryName),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]['title']),
                    leading: Image.network(
                      snapshot.data[index]['image'],
                      height: 50.h,
                      width: 30.w,
                    ),
                    subtitle: Text(" Price : " +
                        snapshot.data[index]['price'].toString() +
                        " \$"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(snapshot.data[index]['id'])),
                      );
                    },
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
