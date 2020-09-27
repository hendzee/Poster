import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/trending_cubit.dart';
import '../data/trending_repository.dart';
import '../widgets/home_screen/coming_soon_list.dart'; // Substance of home screen
import '../widgets/home_screen/recomended_list.dart'; // Substance of home screen
import '../widgets/home_screen/top_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_title_content.dart'; // Substance of home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String country = 'Indonesia'; // Just example until database was built

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingCubit(FakeTrendingRepository()),
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
                  context.bloc<TrendingCubit>().getTrending(country);
                  return Text('Loading');
                } else if (state is TrendingLoading) {
                  return Text('Loading');
                } else if (state is TrendingLoaded) {
                  return TrendingContent(
                    posterCardModel: state.posterCardModel,
                  );
                } else if (state is TrendingError) {
                  return Text('Error to get data');
                }
              },
            ),
            RecomendedList(),
            ComingSoonList()
          ],
        ),
      )),
    );
  }
}
