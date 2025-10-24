import 'package:bloc/bloc.dart';
import 'package:e_commerce_supabase/core/services/api_sevices.dart';
import 'package:e_commerce_supabase/features/product_details/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'productdetails_state.dart';

class ProductdetailsCubit extends Cubit<ProductdetailsState> {
  ProductdetailsCubit() : super(ProductdetailsInitial());
  final ApiSevices _apiSevices = ApiSevices();
  List<ProductDetailsModel> productDetails = [];

  Future<void> getRates({required int productId}) async {
    emit(ProductdetailsLoading());
    try {
      final response = await _apiSevices.getData(
        'rates?select=*&for_users=eq.75354b41-81ad-4d4c-ba10-bbad7956b513&for_products=eq.$productId',
      );
      productDetails.clear();
      for (final item in (response.data as List<dynamic>)) {
        productDetails.add(
          ProductDetailsModel.fromJson(item as Map<String, dynamic>),
        );
      }
      emit(ProductdetailsSuccess());
    } catch (e) {
      emit(ProductdetailsError());
    }
  }
}
