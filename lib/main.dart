import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;
late CameraController _controller;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera App')),
      body: Center(
        child: _isCameraInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: _isCameraInitialized
          ? FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  final image = await _controller.takePicture();
                  // Use the captured image as required
                  print('Image path: ${image.path}');
                } catch (e) {
                  print(e);
                }
              },
            )
          : null,
    );
  }
}
