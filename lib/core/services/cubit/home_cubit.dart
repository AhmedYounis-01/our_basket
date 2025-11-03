import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/api_sevices.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiSevices _apiSevices = ApiSevices();

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];
  Future<void> getproducts({String? qurey, String? category}) async {
    emit(HomeLoading());
    try {
      final response = await _apiSevices.getData(
        'products?select=*,favorite_products(*),purchase(*)',
      );
      products.clear();
      for (final item in (response.data as List<dynamic>)) {
        products.add(ProductModel.fromJson(item as Map<String, dynamic>));
      }
      // log(response.data.toString());
      search(qurey);
      getProuductsOfCategory(category);
      emit(HomeSuccess());
    } catch (e) {
      log(e.toString());
      emit(HomeError());
    }
  }

  void search(String? qurey) {
    if (qurey != null && qurey.isNotEmpty) {
      for (var product in products) {
        if (product.productName.toLowerCase().contains(qurey.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProuductsOfCategory(String? category) {
    if (category != null && category.isNotEmpty) {
      for (var product in products) {
        if (product.category.toLowerCase().trim() ==
            category.toLowerCase().trim()) {
          categoryProducts.add(product);
        }
      }
    }
  }
}
