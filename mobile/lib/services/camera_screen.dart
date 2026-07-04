import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/ocr_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final OCRService ocr = OCRService();
  final ImagePicker picker = ImagePicker();

  File? image;
  String extractedText = "";
  bool loading = false;

  Future<void> takePhoto() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
        loading = true;
      });

      final text = await ocr.extractText(image!);

      setState(() {
        extractedText = text;
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    ocr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Caméra Canevas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ElevatedButton(
              onPressed: takePhoto,
              child: const Text("📸 Prendre une photo"),
            ),

            const SizedBox(height: 10),

            if (image != null)
              Image.file(image!, height: 200),

            const SizedBox(height: 10),

            if (loading)
              const CircularProgressIndicator(),

            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Text(extractedText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
