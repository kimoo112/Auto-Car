// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ServiceCentersLoading extends HomeState {}

final class ServiceCentersLoaded extends HomeState {
  final List<ServicesCentersModel> servicesCenters;

  ServiceCentersLoaded({required this.servicesCenters});
}

final class ServiceCentersFailure extends HomeState {
  final String errMsg;

  ServiceCentersFailure({required this.errMsg});
}

class LocationLoadingRoute extends HomeState {}

class LocationLoaded extends HomeState {
  final double latitude;
  final double longitude;

  LocationLoaded({
    required this.latitude,
    required this.longitude,
  });
}

class LocationError extends HomeState {
  final String message;

  LocationError({required this.message});
}
