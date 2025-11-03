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

  //* Safe safeEmit to prevent safeEmitting states after the cubit is closed
  void safeEmit(HomeState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> getProducts({String? qurey, String? category}) async {
    safeEmit(HomeLoading());
    try {
      final response = await _apiServices.getData(
        'products?select=*,favorite_products(*),purchase(*)',
      );
      if (isClosed) return;

      products.clear();
      searchResults.clear();
      categoryProducts.clear();
      favoriteProducts.clear();
      favoriteProductList.clear();
      for (final item in (response.data as List<dynamic>)) {
        final product = ProductModel.fromJson(item as Map<String, dynamic>);
        products.add(product);

        //* Check if product is favorited by current user from API response
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
      if (isClosed) return;

      getFavoriteProducts();
      search(qurey);
      getProuductsOfCategory(category);
      safeEmit(HomeSuccess());
    } catch (e) {
      log(e.toString());
      safeEmit(HomeError());
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
      safeEmit(AddToFavoriteLoading());
      await _apiServices.postData('favorite_products', {
        'is_favorite': true,
        'for_users': userId,
        'for_products': productId,
      });

      if (isClosed) return;

      await getProducts();

      if (isClosed) return;

      favoriteProducts.addAll({productId: true});
      safeEmit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      safeEmit(AddToFavoriteError());
    }
  }

  bool checkIfFavoureite(productId) {
    return favoriteProducts.containsKey(productId);
  }

  Future<void> removeFavorite(String productId) async {
    safeEmit(RemoveFavoriteLoading());
    try {
      await _apiServices.deleteData(
        "favorite_products?for_users=eq.$userId&for_products=eq.$productId",
      );
      if (isClosed) return;

      await getProducts();

      if (isClosed) return;

      favoriteProducts.removeWhere((key, value) => key == productId);
      safeEmit(RemoveFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      safeEmit(RemoveFavoriteError());
    }
  }

  List<ProductModel> favoriteProductList = [];
  void getFavoriteProducts() {
    favoriteProductList.clear();
    for (ProductModel product in products) {
      if (product.favoriteProducts.isNotEmpty) {
        for (FavoriteProduct favoriteProduct in product.favoriteProducts) {
          if (favoriteProduct.forUsers == userId) {
            favoriteProductList.add(product);
            //* add only one product for favorite
            //! favoriteProducts[product.productId] = true;
            //** add all favorite products
            favoriteProducts.addAll({product.productId: true});
            break;
          }
        }
      }
    }
  }
}
