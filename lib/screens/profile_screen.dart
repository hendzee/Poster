import 'package:flutter/material.dart';
import 'package:poster/cubit/mine_cubit.dart';
import 'package:poster/data/mine_repository.dart';
import 'package:poster/widgets/general/poster_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/profile_screen/user_profile.dart';

import '../data/models/poster_card_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollControllerMine = ScrollController();
  MineCubit _mineCubit = MineCubit(FakeMineRepository());
  String userId = '311210045'; // Dummy user id
  int counterMine = 0; // counterMine to limit infinite load

  // This is dummy data for this page
  final PosterCardModel _posterCardModel1 = new PosterCardModel(
      title: 'Harmony Concert 2020',
      date: '20 Sep, 2020',
      location: 'Embong anyar Street no 10, Malang',
      description:
          'Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum',
      posterImage: 'assets/dummy_images/poster1.png');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _scrollControllerMine.addListener(_getMoreDataMine);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => _mineCubit,
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
                            bottomRight: Radius.circular(60))),
                  ),
                  UserProfile(),
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
                          return Text('Loading');
                        } else if (state is MineLoading) {
                          return Text('Loading');
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
                          return Text('Loading');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PosterCard(
                            posterCardModel: _posterCardModel1,
                          ),
                        ],
                      ),
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
