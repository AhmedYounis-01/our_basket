import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/api_sevices.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiSevices _apiServices = ApiSevices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];
  Future<void> getProducts({String? qurey, String? category}) async {
    emit(HomeLoading());
    try {
      final response = await _apiServices.getData(
        'products?select=*,favorite_products(*),purchase(*)',
      );
      products.clear();
      // clear auxiliary lists/maps to avoid duplications when re-fetching
      searchResults.clear();
      categoryProducts.clear();
      favoriteProducts.clear();
      for (final item in (response.data as List<dynamic>)) {
        final product = ProductModel.fromJson(item as Map<String, dynamic>);
        products.add(product);

        // The API returns nested favorite_products for each product (because of
        // the `favorite_products(*)` select). If there's an entry for the
        // current user, mark the product as favorite so it persists across restarts.
        try {
          final favs = (item)['favorite_products'];
          if (favs is List) {
            for (final fav in favs) {
              if (fav is Map<String, dynamic>) {
                final forUsers = fav['for_users'];
                if (forUsers != null && forUsers == userId) {
                  favoriteProducts[product.productId] = true;
                  break;
                }
              }
            }
          }
        } catch (_) {}
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
    searchResults.clear();
    if (qurey != null && qurey.isNotEmpty) {
      for (var product in products) {
        if (product.productName.toLowerCase().contains(qurey.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProuductsOfCategory(String? category) {
    categoryProducts.clear();
    if (category != null && category.isNotEmpty) {
      for (var product in products) {
        if (product.category.toLowerCase().trim() ==
            category.toLowerCase().trim()) {
          categoryProducts.add(product);
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};

  Future<void> addToFavorites(String productId) async {
    try {
      emit(AddToFavoriteLoading());
      await _apiServices.postData('favorite_products', {
        'is_favorite': true,
        'for_users': userId,
        'for_products': productId,
      });
      favoriteProducts.addAll({productId: true});
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  bool checkIfFavoureite(productId) {
    return favoriteProducts.containsKey(productId);
  }

  Future<void> removeFavorite(String productId) async {
    emit(RemoveFavoriteLoading());
    try {
      await _apiServices.deleteData(
        "favorite_products?for_users=eq.$userId&for_products=eq.$productId",
      );
      await getProducts();
      favoriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFavoriteError());
    }
  }
}
