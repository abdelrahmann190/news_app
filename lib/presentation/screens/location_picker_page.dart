import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

import '../../buisness_logic/cubit/location_cubit/location_cubit.dart';
import '../../utils/get_current_location.dart';
import '../widgets/bottom_big_button.dart';
import '../widgets/flag_and_country_card.dart';
import '../widgets/text_generator.dart';

class LocationPicker extends StatelessWidget {
  String currentLocation = '';
  LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              const Gap(30),
              const BoldText(
                text: 'Choose your location',
                fontSize: 30,
              ),
              const Gap(20),
              NormalText(
                textAlign: TextAlign.start,
                text:
                    'This will make it easier for us to show news that concerns you',
                color: Colors.black38,
                fontSize: 17,
              ),
              const Gap(20),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              const Gap(30),
              GestureDetector(
                onTap: () async {
                  final String location = await getCurrentLocation();
                  // ignore: use_build_context_synchronously
                  context.read<LocationCubit>().getCurrentLocation(location);
                },
                child: BottomBorderButton(
                  text: 'Use my current location',
                  isIconButton: true,
                  icon: Icons.gps_fixed_outlined,
                ),
              ),
              const Gap(40),
              const BoldText(
                text: 'Popular Locations',
                fontSize: 25,
              ),
              const Gap(40),
              GestureDetector(
                onTap: () {
                  context.read<LocationCubit>().getCurrentLocation('US');
                },
                child: const FlagAndCountryCard(
                  countryCode: 'US',
                  countryName: 'United States of America',
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {
                  context.read<LocationCubit>().getCurrentLocation('GB');
                },
                child: const FlagAndCountryCard(
                  countryCode: 'GB',
                  countryName: 'Great Britan',
                ),
              ),
              const Gap(155),
              BottomFilledButton(
                  text: 'Confirm your location',
                  onTap: () {
                    Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getCurrentLocation() async {
    final currentLocation = await determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation.latitude,
      currentLocation.longitude,
    );
    return placemarks[2].isoCountryCode!;
  }
}
