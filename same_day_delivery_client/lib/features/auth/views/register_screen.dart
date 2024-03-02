import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customTextField.dart';
import 'package:same_day_delivery_client/config/api.dart';
import 'package:same_day_delivery_client/features/auth/views/login_screen.dart';
import 'package:same_day_delivery_client/model/user.model.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  static const String imageURL =
      "https://toppng.com/uploads/preview/decorative-lines-vector-11549974585kzzlmrfrjk.png";
  RegisterPage({super.key});
  void _registerUser(BuildContext context) async {
    try {
      UserModel userToRegister = UserModel(
        userId:
            DateTime.now().millisecondsSinceEpoch.toString(), //timeand date id

        userName: nameController.text,
        userEmail: emailController.text,
        userPassword: passwordController.text,
        userPhone: phoneController.text,
        userAddress: addressController.text,
        userDate: DateTime.now().toString(),
      );

      UserModel registeredUser = await ApiService.registerUser(userToRegister);

      // Handle the registered user as needed (e.g., navigate to another screen)
      print('User registered successfully: $registeredUser');
    } catch (e) {
      // Handle registration error
      print('Error registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(231, 255, 255, 255),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Stack(
                    //   children: [
                    //     SizedBox(
                    //       height: 150,
                    //       width: double.infinity,
                    //       child: Image.network(
                    //         imageURL,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //     const Positioned(
                    //       top: 30,
                    //       left: 20,
                    //       child: Text(
                    //         'Same Day Delivery',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 50),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFromField(
                      label: 'username',
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomTextFromField(
                            label: 'phone',
                            controller: phoneController,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFromField(
                            label: 'address',
                            controller: addressController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Register",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _registerUser(context);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Or'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Already have an account?'),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
