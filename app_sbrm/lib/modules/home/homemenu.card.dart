import 'package:app_sbrm/modules/home/homemenu.model.dart';
import 'package:flutter/material.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key, required this.catalogItem});

  final MenuItemModel catalogItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.asset(
              catalogItem.photoUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            catalogItem.name,
            style: theme.textTheme.titleLarge,
            maxLines: 1,
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
