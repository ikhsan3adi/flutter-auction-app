import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final ScrollController _controller = ScrollController();

  void onScroll(BuildContext ctx) {
    if (_controller.hasClients) {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;

      if (currentScroll >= maxScroll) ctx.read<ExploreBloc>().add(ExploreFetchMoreAuctionEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => onScroll(context));
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ExploreBloc>().add(ExploreFetchAuctionEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LATEST AUCTION CAROUSEL
            BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state is ExploreLoading || state is ExploreInitial) {
                  return const ShimmerCarousel();
                } else if (state is ExploreError) {
                  return ErrorExploreCarousel(message: state.messages[0]);
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
                  return SizedBox(
                    height: 365,
                    child: ErrorCommon(message: state.messages[0]),
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
                  return current.otherAuctionList != previous.otherAuctionList || current.hasReachedMax != previous.hasReachedMax;
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
                  return const SizedBox();
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
    final state = context.read<ExploreBloc>().state as ExploreLoaded;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: otherAuctionList.length + 1,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: index < otherAuctionList.length ? ExploreListTile(item: otherAuctionList[index]) : _loading(reachedMax: state.hasReachedMax),
        );
      },
    );
  }

  Widget _loading({required bool reachedMax}) {
    return Center(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reachedMax ? const Text("No more data available") : const CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
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
