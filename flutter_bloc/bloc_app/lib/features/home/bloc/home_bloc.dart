import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/cart_items.dart';
import 'package:bloc_app/data/grocery_data.dart';
import 'package:bloc_app/data/wishlist_item.dart';
import 'package:bloc_app/features/home/models/my_home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadingSuccessState(
        products: GroceryData.groceryProducts.map(
          (e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            imageUrl: e['imageUrl'],
          ),
        ).toList(),
      ),
    );
  }

  FutureOr<void> homeProductWishListButtonClickedEvent( // product list clicking
      HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist product clicked');  
    wishlistItem.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent( // product list clicking
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart product clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(  // app bar navigation
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist button clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent( // app bar navigation 
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart button clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
