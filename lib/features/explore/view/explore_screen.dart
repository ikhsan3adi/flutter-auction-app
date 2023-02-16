import 'package:aplikasi_lelang_online/features/explore/explore.dart';
import 'package:aplikasi_lelang_online/models/models.dart';
import 'package:aplikasi_lelang_online/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, required this.lelangList});

  final List<Lelang> lelangList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider(
            create: (context) => CarouselCubit(controller: CarouselController()),
            child: HeroProductCarousel(latestLelangList: getLatestLelang(lelangList)),
          ),
          const SectionTitle(text: "Mungkin kamu suka"),
          _YouMightLike(randomLelangList: getRandomLelang(lelangList)),
          const SectionTitle(text: "Jelajahi"),
          _ExploreListView(otherLelangList: getOtherLelang(lelangList)),
        ],
      ),
    );
  }

  List<Lelang> getLatestLelang(List<Lelang> listLelang) {
    return listLelang;
  }

  List<Lelang> getRandomLelang(List<Lelang> listLelang) {
    return listLelang;
  }

  List<Lelang> getOtherLelang(List<Lelang> listLelang) {
    return listLelang;
  }
}

class _YouMightLike extends StatelessWidget {
  const _YouMightLike({required this.randomLelangList});

  final List<Lelang> randomLelangList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: randomLelangList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: index == 0 ? const EdgeInsets.only(left: 16, right: 8) : const EdgeInsets.symmetric(horizontal: 8),
            child: ProductCard(item: randomLelangList[index]),
          );
        },
      ),
    );
  }
}

class _ExploreListView extends StatelessWidget {
  const _ExploreListView({required this.otherLelangList});

  final List<Lelang> otherLelangList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: otherLelangList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ExploreListTile(item: otherLelangList[index]),
        );
      },
    );
  }
}
