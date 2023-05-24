import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart' as path;

class FileUploader extends StatefulWidget {
  const FileUploader({super.key});

  @override
  State<FileUploader> createState() => _FileUploaderState();
}

class _FileUploaderState extends State<FileUploader> {
  PlatformFile? _selectedFile;
  bool isUploaded = false;
  bool isReady = true;

  Future fileSelecter() async {
    final selectedResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (selectedResult == null) {
      return;
    }

    setState(
      () {
        _selectedFile = selectedResult.files.first;
      },
    );
    print(_selectedFile!.path);
  }

  //

  Future<String> uploadFileToFilestack() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select the image first '),
        ),
      );
      return "";
    }
    isUploaded = false;
    String fileExtensionType =
        path.extension(_selectedFile!.path!).replaceAll('.', '');

    print("EXTENSION : $fileExtensionType");

    if ((fileExtensionType == "jpeg" ||
            fileExtensionType == "jpg" ||
            fileExtensionType == "png") &&
        _selectedFile != null) {
      List<int> imageBytes = await File(_selectedFile!.path!).readAsBytes();

      print("passed extension check");

      // Send the binary data to Filestack API
      final response = await http.post(
          Uri.parse(
              'https://www.filestackapi.com/api/store/S3?key=AgQ54ULwmQrOkb0OkzeVYz'),
          headers: {
            'Content-Type': 'image/$fileExtensionType',
          },
          body: imageBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploading Image'),
        ),
      );

      // Check the response and return the download URL
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
          ),
        );
        final responseData = json.decode(response.body);
        setState(() {
          isUploaded = true;
        });
        return responseData['url'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to upload file to Filestack: ${response.statusCode}'),
          ),
        );
        throw Exception(
            'Failed to upload file to Filestack: ${response.statusCode}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid File Type'),
        ),
      );
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedFile != null)
              Container(
                color: Colors.green[50],
                child: Image.file(
                  File(_selectedFile!.path!),
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ElevatedButton(
              child: const Text("Select Image"),
              onPressed: () async {
                fileSelecter();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (isUploaded != true) {
                  if (isReady == true) {
                    isReady = false;
                    print(await uploadFileToFilestack());
                  }
                } else {
                  print("record added");
                  setState(() {
                    isUploaded = false;
                    isReady = true;
                  });
                }
              },
              child: Text(isUploaded ? "Add Record" : "Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
