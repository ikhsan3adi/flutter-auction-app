import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ExploreBloc>().add(ExploreFetchAuctionEvent());
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LATEST AUCTION CAROUSEL
            BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state is ExploreLoading || state is ExploreInitial) {
                  return const ShimmerCarousel();
                } else if (state is ExploreError) {
                  return _errorHeroWidget(msg: state.messages[0]);
                }

                state as ExploreLoaded;

                return BlocProvider(
                  create: (context) => CarouselCubit(controller: CarouselController()),
                  child: HeroProductCarousel(latestAuctionList: state.latestAuctionList),
                );
              },
            ),
            // RANDOM AUCTION (YOU MIGHT LIKE)
            BlocBuilder<ExploreBloc, ExploreState>(
              buildWhen: (previous, current) {
                if (previous is ExploreLoaded && current is ExploreLoaded) {
                  return current.randomAuctionList != previous.randomAuctionList;
                }
                return current != previous;
              },
              builder: (context, state) {
                if (state is ExploreLoading || state is ExploreInitial) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SectionTitle(text: "You might like"),
                      _YouMightLikeLoading(),
                    ],
                  );
                } else if (state is ExploreError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 365,
                          child: Text(state.messages[0]),
                        ),
                      ),
                    ],
                  );
                }

                state as ExploreLoaded;

                return state.randomAuctionList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SectionTitle(text: "You might like"),
                          _YouMightLike(randomAuctionList: state.randomAuctionList),
                        ],
                      )
                    : const SizedBox.expand();
              },
            ),
            // OTHER AUCTION
            BlocBuilder<ExploreBloc, ExploreState>(
              buildWhen: (previous, current) {
                if (previous is ExploreLoaded && current is ExploreLoaded) {
                  return current.otherAuctionList != previous.otherAuctionList;
                }
                return current != previous;
              },
              builder: (context, state) {
                if (state is ExploreLoading || state is ExploreInitial) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SectionTitle(text: "Explore"),
                      _ExploreListViewLoading(),
                    ],
                  );
                } else if (state is ExploreError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 365,
                          child: Text(state.messages[0]),
                        ),
                      ),
                    ],
                  );
                }

                state as ExploreLoaded;

                return state.otherAuctionList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SectionTitle(text: "Explore"),
                          _ExploreListView(otherAuctionList: state.otherAuctionList),
                        ],
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorHeroWidget({required String msg}) => _UnloadedHeroWidget(child: Text(msg));
}

class _UnloadedHeroWidget extends StatelessWidget {
  const _UnloadedHeroWidget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 4,
      child: Container(
        color: Theme.of(context).disabledColor,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class _YouMightLike extends StatelessWidget {
  const _YouMightLike({required this.randomAuctionList});

  final List<Auction> randomAuctionList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: randomAuctionList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: index == 0 ? const EdgeInsets.only(left: 16, right: 8) : const EdgeInsets.symmetric(horizontal: 8),
            child: ProductCard(item: randomAuctionList[index]),
          );
        },
      ),
    );
  }
}

class _YouMightLikeLoading extends StatelessWidget {
  const _YouMightLikeLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (_, index) {
          return Padding(
            padding: index == 0 ? const EdgeInsets.only(left: 16, right: 8) : const EdgeInsets.symmetric(horizontal: 8),
            child: const ShimmerProductCard(),
          );
        },
      ),
    );
  }
}

class _ExploreListView extends StatelessWidget {
  const _ExploreListView({required this.otherAuctionList});

  final List<Auction> otherAuctionList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: otherAuctionList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ExploreListTile(item: otherAuctionList[index]),
        );
      },
    );
  }
}

class _ExploreListViewLoading extends StatelessWidget {
  const _ExploreListViewLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (_, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ShimmerProductListTile(),
        );
      },
    );
  }
}
