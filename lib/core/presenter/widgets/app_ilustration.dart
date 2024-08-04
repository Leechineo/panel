import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIlustrations {
  playingCards,
  floating,
  upload,
  addFiles,
  wellDone,
  folderFiles,
  myFiles,
  femaleUser,
  watchApplication,
  containerShip,
  mapDark,
  locationReview,
  locationSearch,
  orderDelivered,
  shoppingBags,
  loveIt,
  choose,
  selectOption,
  creditCard,
  underConstruction,
  creativeTeam,
  post,
  images,
}

class AppIlustration extends StatelessWidget {
  final double? width;
  final double? height;
  final AppIlustrations ilustration;

  const AppIlustration(
    this.ilustration, {
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String illustrationId = _getIllustrationId(ilustration);
    return SvgPicture.asset(
      'assets/Ilustrations/undraw/$illustrationId.svg',
      width: width,
      height: height,
    );
  }

  String _getIllustrationId(AppIlustrations illustration) {
    switch (illustration) {
      case AppIlustrations.playingCards:
        return 'playing_cards';
      case AppIlustrations.floating:
        return 'floating';
      case AppIlustrations.upload:
        return 'upload';
      case AppIlustrations.addFiles:
        return 'add_files';
      case AppIlustrations.wellDone:
        return 'well_done';
      case AppIlustrations.folderFiles:
        return 'folder_files';
      case AppIlustrations.myFiles:
        return 'my_files';
      case AppIlustrations.femaleUser:
        return 'female_user';
      case AppIlustrations.watchApplication:
        return 'watch_application';
      case AppIlustrations.containerShip:
        return 'container_ship';
      case AppIlustrations.mapDark:
        return 'map_dark';
      case AppIlustrations.locationReview:
        return 'location_review';
      case AppIlustrations.locationSearch:
        return 'location_search';
      case AppIlustrations.orderDelivered:
        return 'order_delivered';
      case AppIlustrations.shoppingBags:
        return 'shopping_bags';
      case AppIlustrations.loveIt:
        return 'love_it';
      case AppIlustrations.choose:
        return 'choose';
      case AppIlustrations.selectOption:
        return 'select_option';
      case AppIlustrations.creditCard:
        return 'credit_card';
      case AppIlustrations.underConstruction:
        return 'under_construction';
      case AppIlustrations.creativeTeam:
        return 'creative_team';
      case AppIlustrations.post:
        return 'post';
      case AppIlustrations.images:
        return 'images';
    }
  }
}
