import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/widgets/custom_appBar.dart';
import 'package:movie_app/features/search/ui/bloc/search_movies_cubit.dart';
import 'package:movie_app/features/search/ui/bloc/search_movies_state.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/search/ui/widgets/search_movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String currentQuery = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          context.read<SearchMoviesCubit>().state is SearchMoviesLoaded) {
        context.read<SearchMoviesCubit>().fetchMoreSearch();
      }
    });
  }

  void _onSearchChanged(String query) {
    currentQuery = query.trim();
    if (currentQuery.isNotEmpty) {
      context.read<SearchMoviesCubit>().fetchInitialSearch(currentQuery);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Search Movies'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 24,
                ),
                hintText: "Search for Movies ...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
              builder: (context, state) {
                if (state is SearchMoviesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchMoviesError) {
                  return Center(child: Text(state.message));
                } else if (state is SearchMoviesLoaded) {
                  if (state.movies.isEmpty) {
                    return const Center(child: Text('No movies found.'));
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    itemCount:
                        state.movies.length + (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary,
                      endIndent: 16,
                      indent: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index < state.movies.length) {
                        final MovieEntity movie = state.movies[index];
                        return movie.poster_path != null
                            ? SearchMovieCard(
                                movie: movie,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/movieDetails',
                                    arguments: movie.id,
                                  );
                                },
                              )
                            : const SizedBox.shrink();
                      } else {
                        // Loading indicator for pagination
                        return const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );
                }

                return const Center(
                    child: Text('Start typing to search for movies.'));
              },
            ),
          )
        ],
      ),
    );
  }
}
