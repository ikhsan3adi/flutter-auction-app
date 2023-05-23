import 'package:auction_repository/auction_repository.dart';
import 'package:blur/blur.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroProductImage extends StatelessWidget {
  const HeroProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
      builder: (context, state) {
        if (state is AuctionDetailLoading) {
          return const ShimmerDetailCarousel();
        } else if (state is AuctionDetailError) {
          return _ImageWithBackground(errorMessage: state.messages.join('\n'));
        }

        state as AuctionDetailLoaded;

        if (state.auction.images.isEmpty) {
          return const _ImageWithBackground();
        } else if (state.auction.images.length == 1) {
          return _ImageWithBackground(imageUrl: state.auction.images[0].url);
        } else {
          return BlocProvider(
            create: (context) => CarouselCubit(controller: CarouselController()),
            child: _MultipleCarouselImage(images: state.auction.images),
          );
        }
      },
    );
  }
}

class _MultipleCarouselImage extends StatelessWidget {
  const _MultipleCarouselImage({required this.images});

  final List<ItemImage> images;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<CarouselCubit, CarouselState>(
          builder: (context, state) {
            return CarouselSlider(
              carouselController: context.read<CarouselCubit>().controller,
              options: CarouselOptions(
                aspectRatio: 0.75,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  context.read<CarouselCubit>().changeCarouselPage(index);
                },
              ),
              items: _buildCarouselItem(images),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight,
            bottom: AuctionDetailConstant.bottomImageMargin / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 15),
                onPressed: () {
                  context.read<CarouselCubit>().controller.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 15),
                onPressed: () {
                  context.read<CarouselCubit>().controller.nextPage();
                },
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCarouselItem(List<ItemImage> images) {
    return images.map((element) {
      return Builder(
        builder: (context) => _ImageWithBackground(imageUrl: element.url),
      );
    }).toList();
  }
}

class _ImageWithBackground extends StatelessWidget {
  const _ImageWithBackground({this.imageUrl, this.errorMessage});

  final String? imageUrl;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 0.75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl != null
              ? FittedBox(
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.cover,
                  child: Image.network(
                    imageUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: theme.colorScheme.error);
                    },
                  ).blurred(
                    blur: 10,
                    blurColor: Colors.black12,
                  ),
                )
              : Container(color: theme.colorScheme.error),
          Padding(
            padding: EdgeInsets.only(top: 75, bottom: AuctionDetailConstant.bottomImageMargin),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, _) => ErrorNoImage(message: error.toString()),
                        )
                      : ErrorNoImage(message: errorMessage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
