import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/state/weather/weather_cubit.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class AppBarHome extends StatelessWidget {
  final ScrollController scrollController;
  const AppBarHome({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      scrollController: scrollController,
      expandedHeight: 120,
      collapsedHeight: 60.0,
      flexTitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
              selector: (state) => state is MyDataState ? state.user : null,
              builder: (context, user) => CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  user?.avartar ?? urlAvatar,
                ),
              ),
            ),
          ),
          Expanded(
            child: OnTapEffect(
              onTap: () {
                context.pushNamed(RoutePath.routeName(RoutePath.writepost));
              },
              radius: 16,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).cardColor),
                child: Text(text.welcome),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.pushNamed(RoutePath.routeName(
                    RoutePath.routeName(RoutePath.writepost)));
              },
              icon: const Icon(
                Ionicons.create_outline,
              )),
        ],
      ),
      title: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is CurrentWeather) {
            final weatherroot = state.weatherModel;
            final weather = weatherroot.weather![0]!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  getIconData(weather.main),
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${weatherroot.main!.feelslike.round()}°C'),
                      Text(weather.description!),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      action: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Stack(
        //       children: [
        //         Icon(
        //           Ionicons.notifications_outline,
        //           color: colorGrey.shade700,
        //         ),
        //         Positioned(
        //             top: 0,
        //             right: 0,
        //             child: Icon(
        //               Ionicons.ellipse,
        //               size: 10,
        //               color: colorRed.shade400,
        //             )),
        //       ],
        //     ))
        IconButton(
            onPressed: () =>
                context.pushNamed(RoutePath.routeName(RoutePath.chat)),
            icon: const Stack(
              children: [
                Icon(
                  Ionicons.chatbubble,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Ionicons.ellipse,
                      size: 10,
                    )),
              ],
            ))
      ],
    );
  }

  IconData getIconData(String? value) {
    switch (value) {
      case 'Rain':
        return Ionicons.rainy_outline;
      case 'Snow':
        return Ionicons.snow_outline;
      case 'Clouds':
        return Ionicons.cloud_outline;
      default:
        return Ionicons.sunny_outline;
    }
  }
}
