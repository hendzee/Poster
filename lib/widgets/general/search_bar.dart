import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/cubit/search_cubit.dart';

import '../searchbar_explore/searchbar_result.dart';

class SearchBar extends SearchDelegate<String> {
  SearchCubit searchCubit;

  SearchBar(this.searchCubit);

  // Recent Dummy Data
  final recents = [
    'Concert 2020',
    'Indonesian Flower Festival',
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      searchCubit.fetchSugestionList(query);
    }

    return BlocProvider<SearchCubit>(
      create: (context) => searchCubit,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaded) {
            return ListView.builder(
              itemCount: state.sugestions.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  showResults(context);
                  query = state.sugestions[index];
                },
                leading: Icon(EvaIcons.clockOutline),
                title: RichText(
                  text: TextSpan(
                    text: state.sugestions[index].substring(0, query.length),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(
                          text: state.sugestions[index].substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
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
    print(query);
    return SearchbarResult();
  }
}
