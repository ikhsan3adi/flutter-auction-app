import 'dart:ui';

import 'package:aplikasi_lelang_online/features/auction_detail/auction_detail.dart';
import 'package:aplikasi_lelang_online/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroProductImage extends StatelessWidget {
  const HeroProductImage({super.key});

  final double bottomImageMargin = 60;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
      builder: (context, state) {
        if (state is AuctionDetailLoaded) {
          if (state.lelang.imageUrls.isEmpty) {
            return _NoImageWidget(bottomImageMargin: bottomImageMargin, msg: "Gambar tidak tersedia");
          } else if (state.lelang.imageUrls.length == 1) {
            return _SingleImageWidget(
              imageUrl: state.lelang.imageUrls[0],
              bottomImageMargin: bottomImageMargin,
            );
          } else {
            return BlocProvider(
              create: (context) => CarouselCubit(controller: CarouselController()),
              child: _MultipleCarouselImage(
                imageUrls: state.lelang.imageUrls,
                bottomImageMargin: bottomImageMargin,
              ),
            );
          }
        } else if (state is AuctionDetailLoading) {
          return Container(
            color: Colors.grey,
            child: const CircularProgressIndicator.adaptive(),
          );
        }

        return _NoImageWidget(bottomImageMargin: bottomImageMargin, msg: "Gagal memuat gambar");
      },
    );
  }
}

class _NoImageWidget extends StatelessWidget {
  const _NoImageWidget({required this.bottomImageMargin, required this.msg});

  final double bottomImageMargin;

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _ImageWithBackground(
          bottomImageMargin: bottomImageMargin,
        ),
        Text(msg),
      ],
    );
  }
}

class _SingleImageWidget extends StatelessWidget {
  const _SingleImageWidget({
    required this.imageUrl,
    required this.bottomImageMargin,
  });

  final double bottomImageMargin;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return _ImageWithBackground(
      bottomImageMargin: bottomImageMargin,
      imageProvider: const AssetImage("assets/images/bg.jpg"),
      // imageProvider: NetworkImage(imageUrl),
    );
  }
}

class _MultipleCarouselImage extends StatelessWidget {
  const _MultipleCarouselImage({
    required this.imageUrls,
    required this.bottomImageMargin,
  });

  final List<String> imageUrls;

  final double bottomImageMargin;

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
              items: getCarouselItem(imageUrls),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: kToolbarHeight, bottom: bottomImageMargin / 2),
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

  List<Widget> getCarouselItem(List<String> imageUrls) {
    return imageUrls.map((element) {
      return Builder(
        builder: (context) {
          return _ImageWithBackground(
            bottomImageMargin: bottomImageMargin,
            imageProvider: const AssetImage("assets/images/bg.jpg"),
            // imageProvider: NetworkImage(element),
          );
        },
      );
    }).toList();
  }
}

class _ImageWithBackground extends StatelessWidget {
  const _ImageWithBackground({
    required this.bottomImageMargin,
    this.imageProvider,
  });

  final double bottomImageMargin;

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: imageProvider == null ? Colors.black54 : null,
            image: imageProvider != null
                ? DecorationImage(
                    image: imageProvider!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageProvider != null
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(decoration: const BoxDecoration(color: Colors.black38)),
                )
              : null,
        ),
        Padding(
          padding: EdgeInsets.only(top: 75, bottom: bottomImageMargin),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: imageProvider == null ? Colors.black38 : null,
              borderRadius: BorderRadius.circular(12),
              image: imageProvider != null
                  ? DecorationImage(
                      image: imageProvider!,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
