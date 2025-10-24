part of 'productdetails_cubit.dart';

sealed class ProductdetailsState extends Equatable {
  const ProductdetailsState();

  @override
  List<Object> get props => [];
}

final class ProductdetailsInitial extends ProductdetailsState {}

final class ProductdetailsLoading extends ProductdetailsState {}

final class ProductdetailsSuccess extends ProductdetailsState {}

final class ProductdetailsError extends ProductdetailsState {}
