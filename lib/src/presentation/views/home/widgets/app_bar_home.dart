import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/state/weather/weather_cubit.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

enum WeatherType {
  sunny(Ionicons.sunny_outline),
  clouds(Ionicons.cloud_outline),
  rain(Ionicons.rainy_outline),
  snow(Ionicons.snow_outline);

  final IconData iconData;

  const WeatherType(this.iconData);
}

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
            padding: const EdgeInsets.symmetric(horizontal: Gap.s),
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
                padding: const EdgeInsets.only(left: Gap.s),
                decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
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
            ),
          ),
        ],
      ),
      title: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is CurrentWeather) {
            final weatherroot = state.weatherModel;
            final weather = weatherroot.weather![0]!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(getIconData(weather.main)),
                Padding(
                  padding: const EdgeInsets.only(left: Gap.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weatherroot.main!.feelslike.round()}°C',
                        style: context.theme.textTheme.titleMedium,
                      ),
                      Text(
                        weather.description!,
                        style: context.theme.textTheme.titleSmall,
                      ),
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
        IconButton(
          onPressed: () =>
              context.pushNamed(RoutePath.routeName(RoutePath.chat)),
          icon: const Badge(
            child: Icon(
              Ionicons.chatbubble,
            ),
          ),
        ),
      ],
    );
  }

  IconData getIconData(String? value) {
    return WeatherType.values
        .firstWhere(
          (element) => element.name.toLowerCase() == value?.toLowerCase(),
          orElse: () => WeatherType.sunny,
        )
        .iconData;
  }
}
