import 'package:flutter/material.dart';

IconData fileIcon(String ext) {
  switch (ext) {
    case 'pdf':
      return Icons.picture_as_pdf_rounded;
    case 'zip':
      return Icons.folder_zip_rounded;
    default:
      return Icons.file_present_rounded;
  }
}
