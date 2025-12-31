import 'package:flutter/material.dart';
import 'package:get_app/domain/entities/venue_entity.dart';

class VenueDetails extends StatefulWidget {
  const VenueDetails({super.key, required this.venue});

  final VenueEntity venue;

  @override
  State<VenueDetails> createState() => _VenueDetailsState();
}

class _VenueDetailsState extends State<VenueDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.venue.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(widget.venue.description),
          Text(widget.venue.address),
          Text(widget.venue.status),

          Image.network(widget.venue.venueImagePaths.first),

          Text(widget.venue.startingPrice),
          Text(widget.venue.menuPrice),
          Text(widget.venue.maxCapacity),
        ],
      ),
    );
  }
}