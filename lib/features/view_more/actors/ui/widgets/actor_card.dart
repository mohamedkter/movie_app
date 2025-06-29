import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/view_more/actors/domain/entities/actor_entity.dart';
import 'known_for_movie_tile.dart';

class ActorCard extends StatefulWidget {
  final ActorEntity actor;

  const ActorCard({super.key, required this.actor});

  @override
  State<ActorCard> createState() => _ActorCardState();
}

class _ActorCardState extends State<ActorCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: CachedNetworkImageProvider(
                    "https://image.tmdb.org/t/p/w500${widget.actor.profilePath}",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.actor.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(widget.actor.originalName ?? '',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        "Popularity: ${widget.actor.popularity.toStringAsFixed(1)}",
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: isExpanded
                      ? AppIcons.doubleArrowUp(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : AppIcons.doubleArrowDown(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              child: isExpanded && widget.actor.knownFor.isNotEmpty
                  ? Column(
                      children: widget.actor.knownFor
                          .where(
                              (movie) => (movie.title ?? '').trim().isNotEmpty)
                          .map((movie) => KnownForMovieTile(movie: movie))
                          .toList(),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
