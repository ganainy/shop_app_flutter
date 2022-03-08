import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/search_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.get(context);
/*  if (searchController.value.text.isEmpty) {
                            searchCubit.resetSearch();
                            return;
                          }
                          searchCubit.search(searchController.value.text);*/
          var screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: SafeArea(
                child: Container(
              height: 1000,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: DefaultFormField(
                        labelText: 'Search',
                        controller: searchController,
                        prefixIcon: const Icon(Icons.search),
                        onFieldSubmitted: (query) {
                          if (searchController.value.text.isEmpty) {
                            searchCubit.resetSearch();
                            return;
                          }
                          searchCubit.search(searchController.value.text);
                        }),
                  ),
                  const SizedBox(height: 8),
                  (() {
                    if (searchCubit.state is SearchError) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: Center(
                              child: Text((searchCubit.state as SearchError)
                                  .errorMessage),
                            )),
                          ],
                        ),
                      );
                    } else if (searchCubit.state is SearchLoading) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              child: Center(
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (searchCubit.products.isNotEmpty) {
                      return Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          child: GridView.count(
                            physics: const BouncingScrollPhysics(),
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: .70,
                            crossAxisCount: 2,
                            children: List.generate(searchCubit.products.length,
                                (index) {
                              return SearchProduct(searchCubit.products[index],
                                  screenWidth, searchCubit, context);
                            }),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              child: Center(
                                child: Text(
                                    'Type something to start searching...'),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }()),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
