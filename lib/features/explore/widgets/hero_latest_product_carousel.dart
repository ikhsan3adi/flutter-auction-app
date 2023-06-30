import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroProductCarousel extends StatelessWidget {
  const HeroProductCarousel({super.key, required this.latestAuctionList});

  final List<Auction> latestAuctionList;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
          children: latestAuctionList.asMap().entries.map((entry) {
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

  List<Widget> getCarouselItem() {
    return latestAuctionList.map((element) {
      return Builder(builder: (context) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed<bool?>(context, AuctionDetailPage.routeName, arguments: element).then((value) {
              if ((value ?? false) && context.read<ExploreBloc>().state is ExploreLoaded) {
                context.read<ExploreBloc>().add(ExploreFetchAuctionEvent());
              }
            });
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _HeroImage(item: element),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, AuctionDetailPage.routeName, arguments: element),
                  ),
                ),
              ),
              _HeroBottomText(item: element),
            ],
          ),
        );
      });
    }).toList();
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: item.images.isNotEmpty
          ? Image.network(
              item.images[0].url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const ErrorNoImage(message: 'Image error'),
            )
          : const ErrorNoImage(),
    );
  }
}

class _HeroBottomText extends StatelessWidget {
  const _HeroBottomText({required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeroTitle(item: item),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle({required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            color: theme.colorScheme.primary,
            child: Text(
              "New",
              style: textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 3),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: Colors.black87,
            child: Text(
              item.itemName,
              style: textTheme.headlineMedium!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
