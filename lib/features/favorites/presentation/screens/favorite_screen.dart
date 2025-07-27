import 'package:flutter/material.dart';
import 'package:movie_app/core/firebase/firebase_service.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/favorites/presentation/screens/favorite_qr_scan_screen.dart';
import 'package:movie_app/features/favorites/presentation/screens/favorite_share_screen.dart';
import 'package:movie_app/features/favorites/presentation/widgets/favorites_movie_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<MovieModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = FirebaseService.getFavorites();
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      _loadFavorites();
    });
  }

  void _confirmDelete(MovieModel movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove from Favorites"),
        content: Text("Are you sure you want to remove \"${movie.title}\" from your favorites?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // close dialog
              await FirebaseService.removeFromFavorites(movie.id);
            
              _refreshFavorites();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title:  Text('Share favorites as QR' ,style:Theme.of(context).textTheme.bodySmall ,),
  actions: [
    IconButton(
  icon: const Icon(Icons.qr_code_scanner),
  tooltip: 'Import favorites via QR',
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FavoriteQrScanScreen(), 
      ),
    );
  },
),
    IconButton(
      icon: const Icon(Icons.qr_code),
      tooltip: 'Share favorites as QR',
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FavoriteShareScreen(),
          ),
        );
      },
    ),
  ],
),
      body: FutureBuilder<List<MovieModel>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading favorites"));
          }

          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(child: Text("No favorite movies found."));
          }

          return RefreshIndicator(
            onRefresh: _refreshFavorites,
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return FavoritesMovieCard(
                  movie: movie,
                  onDeleteTap: () => _confirmDelete(movie),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
