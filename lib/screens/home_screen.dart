import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/comingsoon_cubit.dart';
import 'package:poster/cubit/recomended_cubit.dart';
import 'package:poster/data/comingsoon_repository.dart';
import 'package:poster/data/recomended_repository.dart';

import '../cubit/trending_cubit.dart';
import '../data/trending_repository.dart';
import '../widgets/home_screen/coming_soon_list.dart'; // Substance of home screen
import '../widgets/home_screen/recomended_list.dart'; // Substance of home screen
import '../widgets/home_screen/top_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_content_loading.dart'; // Substance of home screen
import '../widgets/home_screen/trending_title_content.dart'; // Substance of home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String country = 'ID'; // Just example until database was built

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingCubit>(
          create: (context) => TrendingCubit(ImpTrendingRepository()),
        ),
        BlocProvider<RecomendedCubit>(
          create: (context) => RecomendedCubit(ImpRecomendedRepository()),
        ),
        BlocProvider<ComingsoonCubit>(
          create: (context) => ComingsoonCubit(ImpComingSoonRepository()),
        )
      ],
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopContent(),
            TrendingTitleContent(),
            BlocConsumer<TrendingCubit, TrendingState>(
              listener: (context, state) {
                if (state is TrendingError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is TrendingInitial) {
                  BlocProvider.of<TrendingCubit>(context).getTrending(country);

                  return TrendingContentLoading();
                } else if (state is TrendingLoading) {
                  return TrendingContentLoading();
                } else if (state is TrendingLoaded) {
                  return TrendingContent(
                    posterCardModel: state.posterCardModel,
                  );
                } else {
                  return TrendingContentLoading();
                }
              },
            ),
            RecomendedList(
              country: this.country,
            ),
            ComingSoonList(
              country: this.country,
            )
          ],
        ),
      )),
    );
  }
}
