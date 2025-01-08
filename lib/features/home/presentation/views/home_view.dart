import 'package:auto_car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/services_centers_model/services_centers_model.dart';

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
  }

  LatLng? initialLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LocationLoadingRoute || state is ServiceCentersLoading) {
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
          } else if (state is LocationLoaded || state is ServiceCentersLoaded) {
            final cubit = context.read<HomeCubit>();
            if (initialLocation == null &&
                cubit.latitude != null &&
                cubit.longitude != null) {
              initialLocation = LatLng(cubit.latitude!, cubit.longitude!);

              // Use post-frame callback to move the map after it has been rendered
              WidgetsBinding.instance.addPostFrameCallback((_) {
                mapController.move(
                    initialLocation!, 11.0); // Move to user location
              });
            }

            final markers = <Marker>[
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                    cubit.latitude ?? 0.0,
                    cubit.longitude ??
                        0.0), // Default to (0, 0) if latitude/longitude is null
                child: Icon(
                  IconlyBold.location,
                  color: AppColors.blue,
                  size: 40.0,
                ),
              ),
              // Service centers markers
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
                            LatLng(lat, lng), // Ensure correct Lat, Lng order
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
            ];

            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: initialLocation ??
                    const LatLng(
                        41.0, 40.0), // Default location if no initial location
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
      ),
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          if (cubit.latitude != null && cubit.longitude != null) {
            return FloatingActionButton(
              onPressed: () {
                context.read<HomeCubit>().getLocation();
              },
              child: const Icon(Icons.my_location),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showServiceCenterDetails(
      BuildContext context, ServicesCentersModel center) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                center.name!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Services: ${center.services?.join(', ')}'),
              const SizedBox(height: 8),
              Text('Contact: ${center.contact ?? 'N/A'}'),
            ],
          ),
        );
      },
    );
  }
}
