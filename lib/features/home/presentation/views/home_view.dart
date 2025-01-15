import 'package:auto_car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    context.read<HomeCubit>().getLocation();
    context.read<HomeCubit>().getServicesCenters();
    context.read<HomeCubit>().getFuelStations();
  }

  LatLng? initialLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LocationLoadingRoute ||
            state is ServiceCentersLoading ||
            state is FuelStationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LocationError || state is ServiceCentersFailure) {
          return Center(
            child: Text(
              state is LocationError
                  ? state.message
                  : (state as ServiceCentersFailure).errMsg,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is LocationLoaded ||
            state is ServiceCentersLoaded ||
            state is FuelStationsLoaded) {
          final cubit = context.read<HomeCubit>();
          if (initialLocation == null &&
              cubit.latitude != null &&
              cubit.longitude != null) {
            initialLocation = LatLng(cubit.latitude!, cubit.longitude!);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              mapController.move(initialLocation!, 11.0);
            });
          }
          final markers = <Marker>[
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(cubit.latitude ?? 0.0, cubit.longitude ?? 0.0),
              child: Icon(
                IconlyBold.location,
                color: AppColors.blue,
                size: 40.0,
              ),
            ),
            ...List<Marker>.generate(
              cubit.servicesCenters.length,
              (index) {
                final center = cubit.servicesCenters[index];
                final coordinates = center.location?.coordinates;
                if (coordinates != null && coordinates.length == 2) {
                  final lat = coordinates[1];
                  final lng = coordinates[0];
                  debugPrint(
                      'Marker $index: ${center.name}, LatLng: ($lat, $lng)');
                  return Marker(
                      width: 60,
                      height: 60,
                      point:
                          LatLng(lat + (0.001 / index), lng + (0.01 * index)),
                      child: GestureDetector(
                          onTap: () {
                            _showServiceCenterDetails(context, center);
                          },
                          child: Image.asset(Assets.imagesServicesCenters)));
                } else {
                  return const Marker(
                    point: LatLng(0.0, 0.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
            ...List<Marker>.generate(
              cubit.fuelStations.length,
              (index) {
                final center = cubit.fuelStations[index];
                final coordinates = center.location?.coordinates;
                if (coordinates != null && coordinates.length == 2) {
                  final lat = coordinates[1];
                  final lng = coordinates[0];
                  debugPrint(
                      'Fuel Stations $index: ${center.name}, LatLng: ($lat, $lng)');
                  return Marker(
                      width: 60,
                      height: 60,
                      point: LatLng(lat + 0.01, lng + 0.1),
                      child: GestureDetector(
                          onTap: () {
                            _showServiceCenterDetails(context, center);
                          },
                          child: Image.asset(Assets.imagesFuelStation)));
                } else {
                  return const Marker(
                    point: LatLng(0.0, 0.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
          ];
          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: initialLocation ?? const LatLng(41.0, 40.0),
              minZoom: 11,
              maxZoom: 16,
              onTap: (_, point) {
                debugPrint('Map tapped at $point');
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: markers),
            ],
          );
        }
        return const SizedBox();
      },
    ), floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool showFab = state is LocationError ||
            (initialLocation == null ||
                (initialLocation!.latitude == 41.0 &&
                    initialLocation!.longitude == 40.0));
        if (showFab) {
          return Padding(
            padding:  EdgeInsets.only(bottom:40.0.sp),
            child: FloatingActionButton(
              onPressed: () {
                context.read<HomeCubit>().getLocation();
              },
              backgroundColor: AppColors.primaryColor,
              child: const Icon(IconlyBold.location),
            ),
          );
        }

        return const SizedBox();
      },
    ));
  }

  void _showServiceCenterDetails(BuildContext context, center) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.business, color: Colors.blue, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        center.name ?? "Service Center",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(IconlyBold.activity, color: Colors.orange, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Services: ${center.services?.join(', ') ?? "No services available"}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(IconlyBold.call, color: Colors.green, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Contact: ${center.contact ?? "N/A"}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
