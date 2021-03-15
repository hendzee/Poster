import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/search_cubit.dart';
import 'package:poster/cubit/search_result_cubit.dart';
import 'package:poster/cubit/user_cubit.dart';
import 'package:poster/data/search_result_repository.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../searchbar_explore/searchbar_result.dart';

class SearchBar extends SearchDelegate<String> {
  SearchCubit searchCubit;
  SearchResultCubit searchResultCubit;
  String country;
  SearchBar(this.searchCubit);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      EasyDebounce.debounce('search-suggestion', Duration(microseconds: 500),
          () {
        searchCubit.fetchSugestionList(query);
      });
    }

    return Builder(builder: (context) {
      return BlocBuilder<SearchCubit, SearchState>(
        cubit: searchCubit,
        builder: (context, state) {
          if (state is SearchLoading) {
            return Container(
              height: MediaQuery.of(context).size.height * 20 / 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchLoaded &&
              query.isNotEmpty &&
              searchCubit.sugestions.length > 0) {
            return ListView.builder(
              itemCount: state.sugestions.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  query = state.sugestions[index];

                  showResults(context);
                },
                leading: Icon(EvaIcons.clockOutline),
                title: Text(
                  state.sugestions[index],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          return Container();
        },
      );
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(EvaIcons.closeOutline),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(EvaIcons.arrowBackOutline),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    country = BlocProvider.of<UserCubit>(context).user.country;

    searchResultCubit = SearchResultCubit(ImpSearchResultRepository());

    searchResultCubit.fetchSearchResult(query, country);

    return SearchbarResult(
      searchResultCubit: searchResultCubit,
      country: country,
      query: query,
    );
  }
}
