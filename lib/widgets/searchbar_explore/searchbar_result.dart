import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/search_cubit.dart';
import 'package:poster/cubit/search_result_cubit.dart';

import '../general/poster_card.dart';

class SearchbarResult extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  SearchResultCubit searchResultCubit;
  String country;
  String query;

  SearchbarResult({this.searchResultCubit, this.country, this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchResultCubit>(
        create: (context) => searchResultCubit,
        child: Builder(
          builder: (context) {
            return BlocBuilder<SearchResultCubit, SearchResultState>(
              cubit: BlocProvider.of<SearchResultCubit>(context),
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 20 / 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is SearchResultLoaded &&
                    searchResultCubit.searchResultList != null &&
                    searchResultCubit.searchResultList.length > 0) {
                  return NotificationListener(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: searchResultCubit.searchResultList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: PosterCard(
                            posterCardModel: state.searchResultList[index],
                          ),
                        );
                      },
                    ),
                    onNotification: (_) {
                      double maxScroll =
                          _scrollController.position.maxScrollExtent;
                      double currentScroll = _scrollController.position.pixels;

                      if (currentScroll == maxScroll &&
                          (searchResultCubit.currentPage !=
                              searchResultCubit.lastPage)) {
                        searchResultCubit.fetchSearchResult(query, country);
                      }
                    },
                  );
                } else if (state is SearchResultLoaded &&
                    query.isNotEmpty &&
                    (searchResultCubit.searchResultList == null ||
                        searchResultCubit.searchResultList.length < 1)) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Text('Your search not found, please try another.'),
                  );
                }
                return Container();
              },
            );
          },
        ));
  }
}
