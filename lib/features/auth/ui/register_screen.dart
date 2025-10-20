import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/function/navigate_without_back.dart';
import 'package:e_commerce_supabase/core/function/show_msg.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce_supabase/features/auth/ui/forgot_screen.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_row_button.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_text_field.dart';
import 'package:e_commerce_supabase/features/home/ui/main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess || state is GoogleSignInSuccess) {
            navigateWithoutBack(context, MainHomeScreen());
          }
          if (state is RegisterError) showMsg(context, state.msg);
        },
        builder: (context, state) {
          AuthCubit cubit = context.read<AuthCubit>();
          return Scaffold(
            body: state is RegisterLoading
                ? Center(child: const CustomCircularIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Text(
                              'Welcome to Our Market',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      labelText: "Name",
                                      keyboardType: TextInputType.name,
                                      controller: _nameController,
                                    ),
                                    SizedBox(height: 20),
                                    CustomTextFormField(
                                      labelText: "Email",
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                    ),
                                    SizedBox(height: 20),
                                    CustomTextFormField(
                                      labelText: "Password",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisible = !isVisible;
                                          });
                                        },
                                        icon: Icon(
                                          isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      obscureTxt: true,
                                      controller: _passwordController,
                                    ),
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          navigateTo(context, ForgotScreen());
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    CustomRowWithArrowBtn(
                                      text: "Register",
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.register(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: 25),
                                    CustomRowWithArrowBtn(
                                      text: "Register With Google",
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: () => cubit.googleSignIn(),
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                            color: AppColors.kBlackColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Login",
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
                  ),
          );
        },
      ),
    );
  }
}
