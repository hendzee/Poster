import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/explore_cubit.dart';
import '../cubit/search_cubit.dart';
import '../cubit/user_cubit.dart';
import '../data/explore_repository.dart';
import '../data/search_repository.dart';
import '../widgets/explore_screen/explore_list_loading.dart';
import '../widgets/general/poster_card.dart';
import '../widgets/general/search_bar.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ScrollController _scrollController = ScrollController();
  ExploreCubit _exploreCubit = ExploreCubit(ImpExploreRepository());
  SearchCubit _searchCubit = SearchCubit(ImpSearchRepository());
  int _selectedCategory = 0;

  String country = '';

  @override
  void initState() {
    country = BlocProvider.of<UserCubit>(context).user.country;
    _scrollController.addListener(_getMoreData);

    super.initState();
  }

  void _getMoreData() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        (_exploreCubit.currentPage < _exploreCubit.lastPage)) {
      _exploreCubit.getExploreList(country);
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
      ),
    ));
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
                showSearch(context: context, delegate: SearchBar(_searchCubit));
              },
              child: Icon(EvaIcons.searchOutline),
            ),
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
                margin: EdgeInsets.only(top: 25, bottom: 10),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = 0;
                        });
                      },
                      child: _setCategoriesTab(
                          'Around World', _selectedCategory == 0),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = 1;
                        });
                      },
                      child: _setCategoriesTab(
                          'Another Trend', _selectedCategory == 1),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = 2;
                        });
                      },
                      child: _setCategoriesTab(
                          'Recomended', _selectedCategory == 2),
                    ),
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
                        itemCount: _exploreCubit.exploreList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.exploreList.length) {
                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.all(25)
                                  : const EdgeInsets.only(
                                      right: 25,
                                      left: 25,
                                      bottom: 25,
                                    ),
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
                    }
                    return Container();
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
