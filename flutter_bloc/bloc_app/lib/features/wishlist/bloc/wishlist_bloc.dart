import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/wishlist_item.dart';
import 'package:bloc_app/features/home/models/my_home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  Map<int, ProductDataModel> _removedItems = {}; // Map to store original index and removed item

  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItem: wishlistItem));
  }


  FutureOr<void> wishlistRemoveFromWishlistEvent(WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    final removedIndex = wishlistItem.indexOf(event.productDataModel);
    _removedItems[removedIndex] = event.productDataModel; // Store original index and removed item
    wishlistItem.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItem: wishlistItem));
    emit(WishlistRemoveActionState());
  }

  void undo() { 
    if (_removedItems.isNotEmpty) {
      final removedIndex = _removedItems.keys.first;
      final removedItem = _removedItems.remove(removedIndex)!;
      wishlistItem.insert(removedIndex, removedItem); // Insert item back into original index
      add(WishlistInitialEvent()); // Notify listeners about the change
    }
  }
}
