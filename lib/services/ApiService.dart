import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // This function is for getting all the available resources in this Api Like Name, Description, price, etc

  Future getAllPosts() async {
    final allProductUrl = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(allProductUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // This Function is for Displaying a Single Product Detail

  Future getSingleProduct(int id) async {
    final singleProductUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    final response = await http.get(singleProductUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

// This Function is for Displaying all the Category of  Product's

  Future getAllCategory() async {
    final allCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");
    final response = await http.get(allCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getProductByCategory(String CatName) async {
    final fetchProductCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/category/$CatName");
    final response = await http.get(fetchProductCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // Cart Function

  Future getCart(String userId) async {
    final fetchCartProducts =
        Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(fetchCartProducts);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // POST REQUEST
  Future userLogin(String username, String password) async {
    final loginUrl = Uri.parse("https://fakestoreapi.com/auth/login");
    final response = await http.post(loginUrl, body: {
      'username': username,
      'password': password,
    });
    print("API Response: ${response.body}"); // Add this line
    return json.decode(response.body);
  }
}
