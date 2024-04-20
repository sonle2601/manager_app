import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class AnhCanCuoc extends StatefulWidget {
  final String text;
  final Function(String)? onImageSelected;

  const AnhCanCuoc({Key? key, required this.text, this.onImageSelected}) : super(key: key);

  @override
  State<AnhCanCuoc> createState() => _AnhCanCuocState();
}

class _AnhCanCuocState extends State<AnhCanCuoc> {
  final cloudinary = CloudinaryPublic('dtxkcvzg4', 'n1bn55kx');
  String? _imageUrl;
  bool _isUploading = false;

  Future<void> _pickAndUploadImage(ImageSource source) async {
    setState(() {
      _isUploading = true; // Bắt đầu quá trình tải ảnh lên
    });
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      File? croppedFile = await _cropImage(pickedImage.path);
      if (croppedFile != null) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(croppedFile.path),
        );
        if (response != null && response.secureUrl != null) {
          setState(() {
            _imageUrl = response.secureUrl;
            if(widget.onImageSelected != null) {
              widget.onImageSelected!(_imageUrl!);
            }
            _isUploading = false;
          });

        } else {
          print('Upload failed.');
          _isUploading = false;
        }
      } else {
        print('Image cropping failed.');
        _isUploading = false;
      }
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    ImageCropper imageCropper = ImageCropper();
    File? croppedFile = await imageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Chỉnh sửa ảnh',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 4 / 3,
        aspectRatioLockEnabled: true,
      ),
    );
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Column(
        children: [
          Center(
            child: IgnorePointer(
              ignoring: _isUploading,
              child: GestureDetector(
                onTap: _isUploading ? null : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Chọn ảnh"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text("Chụp ảnh"),
                              onTap: () {
                                Navigator.of(context).pop();
                                _pickAndUploadImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text("Chọn ảnh từ thư viện"),
                              onTap: () {
                                Navigator.of(context).pop();
                                _pickAndUploadImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 350,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _isUploading
                        ? Center(
                            child: CircularProgressIndicator(), // Hiển thị vòng quay loading khi đang tải ảnh lên
                    )
                     : _imageUrl != null
                        ? Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                    )
                        : Column(
                      children: [
                        SizedBox(height: 20,),
                        Image.asset(
                          "assets/images/add_photo.png",
                          height: 80,
                        ),
                        const SizedBox(height: 20),
                         Text(
                          widget.text,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


