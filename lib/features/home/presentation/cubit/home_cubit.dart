import 'package:auto_car/core/api/exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../data/services_centers_model/services_centers_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;

  HomeCubit(this.api) : super(HomeInitial());
  List<ServicesCentersModel> servicesCenters = [];
  double? latitude;
  double? longitude;
  getServicesCenters() async {
    emit(ServiceCentersLoading());
    try {
      final response = await api.get(
        ApiKeys.serviceCenters,
      );
      servicesCenters = (response as List)
          .map((item) => ServicesCentersModel.fromJson(item))
          .toList();
      emit(ServiceCentersLoaded(servicesCenters: servicesCenters));
    } on ServerException catch (e) {
      emit(ServiceCentersFailure(errMsg: e.errModel.errorMessage));
    }
  }

  Future<void> getLocation() async {
    emit(LocationLoadingRoute());
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        latitude = position.latitude;
        longitude = position.longitude;
        emit(LocationLoaded(
          latitude: latitude!,
          longitude: longitude!,
        ));
      } catch (e) {
        emit(LocationError(message: "Error fetching location: $e"));
      }
    } else {
      emit(LocationError(message: "Location permission is not granted."));
    }
  }
}
