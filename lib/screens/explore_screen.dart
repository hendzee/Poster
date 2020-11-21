import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/widgets/explore_screen/explore_list_loading.dart';
import 'package:poster/widgets/general/search_bar.dart';

import '../cubit/explore_cubit.dart';
import '../data/explore_repository.dart';
import '../widgets/general/poster_card.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ScrollController _scrollController = ScrollController();
  ExploreCubit _exploreCubit = ExploreCubit(FakeExploreRepository());
  final String country = 'Indonesia';
  int _counter = 0; // Its dummy counter for infinite list

  @override
  void initState() {
    _scrollController.addListener(_getMoreData);
    super.initState();
  }

  void _getMoreData() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && _counter < 5) {
      _exploreCubit.getMoreExploreList(country);

      this.setState(() {
        _counter += 1;
      });
    }
  }

  // Set categories tab
  Widget _setCategoriesTab(String title, bool isActive) {
    return (Container(
        decoration: BoxDecoration(
          color: Color(isActive ? 0xFF40407A : 0xFFABABD3),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text('Explore'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchBar());
                },
                child: Icon(EvaIcons.searchOutline)),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => _exploreCubit,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Around World', true),
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Another Trend', false),
                    SizedBox(
                      width: 25,
                    ),
                    _setCategoriesTab('Recomended', false),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<ExploreCubit, ExploreState>(
                  listener: (context, state) {
                    if (state is ExploreError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ExploreInitial) {
                      BlocProvider.of<ExploreCubit>(context)
                          .getExploreList(country);

                      return ExploreListLoading();
                    } else if (state is ExploreLoading) {
                      return ExploreListLoading();
                    } else if (state is ExploreError) {
                      return ExploreListLoading();
                    } else if (state is ExploreLoaded) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: _counter < 4
                            ? state.exploreList.length + 1
                            : state.exploreList.length,
                        itemBuilder: (context, index) {
                          if (index < state.exploreList.length) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, left: 25, bottom: 25),
                              child: PosterCard(
                                posterCardModel: state.exploreList[index],
                              ),
                            );
                          }

                          return Container(
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
