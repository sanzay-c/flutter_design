import 'package:bloc_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_app/features/home/models/my_home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatefulWidget {
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.productDataModel.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.productDataModel.description),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${widget.productDataModel.price.toString()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isButtonClicked = true;
                      });
                      widget.homeBloc.add(
                        HomeProductWishListButtonClickedEvent(
                          clickedProduct: widget.productDataModel,
                        ),
                      );
                    },
                    icon: AnimatedOpacity(
                      opacity: isButtonClicked ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 700),
                      child: const Icon(
                        Icons.favorite_border_outlined,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: widget.productDataModel,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// for controller (this is for animation)
/**
 *  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

 */


// for onPressed:
/**
 * IconButton(
    onPressed: () {
     _toggleFavorite();
      _controller.reset();
      _controller.forward();
      widget.homeBloc.add(
        HomeProductWishListButtonClickedEvent(
          clickedProduct: widget.productDataModel,
        ),
      );
    },
     icon: AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
      child: _isFavorite
          ? const Icon(
              Icons.favorite,
              key: ValueKey("favorite"),
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border_outlined,
              key: ValueKey("notFavorite"),
            ),
    ),
*/
