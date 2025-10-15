import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/ui/forgot_screen.dart';
import 'package:e_commerce_supabase/features/auth/ui/register_screen.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_row_button.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Welcome to Our Market',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: "Password",
                        suffixIcon: Icon(Icons.visibility_off),
                        obscureTxt: true,
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.kPrimaryColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomRowWithArrowBtn(
                        text: "Login",
                        icon: Icon(Icons.arrow_forward),
                      ),
                      SizedBox(height: 25),
                      CustomRowWithArrowBtn(
                        text: "Login With Google",
                        icon: Icon(Icons.arrow_forward),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: AppColors.kBlackColor,
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
