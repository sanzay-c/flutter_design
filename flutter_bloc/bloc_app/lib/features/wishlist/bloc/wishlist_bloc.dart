import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/wishlist_item.dart';
import 'package:bloc_app/features/home/models/my_home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItem: wishlistItem));
  }


  FutureOr<void> wishlistRemoveFromWishlistEvent(WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItem.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItem: wishlistItem));
    emit(WishlistRemoveActionState());
  }
}
