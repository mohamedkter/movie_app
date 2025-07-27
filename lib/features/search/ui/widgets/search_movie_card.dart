import 'package:flutter/material.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

class SearchMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;

  const SearchMovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
              
                     'https://image.tmdb.org/t/p/w185${movie.poster_path}',
          
                width: 92,
                height: 138,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Movie Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? movie.original_title ?? "No title",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.vote_average?.toStringAsFixed(1) ?? "N/A"}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Language: ${movie.original_language?.toUpperCase() ?? "N/A"}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),

                  if (movie.popularity != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Popularity: ${movie.popularity!.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
