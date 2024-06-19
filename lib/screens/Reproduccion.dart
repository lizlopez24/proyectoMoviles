import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main(){
  runApp(ReproducionApp(data: '', nombre: '',));
}
class ReproducionApp extends StatefulWidget {

  final String data;
  final String nombre;
  ReproducionApp({required this.data, required this.nombre});
  
 @override
  _ReproducionAppState createState() => _ReproducionAppState();
}

class _ReproducionAppState extends State<ReproducionApp> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.data))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombre)),
      body: Container(
        decoration: BoxDecoration(
        color: Color.fromARGB(255, 14, 16, 65),
      ),
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(data)
    );
  }
}

Widget Cuerpo(data){
  final httpsReference = FirebaseStorage.instance.refFromURL(data);
  final video=httpsReference.getDownloadURL();

  return Column(
    children: [
      Text("Dato: $data")
    ],
  );
}

  


class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/SampleVideo_720x480_5mb.mp4'
    )..initialize().then((_) {
        setState(() {});
      });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reproductor de Vídeo'),
      ),
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
*/