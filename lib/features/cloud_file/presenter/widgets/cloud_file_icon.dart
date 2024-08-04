import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_exporer_model.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/utils/file_icon.dart';

class CloudFileIcon extends StatelessWidget {
  final AppFileExplorer item;
  final String? url;
  const CloudFileIcon({required this.item, this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final List<String> extessionsWithLImagePreviewSupport = [
          'png',
          'jpg',
          'jpeg',
          'svg'
        ];

        IconData getIcon() {
          if (item.type == 'folder') {
            return Icons.folder;
          }
          if (item.type == 'back_folder') {
            return Icons.drive_folder_upload_rounded;
          }
          return fileIcon(item.name.split('.').last);
        }

        if (extessionsWithLImagePreviewSupport
                .contains(item.name.split('.').last) &&
            url != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Builder(
              builder: (context) {
                if (item.name.split('.').last == 'svg') {
                  return SvgPicture.network(
                    url!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  );
                }
                return Image.network(
                  url!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                );
              },
            ),
          );
        }
        return Icon(
          getIcon(),
          color: Theme.of(context).buttonTheme.colorScheme!.primary,
          size: 40,
        );
      },
    );
  }
}
