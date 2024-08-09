import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palindrome/controller/user_controller.dart';
import 'package:palindrome/third_screen.dart';

class SecondScreen extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final _font = GoogleFonts.lato(fontSize: 18, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white, // Background putih
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: _font),
            Obx(() => Text(
                  userController.userName.value,
                  style:
                      _font.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 40),
            Obx(() {
              String selectedUserName = userController.selectedUserName.value;
              return Center(
                child: Text(
                  selectedUserName.isEmpty
                      ? 'Selected User Name'
                      : selectedUserName,
                  style:
                      _font.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            }),
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity, // Samakan lebar dengan kotak teks
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => ThirdScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B637B),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Choose a User',
                    style: _font.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
