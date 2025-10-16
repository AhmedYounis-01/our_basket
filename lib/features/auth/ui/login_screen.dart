import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/function/show_msg.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/logic/cubit/authantication_cubit.dart';
import 'package:e_commerce_supabase/features/auth/ui/forgot_screen.dart';
import 'package:e_commerce_supabase/features/auth/ui/register_screen.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_row_button.dart';
import 'package:e_commerce_supabase/features/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthanticationCubit(),
      child: BlocConsumer<AuthanticationCubit, AuthanticationState>(
        listener: (context, state) {
          if (state is LoginError) showMsg(context, state.msg);
        },
        builder: (context, state) {
          AuthanticationCubit cubit = context.read<AuthanticationCubit>();
          return Scaffold(
            body: SafeArea(
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
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                labelText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                              ),
                              SizedBox(height: 20),
                              CustomTextFormField(
                                labelText: "Password",
                                suffixIcon: Icon(Icons.visibility_off),
                                obscureTxt: true,
                                controller: passwordController,
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
                                text: "Login",
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
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
                                      navigateTo(context, RegisterScreen());
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
            ),
          );
        },
      ),
    );
  }
}
