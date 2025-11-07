import 'package:e_commerce_supabase/core/components/custom_search_filed.dart';
import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/services/sensitive_data.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/models/user_model.dart';
import 'package:e_commerce_supabase/features/home/ui/search_screen.dart';
import 'package:e_commerce_supabase/features/home/ui/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    PaymentData.initialize(
      apiKey: paymobApiKey,
      iframeId: iFrameId,
      integrationCardId: integrationCardId,
      integrationMobileWalletId: integrationMobileWalletId,
      //* Optional User Data
      userData: UserData(
        // email: widget.userModel.email, // Optional: Defaults to 'NA'
        // phone: "User Phone", // Optional: Defaults to 'NA'
        // name: widget.userModel.name, // Optional: Defaults to 'NA'
        // lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      //* Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor,
        appBarBackgroundColor: AppColors.kPrimaryColor,
        textStyle: TextStyle(),
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: Colors.white,
        ),
        circleProgressColor: AppColors.kPrimaryColor,
        unselectedColor: Colors.grey,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomSearchField(
          searchController: _searchController,
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              navigateTo(context, SearchScreen(query: _searchController.text));
            }
            _searchController.clear();
          },
        ),
        const SizedBox(height: 15),
        Image.asset("assets/images/buy.jpg"),
        const SizedBox(height: 10),
        const Text("popular Categories"),
        const SizedBox(height: 5),
        CategoriesList(),
        const SizedBox(height: 10),
        const Text("Recently Products"),
        const SizedBox(height: 5),
        ProductsList(),
        const SizedBox(height: 50),
      ],
    );
  }
}
