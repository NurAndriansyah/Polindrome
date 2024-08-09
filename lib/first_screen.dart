import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palindrome/controller/user_controller.dart';
import 'package:palindrome/second_screen.dart';

class FirstScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final palindromeController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final _font = GoogleFonts.lato(
      color: Colors.black,
      fontSize: 18,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpg'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 20),
                _buildAnimatedTextField(nameController, 'Name', _font),
                SizedBox(height: 20),
                _buildAnimatedTextField(
                    palindromeController, 'Palindrome', _font),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // Box same width as TextField
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          palindromeController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Both fields are required!',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      } else {
                        String input = palindromeController.text
                            .replaceAll(' ', '')
                            .toLowerCase();
                        String reversedInput =
                            input.split('').reversed.join('');
                        if (input == reversedInput) {
                          Get.snackbar('Result', 'Palindrome');
                        } else {
                          Get.snackbar('Result', 'Not Palindrome');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2B637B),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('CHECK',
                        style: GoogleFonts.lato(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Box same width as TextField
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        userController.setUserName(nameController.text);
                        Get.to(() => SecondScreen());
                      } else {
                        Get.snackbar(
                          'Error',
                          'Name is required!',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2B637B),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('NEXT',
                        style: GoogleFonts.lato(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField(
      TextEditingController controller, String label, TextStyle font) {
    return TweenAnimationBuilder(
      tween:
          ColorTween(begin: Colors.white.withOpacity(0.5), end: Colors.white),
      duration: Duration(seconds: 1),
      builder: (context, color, child) {
        return TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: font.copyWith(color: Colors.black54),
            filled: true,
            fillColor: color as Color?,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: font,
        );
      },
    );
  }
}
