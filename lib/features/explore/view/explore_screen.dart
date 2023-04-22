import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:auction_api/auction_api.dart';
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
                  return _loadingHeroWidget();
                } else if (state is ExploreError) {
                  return _errorHeroWidget(msg: state.msg);
                }

                state as ExploreLoaded;

                return BlocProvider(
                  create: (context) => CarouselCubit(controller: CarouselController()),
                  child: HeroProductCarousel(latestLelangList: state.latestAuctionList),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SectionTitle(text: "Mungkin kamu suka"),
                      Center(
                        child: SizedBox(
                          height: 330,
                          child: Center(child: CircularProgressIndicator.adaptive()),
                        ),
                      ),
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
                          child: Text(state.msg),
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
                          const SectionTitle(text: "Mungkin kamu suka"),
                          _YouMightLike(randomAuctionList: state.randomAuctionList),
                        ],
                      )
                    : const SizedBox();
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SectionTitle(text: "Jelajahi"),
                      Center(
                        child: SizedBox(
                          height: 330,
                          child: Center(child: CircularProgressIndicator.adaptive()),
                        ),
                      ),
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
                          child: Text(state.msg),
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
                          const SectionTitle(text: "Jelajahi"),
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

  Widget _loadingHeroWidget() => const _UnloadedHeroWidget(child: CircularProgressIndicator.adaptive());

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
