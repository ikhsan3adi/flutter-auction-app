import 'package:aplikasi_lelang_online/features/auction_detail/auction_detail.dart';
import 'package:auction_api/auction_api.dart';
import 'package:aplikasi_lelang_online/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroProductCarousel extends StatelessWidget {
  const HeroProductCarousel({super.key, required this.latestLelangList});

  final List<Auction> latestLelangList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BlocBuilder<CarouselCubit, CarouselState>(
          builder: (context, state) {
            CarouselController controller = context.read<CarouselCubit>().controller;
            return CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                aspectRatio: 5 / 4,
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
          children: latestLelangList.asMap().entries.map((entry) {
            return BlocBuilder<CarouselCubit, CarouselState>(
              builder: (context, state) {
                CarouselController controller = context.read<CarouselCubit>().controller;
                return GestureDetector(
                  onTap: () => controller.animateToPage(entry.key),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black87, width: 2),
                      color: state.currentCarouselIndex == entry.key ? Colors.purpleAccent : Colors.white,
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
    return latestLelangList.map((element) {
      return Builder(builder: (context) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, AuctionDetailPage.routeName, arguments: element),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _HeroImage(item: element),
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
    return const AspectRatio(
      aspectRatio: 5 / 4,
      child: Placeholder(),
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            color: Colors.purpleAccent,
            child: Text(
              "Terbaru",
              style: textTheme.titleMedium!.copyWith(color: Colors.white),
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
