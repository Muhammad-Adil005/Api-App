import 'package:api/screens/Home.dart';
import 'package:api/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController nameController =
      TextEditingController(text: "mor_2314");
  TextEditingController passwordController =
      TextEditingController(text: "83r5^_");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter APi App'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/api.png',
              height: 200.h,
              width: 200.w,
            ),
            SizedBox(height: 30.h),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              height: 50.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final getToken = await ApiService().userLogin(
                        nameController.text, passwordController.text);

                    if (getToken != null && getToken['token'] != null) {
                      final snackBar = SnackBar(
                        content: Text(
                            "Successfully Login! Your Token is ${getToken['token']}"),
                        backgroundColor: Colors.grey,
                        duration: Duration(seconds: 2),
                      );

                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar)
                          .closed
                          .then((reason) {
                        if (reason == SnackBarClosedReason.timeout) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Username or Password is incorrect"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("An error occurred. Please try again."),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
