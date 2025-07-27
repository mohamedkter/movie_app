import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/core/firebase/firebase_service.dart';

class FavoriteQrScanScreen extends StatefulWidget {
  const FavoriteQrScanScreen({super.key});

  @override
  State<FavoriteQrScanScreen> createState() => _FavoriteQrScanScreenState();
}

class _FavoriteQrScanScreenState extends State<FavoriteQrScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanned = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    controller?.scannedDataStream.listen((scanData) async {
      if (scanned || scanData.code == null) return;

      scanned = true;

      // Show loading dialog
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      }

      try {
        final jsonStr = utf8.decode(base64Decode(scanData.code!));
        final List decodedList = jsonDecode(jsonStr);

        final List<MovieModel> movies =
            decodedList.map((e) => MovieModel.fromMap(e)).toList();

        for (var movie in movies) {
          await FirebaseService.addToFavorites(movie);
        }

        if (mounted) {
          Navigator.of(context).pop(); // close loader
          Navigator.of(context).pop(); // close scanner screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Favorites imported successfully")),
          );
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // close loader
          Navigator.of(context).pop(); // close scanner screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid QR Code format")),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}
