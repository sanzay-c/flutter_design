import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/cart_items.dart';
import 'package:bloc_app/features/home/models/my_home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Map<int, ProductDataModel> _removedItems = {}; // Map to store original index and removed item
  
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    final removedIndex = cartItems.indexOf(event.productDataModel);
    _removedItems[removedIndex] = event.productDataModel; // Store original index and removed item
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
    emit(CartRemoveActionState());
  }
  
  void undo() {
    if (_removedItems.isNotEmpty) {
      final removedIndex = _removedItems.keys.first;
      final removedItem = _removedItems.remove(removedIndex)!;
      cartItems.insert(removedIndex, removedItem); // Insert item back into original index
      add(CartInitialEvent()); // Notify listeners about the change
    }
  }
}
