import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/components/custom_search_filed.dart';
import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/services/sensitive_data.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce_supabase/features/auth/models/user_model.dart';
import 'package:e_commerce_supabase/features/home/ui/search_screen.dart';
import 'package:e_commerce_supabase/features/home/ui/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isPayMobInitialized = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializePayMob(UserModel userModel) {
    if (_isPayMobInitialized) return;

    PaymentData.initialize(
      apiKey: paymobApiKey,
      iframeId: iFrameId,
      integrationCardId: integrationCardId,
      integrationMobileWalletId: integrationMobileWalletId,
      userData: UserData(email: userModel.email, name: userModel.name),
      style: Style(
        primaryColor: AppColors.kPrimaryColor,
        appBarBackgroundColor: AppColors.kPrimaryColor,
        textStyle: const TextStyle(),
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: Colors.white,
        ),
        circleProgressColor: AppColors.kPrimaryColor,
        unselectedColor: Colors.grey,
      ),
    );

    _isPayMobInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is GetUserDataLoading) {
          return const Center(child: CustomCircularIndicator());
        }

        if (state is GetUserDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.msg}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().getUserData();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is GetUserDataSuccess) {
          final UserModel userModel = state.userModel;

          // initialize PayMob
          _initializePayMob(userModel);

          return ListView(
            children: [
              CustomSearchField(
                searchController: _searchController,
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    navigateTo(
                      context,
                      SearchScreen(query: _searchController.text),
                    );
                  }
                  _searchController.clear();
                },
              ),
              const SizedBox(height: 15),
              Image.asset("assets/images/buy.jpg"),
              const SizedBox(height: 10),
              const Text("popular Categories"),
              const SizedBox(height: 5),
              const CategoriesList(),
              const SizedBox(height: 10),
              const Text("Recently Products"),
              const SizedBox(height: 5),
              const ProductsList(),
              const SizedBox(height: 50),
            ],
          );
        }

        // Default fallback
        return const Center(child: Text('لا توجد بيانات'));
      },
    );
  }
}
