import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit({required this.controller}) : super(const CarouselInitial());

  final CarouselController controller;

  void changeCarouselPage(int index) {
    emit(CarouselLoaded(index: index));
  }
}

abstract class CarouselState extends Equatable {
  const CarouselState({required this.currentCarouselIndex});

  final int currentCarouselIndex;

  @override
  List<Object> get props => [currentCarouselIndex];
}

class CarouselInitial extends CarouselState {
  const CarouselInitial() : super(currentCarouselIndex: 0);

  @override
  List<Object> get props => [currentCarouselIndex];
}

class CarouselLoaded extends CarouselState {
  const CarouselLoaded({required int index}) : super(currentCarouselIndex: index);

  @override
  List<Object> get props => [currentCarouselIndex];
}
