import 'package:flutter/material.dart';

import '../models/outlet_model.dart';

class OutletCard extends StatelessWidget {
  final Outlet outlet;

  const OutletCard({Key? key, required this.outlet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(outlet.imageUrl), // Display the outlet image
        title: Text(outlet.name),
        subtitle: Text(outlet.address),
        // ... add other relevant details (distance, rating, etc.)
      ),
    );
  }
}
