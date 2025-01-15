import 'package:auto_car/core/api/exceptions.dart';
import 'package:auto_car/core/cache/cache_helper.dart';
import 'package:auto_car/features/home/data/fuel_stations_model/fuel_stations_model.dart';
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
  List<FuelStationsModel> fuelStations = [];
  double? latitude;
  double? longitude;
  bool _isRequestingLocation = false;
  getServicesCenters() async {
    emit(ServiceCentersLoading());
    try {
      final response = await api.get(
        ApiKeys.serviceCenters,
      );
      servicesCenters = (response as List)
          .map((item) => ServicesCentersModel.fromJson(item))
          .toList();
      for (var center in servicesCenters) {
        if (center.id != null && center.name != null) {
          await CacheHelper.saveData(key: center.id!, value: center.name!);
        }
      }
      emit(ServiceCentersLoaded(servicesCenters: servicesCenters));
    } on ServerException catch (e) {
      emit(ServiceCentersFailure(errMsg: e.errModel.errorMessage));
    }
  }

  getFuelStations() async {
    emit(FuelStationsLoading());
    try {
      final response = await api.get(ApiKeys.fuelStations);
      fuelStations = (response as List)
          .map((item) => FuelStationsModel.fromJson(item))
          .toList();
      emit(FuelStationsLoaded(fuelStations: fuelStations));
    } on ServerException catch (e) {
      emit(FuelStationsFailure(errMsg: e.errModel.errorMessage));
    }
  }

  Future<void> getLocation() async {
    if (_isRequestingLocation) return; // Prevent multiple requests

    _isRequestingLocation = true;
    emit(LocationLoadingRoute());

    try {
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
      } else if (permissionStatus.isPermanentlyDenied) {
        await openAppSettings(); // Direct user to settings
        emit(LocationError(
            message: "Location permission is permanently denied."));
      } else {
        emit(LocationError(message: "Location permission is not granted."));
      }
    } catch (e) {
      emit(LocationError(message: "Unexpected error: $e"));
    } finally {
      _isRequestingLocation = false; 
    }
  }
}
