part of 'productdetails_cubit.dart';

sealed class ProductdetailsState extends Equatable {
  const ProductdetailsState();

  @override
  List<Object> get props => [];
}

final class ProductdetailsInitial extends ProductdetailsState {}

final class GetRateLoading extends ProductdetailsState {}

final class GetRateSuccess extends ProductdetailsState {}

final class GetRateError extends ProductdetailsState {}

final class AddOrUpdateRateLoading extends ProductdetailsState {}

final class AddOrUpdateRateSuccess extends ProductdetailsState {}

final class AddOrUpdateRateError extends ProductdetailsState {}

final class AddCommentsLoading extends ProductdetailsState {}

final class AddCommentsSuccess extends ProductdetailsState {}

final class AddCommentsError extends ProductdetailsState {}
