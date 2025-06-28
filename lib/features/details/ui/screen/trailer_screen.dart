import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/core/utils/widgets/custom_appBar.dart';
import 'package:movie_app/features/details/data/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  final List<VideoModel> videos;

  const TrailerScreen({
    super.key,
    required this.videos,
  });

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;
  late VideoModel currentVideo;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentVideo = widget.videos.first;
    _controller = YoutubePlayerController(
      initialVideoId: currentVideo.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  void _playVideo(VideoModel video) {
    if (video.key == currentVideo.key) return;
    setState(() {
      currentVideo = video;
      _controller.load(video.key);
    });
  }

  @override
 void dispose() {
  _controller.pause();     
  _controller.dispose();
  _scrollController.dispose();
  super.dispose();
}

  Widget _buildOtherVideos() {
    final others = widget.videos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            "More Videos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: others.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final video = others[index];
            return GestureDetector(
              onTap: () => _playVideo(video),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12)),
                      child: Image.network(
                        "https://img.youtube.com/vi/${video.key}/0.jpg",
                        width: 140,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              video.type,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CustomAppBar(title: currentVideo.type,),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
              playedColor: Theme.of(context).colorScheme.primary,
              handleColor: Theme.of(context).colorScheme.primary,
            ),
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text(
                      currentVideo.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  _buildOtherVideos(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
