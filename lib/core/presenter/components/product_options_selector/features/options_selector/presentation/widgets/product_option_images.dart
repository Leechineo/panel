import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';

class ProductOptionImages extends StatefulWidget {
  final List<String> images;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductOptionImages({
    required this.images,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  State<ProductOptionImages> createState() => _ProductOptionImagesState();
}

class _ProductOptionImagesState extends State<ProductOptionImages> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 12,
          ),
          child: FilledButton(
            onPressed: carouselController.previousPage,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 200,
            height: 200,
            child: CarouselSlider(
              carouselController: carouselController,
              items: widget.images.map(
                (imageId) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.getFileUrlUseCase(imageId),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                reverse: false,
                height: 200,
                autoPlay: false,
                enlargeCenterPage: false,
                // aspectRatio: 2.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: FilledButton(
            onPressed: carouselController.nextPage,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        )
      ],
    );
  }
}
