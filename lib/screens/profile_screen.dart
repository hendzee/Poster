import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/mine_cubit.dart';
import 'package:poster/cubit/subscription_cubit.dart';
import 'package:poster/cubit/user_cubit.dart';

import '../data/mine_repository.dart';
import '../data/subscription_repository.dart';
import '../widgets/general/poster_card.dart';
import '../widgets/profile_screen/list_loading.dart';
import '../widgets/profile_screen/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollControllerMine = ScrollController();
  ScrollController _scrollControllerSub = ScrollController();
  MineCubit _mineCubit = MineCubit(FakeMineRepository());
  UserCubit _userCubit;
  SubscriptionCubit _subscriptionCubit =
      SubscriptionCubit(FakeSubscriptionRepository());
  String userId = '311210045'; // Dummy user id
  int counterMine = 0; // counterMine to limit infinite load
  int counterSub = 0; // counter subsription list

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _scrollControllerMine.addListener(_getMoreDataMine);
    _scrollControllerSub.addListener(_getMoreDataSub);
    super.initState();
  }

  _getMoreDataMine() {
    double maxPositionMine = _scrollControllerMine.position.maxScrollExtent;
    double currentPositionMine = _scrollControllerMine.position.pixels;

    if (currentPositionMine == maxPositionMine && counterMine < 3) {
      _mineCubit.getMoreMineList(userId);
      this.setState(() {
        counterMine += 1;
      });
    }
  }

  _getMoreDataSub() {
    double maxPositionSub = _scrollControllerSub.position.maxScrollExtent;
    double currentPositionSub = _scrollControllerSub.position.pixels;

    if (currentPositionSub == maxPositionSub && counterSub < 3) {
      _subscriptionCubit.getMoreSubscriptionList(userId);
      this.setState(() {
        counterSub += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<MineCubit>(
          create: (context) => _mineCubit,
        ),
        BlocProvider<SubscriptionCubit>(
          create: (context) => _subscriptionCubit,
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 90,
              child: Stack(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF40407A),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                  ),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoaded) {
                        return UserProfile(state.user);
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Color(0xFFABABD3),
                unselectedLabelStyle: TextStyle(color: Color(0xFFE3E8E9)),
                indicatorColor: Color(0xFF40407A),
                labelColor: Color(0xFF40407A),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    child: Text('Mine'),
                  ),
                  Tab(
                    child: Text('Subscription'),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: BlocConsumer<MineCubit, MineState>(
                      listener: (context, state) {
                        if (state is MineError) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is MineInitial) {
                          _mineCubit.getMineList(userId);
                          return ListLoading();
                        } else if (state is MineLoading) {
                          return ListLoading();
                        } else if (state is MineLoaded) {
                          return ListView.builder(
                            controller: _scrollControllerMine,
                            itemCount: counterMine < 3
                                ? state.mineList.length + 1
                                : state.mineList.length,
                            itemBuilder: (context, index) {
                              return index < state.mineList.length
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        bottom: 25,
                                      ),
                                      child: PosterCard(
                                        posterCardModel: state.mineList[index],
                                      ),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.all(10),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          );
                        } else {
                          return ListLoading();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
                      listener: (context, state) {
                        if (state is SubscriptionError) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SubscriptionInitial) {
                          _subscriptionCubit.getSubscriptionList(userId);
                          return ListLoading();
                        } else if (state is SubscriptionLoading) {
                          return ListLoading();
                        } else if (state is SubscriptionLoaded) {
                          return ListView.builder(
                            controller: _scrollControllerSub,
                            itemCount: counterSub < 3
                                ? state.subscriptionList.length + 1
                                : state.subscriptionList.length,
                            itemBuilder: (context, index) {
                              return index < state.subscriptionList.length
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        bottom: 25,
                                      ),
                                      child: PosterCard(
                                        posterCardModel:
                                            state.subscriptionList[index],
                                      ),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.all(10),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          );
                        } else {
                          return ListLoading();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
