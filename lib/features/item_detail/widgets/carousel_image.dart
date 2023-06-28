import 'package:auction_repository/auction_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/item_detail/item_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      builder: (context, state) {
        if (state is ItemDetailLoading || state is ItemDetailDeleted) {
          return const ShimmerCarousel();
        } else if (state is ItemDetailError) {
          return AspectRatio(
            aspectRatio: 6 / 4,
            child: ErrorNoImage(message: state.messages.join('\n')),
          );
        }

        state as ItemDetailLoaded;

        if (state.item.images.isEmpty) {
          return const AspectRatio(
            aspectRatio: 6 / 4,
            child: ErrorNoImage(message: "No Image"),
          );
        } else if (state.item.images.length == 1) {
          return AspectRatio(
            aspectRatio: 6 / 4,
            child: Image.network(
              state.item.images[0].url,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<CarouselCubit, CarouselState>(
                builder: (context, state) {
                  CarouselController controller = context.read<CarouselCubit>().controller;
                  return CarouselSlider(
                    carouselController: controller,
                    options: CarouselOptions(
                      aspectRatio: 6 / 4,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      onPageChanged: (index, reason) {
                        context.read<CarouselCubit>().changeCarouselPage(index);
                      },
                    ),
                    items: getCarouselItem(),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: item.images.asMap().entries.map((entry) {
                  return BlocBuilder<CarouselCubit, CarouselState>(
                    builder: (context, state) {
                      CarouselController controller = context.read<CarouselCubit>().controller;

                      final bool selected = state.currentCarouselIndex == entry.key;

                      return GestureDetector(
                        onTap: () => controller.animateToPage(entry.key),
                        child: Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black87, width: 2),
                            color: selected ? theme.colorScheme.primaryContainer : theme.colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget> getCarouselItem() {
    return item.images.map((e) {
      return AspectRatio(
        aspectRatio: 6 / 4,
        child: Image.network(
          e.url,
          fit: BoxFit.cover,
        ),
      );
    }).toList();
  }
}
